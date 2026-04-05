/// إعدادات الاتصال بالخادم (Flask)
/// المحاكي: 10.0.2.2 | الجهاز الحقيقي: IP الكمبيوتر
class ApiConfig {
  static const String baseUrl = 'http://10.0.2.2:5000';
  static const Duration timeout = Duration(seconds: 10);
}
