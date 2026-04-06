import 'package:flutter/foundation.dart' show kIsWeb;

import 'api_config.dart';

/// على الويب، الصور الخارجية تُحمّل عبر خادمك (نفس النطاق) لتفادي CORS.
/// على الموبايل تُستخدم الروابط الأصلية مباشرة.
String proxiedImageUrl(String url) {
  if (!kIsWeb || url.isEmpty) return url;
  if (!url.startsWith('http://') && !url.startsWith('https://')) return url;
  final base = ApiConfig.baseUrl.replaceAll(RegExp(r'/$'), '');
  return '$base/api/remote-image?u=${Uri.encodeComponent(url)}';
}
