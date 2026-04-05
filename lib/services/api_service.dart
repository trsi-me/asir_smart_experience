import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';

/// خدمة الاتصال بـ API الذكي
class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  bool _serverAvailable = true;

  bool get serverAvailable => _serverAvailable;

  Future<Map<String, dynamic>?> _get(String path) async {
    try {
      final res = await http
          .get(Uri.parse('${ApiConfig.baseUrl}$path'))
          .timeout(ApiConfig.timeout);
      _serverAvailable = res.statusCode == 200;
      if (res.statusCode == 200) {
        return jsonDecode(res.body) as Map<String, dynamic>;
      }
      return null;
    } catch (_) {
      _serverAvailable = false;
      return null;
    }
  }

  Future<Map<String, dynamic>?> _post(String path, Map<String, dynamic> body) async {
    try {
      final res = await http
          .post(
            Uri.parse('${ApiConfig.baseUrl}$path'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(ApiConfig.timeout);
      _serverAvailable = res.statusCode == 200;
      if (res.statusCode == 200) {
        return jsonDecode(res.body) as Map<String, dynamic>;
      }
      return null;
    } catch (_) {
      _serverAvailable = false;
      return null;
    }
  }

  Future<bool> checkHealth() async {
    final r = await _get('/api/health');
    return r != null && r['status'] == 'ok';
  }

  /// توصيات وش فيه اليوم - ذكية من الخادم
  Future<List<Map<String, dynamic>>?> getSmartTodayRecommendations({
    String weather = 'مشمس',
    List<String> preferences = const ['عائلية', 'طبيعة'],
  }) async {
    final r = await _post('/api/recommend/today', {
      'weather': weather,
      'preferences': preferences,
    });
    if (r == null) return null;
    final events = r['events'] as List?;
    return events?.cast<Map<String, dynamic>>();
  }

  /// توصيات جوّك اليوم
  Future<Map<String, dynamic>?> getWeatherRecommendations(String weather) async {
    return _post('/api/recommend/weather', {'weather': weather});
  }

  /// اقتراحات الحجز الذكية
  Future<Map<String, dynamic>?> getBookingSuggestions(String experience, String location) async {
    return _post('/api/recommend/booking', {
      'experience': experience,
      'location': location,
    });
  }
}
