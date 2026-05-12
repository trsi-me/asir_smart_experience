import 'package:flutter/material.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/app_transitions.dart';
import 'package:asir_smart_experience/data/asir_real_content.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/screens/place_detail_screen.dart';
import 'package:asir_smart_experience/widgets/image_list_item.dart';
import 'package:asir_smart_experience/widgets/section_scaffold.dart';

/// التجارب الغذائية
class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SectionScaffold(
      title: l10n.food,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle(l10n.verifiedPlacesTitle),
          ...AsirRealContent.byCategory('restaurants').map((raw) {
            final place = AsirRealContent.toPlaceDetailMap(raw, isArabic: context.isArabic);
            return ImageListItem(
              imageUrl: raw['primary_image'] as String?,
              title: place['name'] as String,
              subtitle: place['subtitle'] as String?,
              onTap: () => Navigator.push(
                context,
                AppTransitions.slideFromLeft(PlaceDetailScreen(place: place)),
              ),
            );
          }),
          const SizedBox(height: 20),
          _buildSectionTitle(l10n.foodTrucksAndBooking),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(Icons.restaurant, l10n.foodTypes),
                _buildInfoRow(Icons.directions_car_filled, l10n.foodTrucksDirect),
                _buildInfoRow(Icons.thumb_up, l10n.localRecommendations),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.teal),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.teal, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(color: AppColors.white80, fontSize: 15))),
        ],
      ),
    );
  }
}
