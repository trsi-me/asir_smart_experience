import 'package:flutter/material.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/app_images.dart';
import 'package:asir_smart_experience/core/image_url.dart';
import 'package:asir_smart_experience/core/app_transitions.dart';
import 'package:asir_smart_experience/data/places_data.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/screens/place_detail_screen.dart';
import 'package:asir_smart_experience/widgets/section_scaffold.dart';
import 'package:asir_smart_experience/widgets/image_list_item.dart';

/// التسوق والترفيه
class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dataT = context.dataT;
    return SectionScaffold(
      title: l10n.shopping,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          _buildHeaderImage(context),
          const SizedBox(height: 24),
          ...PlacesData.shoppingPlaces.map((p) {
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
          ...PlacesData.entertainmentPlaces.map((p) {
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
            proxiedImageUrl(AppImages.shopping),
            fit: BoxFit.cover,
            loadingBuilder: (_, child, p) => p == null ? child : Container(color: AppColors.darkBlue, child: const Center(child: CircularProgressIndicator(color: AppColors.teal))),
            errorBuilder: (_, __, ___) => Container(color: AppColors.surface),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)]),
            ),
          ),
          Positioned(left: 20, right: 20, bottom: 20, child: Text(context.l10n.marketsAndEntertainment, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.white))),
        ],
      ),
    );
  }
}
