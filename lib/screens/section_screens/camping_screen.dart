import 'package:flutter/material.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/app_images.dart';
import 'package:asir_smart_experience/core/app_transitions.dart';
import 'package:asir_smart_experience/data/places_data.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/screens/place_detail_screen.dart';
import 'package:asir_smart_experience/widgets/section_scaffold.dart';
import 'package:asir_smart_experience/widgets/image_list_item.dart';

/// نخيم؟ - تصميم مصور
class CampingScreen extends StatelessWidget {
  const CampingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dataT = context.dataT;
    return SectionScaffold(
      title: l10n.camping,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          _buildHeaderImage(context),
          const SizedBox(height: 24),
          ...PlacesData.campingPlaces.map((p) {
            final id = p['id'] as String? ?? '';
            final placeName = dataT.placeName(id).isNotEmpty && dataT.placeName(id) != id ? dataT.placeName(id) : (p['name'] as String? ?? '');
            final subFromT = dataT.placeSubtitle(id);
            final placeSub = subFromT.isNotEmpty ? subFromT : (dataT.isArabic ? (p['subtitle'] as String?) : null);
            final images = (p['images'] as List?)?.cast<String>() ?? [];
            return ImageListItem(
              imageUrl: images.isNotEmpty ? images.first : null,
              title: placeName,
              subtitle: placeSub,
              onTap: () => Navigator.push(context, AppTransitions.slideFromLeft(PlaceDetailScreen(place: p))),
            );
          }),
          const SizedBox(height: 20),
          _buildSafetyAlert(context),
        ],
      ),
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            AppImages.camping,
            fit: BoxFit.cover,
            loadingBuilder: (_, child, p) => p == null ? child : Container(color: AppColors.darkBlue, child: const Center(child: CircularProgressIndicator(color: AppColors.teal))),
            errorBuilder: (_, __, ___) => Container(color: AppColors.surface),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Text(context.l10n.campingInAseer, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyAlert(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.amber.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Icon(Icons.warning_amber, color: AppColors.amber), const SizedBox(width: 8), Text(l10n.safetyAlerts, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white))]),
          const SizedBox(height: 8),
          Text('• ${l10n.safetyTip1}\n• ${l10n.safetyTip2}\n• ${l10n.safetyTip3}', style: const TextStyle(fontSize: 15, color: AppColors.white)),
        ],
      ),
    );
  }
}
