import 'package:flutter/material.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/core/app_transitions.dart';
import 'package:asir_smart_experience/data/places_data.dart';
import 'package:asir_smart_experience/screens/place_detail_screen.dart';
import 'package:asir_smart_experience/widgets/section_scaffold.dart';
import 'package:asir_smart_experience/widgets/image_list_item.dart';

/// دليل المواقع السياحية الشامل - كل المحتوى بلا استثناء
class PlacesGuideScreen extends StatelessWidget {
  const PlacesGuideScreen({super.key});

  Map<String, String> _categoryTitles(BuildContext context) {
    final l10n = context.l10n;
    return {
      'heritage': l10n.catHeritage,
      'nature': l10n.catNature,
      'coastal': l10n.catCoastal,
      'entertainment': l10n.catEntertainment,
      'shopping': l10n.catShopping,
      'parks': l10n.catParks,
      'culture': l10n.catCulture,
      'coffee': l10n.catCoffee,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dataT = context.dataT;
    return SectionScaffold(
      title: l10n.placesGuideTitle,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          _buildIntro(context),
          const SizedBox(height: 24),
          ...PlacesData.allByCategory.entries.map((e) {
            if (e.value.isEmpty) return const SizedBox();
            final titles = _categoryTitles(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: Text(
                    titles[e.key] ?? e.key,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.teal),
                  ),
                ),
                ...e.value.map((p) {
                  final images = (p['images'] as List?)?.cast<String>() ?? [];
                  final id = p['id'] as String? ?? '';
                  final name = dataT.placeName(id).isNotEmpty && dataT.placeName(id) != id ? dataT.placeName(id) : (p['name'] as String? ?? '');
                  final subtitle = dataT.placeSubtitle(id).isNotEmpty ? dataT.placeSubtitle(id) : (p['subtitle'] as String? ?? '');
                  return ImageListItem(
                    imageUrl: images.isNotEmpty ? images.first : null,
                    title: name,
                    subtitle: subtitle.isNotEmpty ? subtitle : null,
                    onTap: () => Navigator.push(context, AppTransitions.slideFromLeft(PlaceDetailScreen(place: p))),
                  );
                }),
                const SizedBox(height: 8),
              ],
            );
          }),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildIntro(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        context.l10n.placesGuideIntro,
        style: const TextStyle(fontSize: 15, color: AppColors.white80),
      ),
    );
  }
}
