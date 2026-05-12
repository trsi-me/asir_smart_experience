# -*- coding: utf-8 -*-
"""
محرك التوصيات الذكي - نموذج ذكاء اصطناعي للتخصيص الدقيق
يستخدم خوارزميات تحليل المحتوى والفلترة القائمة على القواعد
"""

import json
from datetime import datetime
from pathlib import Path

# بيانات المعرفة لتحسين التوصيات
SEASON_MONTHS = {
    'fog': [12, 1, 2],
    'summer': [6, 7, 8],
    'winter': [12, 1, 2],
    'coffee': [9, 10, 11],
    'camping': [3, 4, 5],
    'events': list(range(1, 13)),
}

WEATHER_SUGGESTIONS = {
    'مشمس': ['مشي', 'شلالات', 'غابات', 'تصوير', 'قهوة', 'تراث'],
    'ضباب': ['قهوة', 'متاحف', 'قرى تراثية', 'فعاليات داخلية'],
    'ممطر': ['متاحف', 'مقاهي', 'أسر منتجة', 'حرف يدوية'],
    'غائم': ['مشي خفيف', 'شلالات', 'تخييم', 'سواحل'],
}

EXPERIENCE_TAGS = {
    'مهرجان الضباب': ['ضباب', 'فعاليات', 'عائلية'],
    'عرض تراثي': ['تراث', 'ثقافة', 'عائلية'],
    'ورشة حرف يدوية': ['تراث', 'تفاعلي', 'عائلية'],
    'سوق الجمعة': ['تسوق', 'محلي', 'عائلة'],
    'مسار شلالات حدي': ['طبيعة', 'مشي', 'سهل'],
    'مزرعة بن الدوسري': ['قهوة', 'زراعي', 'تجربة'],
    'قرية رجال ألمع': ['تراث', 'ثقافة', 'تاريخ'],
    'مخيم السودة': ['تخييم', 'طبيعة', 'ليلي'],
}


class SmartRecommendationEngine:
    """محرك توصيات ذكي يعتمد على الموسم والطقس والتخصص"""

    def __init__(self):
        self.current_month = datetime.now().month

    def _get_current_season(self) -> str:
        """تحديد الموسم الحالي بدقة"""
        for season, months in SEASON_MONTHS.items():
            if self.current_month in months:
                return season
        return 'events'

    def _score_experience(self, exp_tags: list, weather: str, season: str, preferences: list) -> float:
        """حساب درجة المطابقة (0-100) للتوصية"""
        score = 50.0  # نقطة أساسية
        weather_suggestions = WEATHER_SUGGESTIONS.get(weather, WEATHER_SUGGESTIONS['مشمس'])

        for tag in exp_tags:
            if tag in weather_suggestions:
                score += 15
            if tag in preferences:
                score += 20
            if season == 'fog' and tag == 'ضباب':
                score += 15
            if season == 'coffee' and tag == 'قهوة':
                score += 15
            if season == 'camping' and tag == 'تخييم':
                score += 15

        return min(100.0, score)

    def recommend_today(self, weather: str = 'مشمس', user_preferences: list = None) -> list:
        """توصيات 'وش فيه اليوم' مبنية على الطقس والتفضيلات"""
        user_preferences = user_preferences or ['عائلية', 'طبيعة']
        season = self._get_current_season()

        events = [
            {'id': '1', 'title': 'مهرجان الضباب', 'time': '٩ ص - ٦ م', 'location': 'أبها', 'score': 0},
            {'id': '2', 'title': 'عرض تراثي', 'time': '٤ م - ٨ م', 'location': 'رجال ألمع', 'score': 0},
            {'id': '3', 'title': 'ورشة حرف يدوية', 'time': '١٠ ص - ٢ م', 'location': 'السودة', 'score': 0},
            {'id': '4', 'title': 'جولة شلالات', 'time': '٨ ص - ١٢ م', 'location': 'حدي', 'score': 0},
            {'id': '5', 'title': 'تذوق البن العسيري', 'time': '٣ م - ٦ م', 'location': 'أبها', 'score': 0},
        ]

        for e in events:
            tags = EXPERIENCE_TAGS.get(e['title'], ['عائلي'])
            e['score'] = self._score_experience(tags, weather, season, user_preferences)
            e['reason'] = self._get_reason(tags, weather, season)

        events.sort(key=lambda x: x['score'], reverse=True)
        return events[:5]

    def _get_reason(self, tags: list, weather: str, season: str) -> str:
        """شرح سبب التوصية للشفافية"""
        reasons = []
        if weather in ['مشمس', 'غائم'] and ('مشي' in tags or 'شلالات' in tags):
            reasons.append('الطقس مناسب للخروج')
        if weather == 'ضباب' and 'قهوة' in tags:
            reasons.append('ضباب عسير مع قهوة')
        if season == 'coffee' and 'قهوة' in tags:
            reasons.append('موسم البن')
        if 'تراث' in tags:
            reasons.append('تجربة تراثية أصيلة')
        return '، '.join(reasons) if reasons else 'مقترح لك'

    def recommend_by_weather(self, weather: str) -> dict:
        """توصيات جوّك اليوم - دقيقة حسب الطقس"""
        suggestions = WEATHER_SUGGESTIONS.get(weather, WEATHER_SUGGESTIONS['مشمس'])
        alerts = []
        if weather == 'ضباب':
            alerts.append('توقعات ضباب - ينصح بتأخير الرحلات الصباحية')
        if weather == 'ممطر':
            alerts.append('أمطار متوقعة - تجنب المسارات الجبلية')

        return {
            'suggestions': suggestions,
            'alerts': alerts,
            'best_activities': self._map_to_activities(suggestions),
        }

    def _map_to_activities(self, suggestions: list) -> list:
        """ربط التوصيات بأنشطة فعلية"""
        mapping = {
            'مشي': {'name': 'مسارات طبيعية', 'places': ['شلالات حدي', 'غابة رغدان']},
            'شلالات': {'name': 'زيارة الشلالات', 'places': ['وادي حدي', 'وادي شريان']},
            'قهوة': {'name': 'تجربة القهوة', 'places': ['مزارع البن', 'قهوة رجال ألمع']},
            'تراث': {'name': 'القرى التراثية', 'places': ['رجال ألمع', 'متاحف أبها']},
            'تخييم': {'name': 'التخييم', 'places': ['مخيم السودة', 'رغدان']},
            'سواحل': {'name': 'السواحل', 'places': ['القحمة', 'البرك']},
        }
        return [mapping.get(s, {'name': s, 'places': []}) for s in suggestions if s in mapping]
