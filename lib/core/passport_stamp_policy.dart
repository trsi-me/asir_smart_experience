import 'package:asir_smart_experience/data/database_helper.dart';

/// سياسة ربط الأنشطة بجواز عسير.
///
/// يُسمح بالختم لأي مكان من القائمة الأساسية، أو لأي مكان يتطابق تصنيفه مع
/// نشاط من مقدّمي الخدمات المعتمدين فقط (وثيقة المنصة، البند ٧).
class PassportStampPolicy {
  PassportStampPolicy._();

  /// أماكن أساسية مرتبطة بالجواز للعرض التوضيحي.
  static const Set<String> approvedPlaceIds = {
    'fog',
    'coffee',
    'heritage',
  };

  /// خريطة تصنيفات أصحاب الأنشطة → معرّف ختم الجواز المقابل.
  /// مثال: الكافيهات تشارك في "ختم القهوة"، التراث يشارك في "ختم التراث"…
  static const Map<String, String> categoryToStampPlaceId = {
    'كافيه': 'coffee',
    'مطعم': 'coffee',
    'أسرة منتجة': 'coffee',
    'تخييم': 'fog',
    'هايكنق': 'fog',
    'مرشد سياحي': 'heritage',
    'فعالية': 'heritage',
    'منتزه': 'fog',
    'رحلة بحرية': 'fog',
    'غوص': 'fog',
    'زيارة جزر': 'fog',
    'نشاط عائلي': 'heritage',
    'مغامرات': 'fog',
  };

  /// يستخدمه شاشة جواز عسير لعرض الأختام المتاحة بشكل سريع (متزامن).
  static bool canCollectStampForPlace(String placeId) =>
      approvedPlaceIds.contains(placeId);

  /// نسخة غير متزامنة تأخذ بعين الاعتبار الأنشطة المعتمدة من قاعدة البيانات.
  static Future<bool> canCollectStampForPlaceAsync(String placeId) async {
    if (approvedPlaceIds.contains(placeId)) return true;
    try {
      final accepted =
          await DatabaseHelper.instance.getProviderApplicationsAccepted();
      for (final p in accepted) {
        final cat = p['category'] as String?;
        if (cat == null) continue;
        final mapped = categoryToStampPlaceId[cat];
        if (mapped == placeId) return true;
      }
    } catch (_) {}
    return false;
  }
}
