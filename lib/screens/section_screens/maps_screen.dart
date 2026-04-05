import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:asir_smart_experience/core/app_images.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/widgets/section_scaffold.dart';
import 'package:asir_smart_experience/widgets/image_tile.dart';

/// خرائط - بلاطات مصورة بالكامل
class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  static List<Map<String, dynamic>> _locations(BuildContext context) {
    final l10n = context.l10n;
    return [
      {'name': l10n.locAbha, 'lat': 18.2164, 'lng': 42.5053, 'desc': l10n.descAseerCapital},
      {'name': l10n.locSoudah, 'lat': 18.2519, 'lng': 42.3889, 'desc': l10n.descHighestPeak},
      {'name': l10n.locRijal, 'lat': 18.1500, 'lng': 42.4500, 'desc': l10n.descHeritageVillage},
      {'name': l10n.locBirk, 'lat': 18.2333, 'lng': 41.6167, 'desc': l10n.descAseerCoast},
      {'name': l10n.locQahma, 'lat': 18.0833, 'lng': 41.6833, 'desc': l10n.descBeach},
      {'name': l10n.locKhamis, 'lat': 18.3000, 'lng': 42.7333, 'desc': l10n.descMainCity},
    ];
  }

  // صور عسير الحقيقية مرتبطة بكل موقع
  static const List<String> _locationImages = [
    'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/VHkmHGIxpbiYqyeT.jpg', // أبها - متحف أبها الإقليمي
    'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/ryYymbaFReNEiGml.jpg', // السودة - ضباب وغابات
    'https://scth.scene7.com/is/image/scth/rejal-almaa-aseer:crop-1920x1080?defaultImage=rejal-almaa-aseer', // رجال ألمع - قرية تراثية
    'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/izIZxZLyspbjyifB.webp', // البرك - شاطئ عسير
    'https://files.manuscdn.com/user_upload_by_module/session_file/310519663336796913/MgmeKOzxgkKsSbhI.webp', // القحمة - جزيرة كدمبل قبالة القحمة
    'https://scth.scene7.com/is/image/scth/khamis-mushait:crop-1920x1080?defaultImage=khamis-mushait', // خميس مشيط - Visit Saudi
  ];

  Future<void> _openMaps(double lat, double lng) async {
    HapticFeedback.lightImpact();
    final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locations = _locations(context);
    return SectionScaffold(
      title: l10n.mapsAndLocations,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          ImageTile(
            imageUrl: AppImages.maps,
            title: l10n.aseerOnMap,
            subtitle: l10n.tapToOpenGoogleMaps,
            onTap: () => _openMaps(18.2164, 42.5053),
          ),
          ...List.generate(locations.length, (i) {
            final loc = locations[i];
            return ImageTile(
              imageUrl: _locationImages[i],
              title: loc['name'] as String,
              subtitle: loc['desc'] as String,
              onTap: () => _openMaps(loc['lat'] as double, loc['lng'] as double),
            );
          }),
        ],
      ),
    );
  }
}
