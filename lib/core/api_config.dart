/// إعدادات الاتصال بالخادم (Flask)
///
/// - أندرويد (افتراضي): `http://10.0.2.2:5000`
/// - ويب محلي: `--dart-define=API_BASE_URL=http://localhost:5000`
/// - ويب على Render (نفس خدمة Flask): `--dart-define=API_BASE_URL=https://اسم-الخدمة.onrender.com`
///   (بدون / في النهاية)
class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:5000',
  );

  static const Duration timeout = Duration(seconds: 10);
}
