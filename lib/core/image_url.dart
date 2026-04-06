import 'package:flutter/foundation.dart' show kIsWeb;

import 'api_config.dart';

/// على الويب، الصور الخارجية تُحمّل عبر خادمك (نفس النطاق) لتفادي CORS.
/// على الموبايل تُستخدم الروابط الأصلية مباشرة.
///
/// في الإنتاج (أي صفحة ليست localhost) نستخدم مساراً نسبياً `/api/remote-image`
/// حتى تعمل الصور حتى لو كان [ApiConfig.baseUrl] غير مضبوط (مثلاً 10.0.2.2).
/// محلياً نستخدم [ApiConfig.baseUrl] لأن Flutter غالباً على منفذ غير Flask.
String proxiedImageUrl(String url) {
  if (!kIsWeb || url.isEmpty) return url;
  if (!url.startsWith('http://') && !url.startsWith('https://')) return url;
  if (url.contains('/api/remote-image?')) return url;

  final base = ApiConfig.baseUrl.replaceAll(RegExp(r'/$'), '');
  final host = Uri.base.host;
  final isLocal = host == 'localhost' || host == '127.0.0.1';
  if (!isLocal) {
    return '/api/remote-image?u=${Uri.encodeComponent(url)}';
  }
  return '$base/api/remote-image?u=${Uri.encodeComponent(url)}';
}
