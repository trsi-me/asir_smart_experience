import 'package:asir_smart_experience/data/asir_real_places_seed.dart';

/// واجهة موحدة لمحتوى الحزمة الموثّقة (`project_real_content`).
class AsirRealContent {
  AsirRealContent._();

  static List<Map<String, dynamic>> get all => asirRealPlacesSeed;

  static List<Map<String, dynamic>> byCategory(String category) =>
      asirRealPlacesSeed.where((p) => p['category'] == category).toList();

  /// تحويل إلى شكل متوقع في [PlaceDetailScreen].
  static Map<String, dynamic> toPlaceDetailMap(
    Map<String, dynamic> seed, {
    required bool isArabic,
  }) {
    final imgs = <String>[
      ...?((seed['image_assets'] as List?)?.map((e) => e.toString())),
    ];
    final primary = seed['primary_image']?.toString();
    if (primary != null && primary.isNotEmpty && !imgs.contains(primary)) {
      imgs.insert(0, primary);
    }
    final name = isArabic
        ? (seed['name_ar']?.toString() ?? '')
        : (seed['name_en']?.toString() ?? seed['name_ar']?.toString() ?? '');
    final city = seed['city']?.toString() ?? '';
    final sub = seed['subcategory']?.toString() ?? '';
    final desc = seed['short_description_ar']?.toString() ?? '';
    final tags = (seed['tags'] as List?)?.map((e) => e.toString()).toList() ?? <String>[];
    final tagLine = tags.join(' • ');
    return {
      ...seed,
      'name': name,
      'subtitle': [city, sub].where((s) => s.isNotEmpty).join(' • '),
      'description': desc,
      'importance': tagLine.isNotEmpty ? tagLine : desc,
      'activities': tags,
      'images': imgs,
      'classification': sub,
    };
  }
}
