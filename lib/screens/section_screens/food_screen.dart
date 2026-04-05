import 'package:flutter/material.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/widgets/section_scaffold.dart';

/// التجارب الغذائية
class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final data = context.localizedData;
    return SectionScaffold(
      title: l10n.food,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle(l10n.restaurantsSection),
          ...data.restaurants.map((r) => _buildRestaurantCard(r)),
          const SizedBox(height: 16),
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

  Widget _buildRestaurantCard(Map<String, dynamic> r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.restaurant, color: AppColors.teal, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r['name'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white)),
                Text(r['type'] as String, style: const TextStyle(fontSize: 14, color: AppColors.teal)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
