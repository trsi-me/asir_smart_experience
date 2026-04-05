# -*- coding: utf-8 -*-
"""
Flask API - خادم عسير الذكية
يوفر توصيات ذكية مبنية على نموذج التوصيات
"""

from flask import Flask, request, jsonify
from flask_cors import CORS
from recommendation_engine import SmartRecommendationEngine

app = Flask(__name__)
CORS(app, origins=['*'])
engine = SmartRecommendationEngine()


@app.route('/api/health', methods=['GET'])
def health():
    """فحص حالة الخادم"""
    return jsonify({'status': 'ok', 'message': 'عسير الذكية جاهز'})


@app.route('/api/recommend/today', methods=['POST'])
def recommend_today():
    """
    توصيات وش فيه اليوم - ذكية 100%
    Body: {"weather": "مشمس", "preferences": ["عائلية", "طبيعة"]}
    """
    data = request.get_json() or {}
    weather = data.get('weather', 'مشمس')
    preferences = data.get('preferences', ['عائلية', 'طبيعة'])
    results = engine.recommend_today(weather=weather, user_preferences=preferences)
    return jsonify({'events': results})


@app.route('/api/recommend/weather', methods=['POST'])
def recommend_weather():
    """
    توصيات جوّك اليوم حسب الطقس
    Body: {"weather": "ضباب"}
    """
    data = request.get_json() or {}
    weather = data.get('weather', 'مشمس')
    results = engine.recommend_by_weather(weather)
    return jsonify(results)


@app.route('/api/recommend/booking', methods=['POST'])
def recommend_booking():
    """
    الميزة الذكية: عند الحجز - اقتراح السكن والمواصلات تلقائياً
    Body: {"experience": "مهرجان الضباب", "location": "أبها"}
    """
    data = request.get_json() or {}
    experience = data.get('experience', '')
    location = data.get('location', 'أبها')

    accommodation = [
        {'name': 'فنادق', 'count': '٢٥', 'near': location},
        {'name': 'أكواخ', 'count': '١٥', 'near': location},
        {'name': 'بيوت تراثية', 'count': '١٠', 'near': location},
    ]
    transport = [
        {'name': 'تأجير سيارات'},
        {'name': 'مرشدين سياحيين'},
        {'name': 'مسارات جاهزة'},
    ]
    return jsonify({
        'accommodation': accommodation,
        'transport': transport,
    })


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
