import 'package:flutter/material.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/core/app_images.dart';
import 'package:asir_smart_experience/core/app_transitions.dart';
import 'package:asir_smart_experience/data/places_data.dart';
import 'package:asir_smart_experience/screens/place_detail_screen.dart';
import 'package:asir_smart_experience/widgets/booking_sheet.dart';
import 'package:asir_smart_experience/widgets/section_scaffold.dart';
import 'package:asir_smart_experience/widgets/image_list_item.dart';

/// قهوتنا غير - مزارع البن والعسل
class CoffeeScreen extends StatelessWidget {
  const CoffeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final data = context.localizedData;
    return SectionScaffold(
      title: l10n.coffee,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          _buildHeaderImage(context),
          const SizedBox(height: 24),
          ...PlacesData.coffeePlaces.map((c) {
            final images = (c['images'] as List?)?.cast<String>() ?? [];
            return ImageListItem(
              imageUrl: images.isNotEmpty ? images.first : null,
              title: c['name'] as String,
              subtitle: c['subtitle'] as String?,
              onTap: () => Navigator.push(context, AppTransitions.slideFromLeft(PlaceDetailScreen(place: c))),
            );
          }),
          ...data.coffeePlaces.map((c) => ImageListItem(
            imageUrl: c['image'] as String?,
            title: c['name'] as String,
            subtitle: '${c['type']} • ${l10n.discount} ${c['discount']}',
            onTap: () => showBookingSheet(context, '${c['name']} - ${l10n.southernCoffee}'),
          )),
          const SizedBox(height: 20),
          _buildInfoStrip(context),
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
            AppImages.coffee,
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
            child: Text(
              context.l10n.southernCoffee,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoStrip(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.amber.withValues(alpha: 0.2), AppColors.teal.withValues(alpha: 0.1)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        context.l10n.coffeeInfo,
        style: const TextStyle(fontSize: 16, color: AppColors.white),
      ),
    );
  }
}
