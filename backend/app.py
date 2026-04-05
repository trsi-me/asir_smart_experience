# -*- coding: utf-8 -*-
"""
Flask - عسير الذكية: API + خدمة ملفات Flutter Web من مجلد web/
"""

import os

from flask import Flask, jsonify, request, send_from_directory
from flask_cors import CORS
from recommendation_engine import SmartRecommendationEngine

# مجلد ناتج: انسخ محتوى flutter build/web إلى backend/web قبل النشر
WEB_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), 'web'))

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


def _safe_file_path(relative_path):
    """يمنع الخروج من مجلد web/"""
    if not relative_path:
        return os.path.join(WEB_DIR, 'index.html')
    joined = os.path.normpath(os.path.join(WEB_DIR, relative_path))
    if not joined.startswith(WEB_DIR + os.sep) and joined != WEB_DIR:
        return os.path.join(WEB_DIR, 'index.html')
    return joined


@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def serve_flutter(path):
    """يخدم ملفات Flutter؛ أي مسار غير ملف حقيقي يرجع index.html (للتوجيه داخل التطبيق)."""
    if not os.path.isdir(WEB_DIR) or not os.path.isfile(os.path.join(WEB_DIR, 'index.html')):
        return (
            '<html><body dir="rtl" style="font-family:sans-serif;padding:2rem">'
            '<p>مجلد <code>backend/web</code> فارغ.</p>'
            '<p>انسخ محتوى <code>build/web</code> من Flutter إلى <code>backend/web</code> ثم أعد التشغيل.</p>'
            '</body></html>',
            503,
        )

    full = _safe_file_path(path)
    if path and os.path.isfile(full):
        rel = os.path.relpath(full, WEB_DIR)
        return send_from_directory(WEB_DIR, rel)

    return send_from_directory(WEB_DIR, 'index.html')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
