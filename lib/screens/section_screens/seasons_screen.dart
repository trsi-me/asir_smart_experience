import 'package:flutter/material.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/widgets/section_scaffold.dart';

/// مواسم عسير
class SeasonsScreen extends StatelessWidget {
  const SeasonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.localizedData;
    return SectionScaffold(
      title: context.l10n.seasons,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...data.seasons.map((s) => _buildSeasonCard(context, s)),
        ],
      ),
    );
  }

  IconData _seasonIcon(String? iconId) {
    switch (iconId) {
      case 'fog': return Icons.cloud;
      case 'sun': return Icons.wb_sunny;
      case 'snow': return Icons.ac_unit;
      case 'coffee': return Icons.coffee;
      case 'camping': return Icons.forest;
      case 'events': return Icons.celebration;
      default: return Icons.wb_sunny;
    }
  }

  Widget _buildSeasonCard(BuildContext context, Map<String, dynamic> season) {
    final iconId = season['iconId'] as String? ?? season['emoji'];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_seasonIcon(iconId?.toString()), color: AppColors.teal, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      season['name'] as String,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white),
                    ),
                    Text(season['months'] as String, style: const TextStyle(color: AppColors.teal)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            context.l10n.seasonsExperiences,
            style: const TextStyle(fontSize: 14, color: AppColors.white80),
          ),
        ],
      ),
    );
  }
}
