import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/app_transitions.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/screens/section_screens/places_guide_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/food_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/coffee_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/camping_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/hiking_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/heritage_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/local_shops_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/seasons_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/services_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/shopping_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/coastal_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/maps_screen.dart';
import 'package:asir_smart_experience/widgets/section_scaffold.dart';

/// دليلك في عسير — يغذي الأقسام الفرعية (مطاعم، كافيهات، سكن، تسوق…).
class GuideHubScreen extends StatelessWidget {
  const GuideHubScreen({super.key});

  void _go(BuildContext context, Widget page) {
    HapticFeedback.lightImpact();
    Navigator.push(context, AppTransitions.slideFromLeft(page));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = <_HubItem>[
      _HubItem(l10n.placesGuideTitle, l10n.placesGuideSub, Icons.map_outlined, () => _go(context, const PlacesGuideScreen())),
      _HubItem(l10n.restaurantsSection, l10n.foodTypes, Icons.restaurant, () => _go(context, const FoodScreen())),
      _HubItem(l10n.coffee, l10n.coffeeSub, Icons.local_cafe, () => _go(context, const CoffeeScreen())),
      _HubItem(l10n.camping, l10n.campingSub, Icons.forest, () => _go(context, const CampingScreen())),
      _HubItem(l10n.hiking, l10n.hikingSub, Icons.hiking, () => _go(context, const HikingScreen())),
      _HubItem(l10n.heritage, l10n.heritageSub, Icons.castle, () => _go(context, const HeritageScreen())),
      _HubItem(l10n.local, l10n.localSub, Icons.storefront, () => _go(context, const LocalShopsScreen())),
      _HubItem(l10n.seasons, l10n.seasonsSub, Icons.calendar_month, () => _go(context, const SeasonsScreen())),
      _HubItem(l10n.services, l10n.servicesSub, Icons.room_service, () => _go(context, const ServicesScreen())),
      _HubItem(l10n.shopping, l10n.shoppingSub, Icons.shopping_bag_outlined, () => _go(context, const ShoppingScreen())),
      _HubItem(l10n.coastal, l10n.coastalSub, Icons.waves, () => _go(context, const CoastalScreen())),
      _HubItem(l10n.maps, l10n.mapsSub, Icons.explore, () => _go(context, const MapsScreen())),
    ];

    return SectionScaffold(
      title: l10n.guideInAsir,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.teal.withValues(alpha: 0.25)),
            ),
            child: Text(
              l10n.guideInAsirSub,
              style: const TextStyle(fontSize: 15, height: 1.5, color: AppColors.white80),
            ),
          ),
          const SizedBox(height: 20),
          ...items.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Material(
                  color: AppColors.darkBlueLight,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: e.onTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.teal.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(e.icon, color: AppColors.teal, size: 26),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.white)),
                                const SizedBox(height: 4),
                                Text(e.subtitle, style: TextStyle(fontSize: 13, color: AppColors.white80.withValues(alpha: 0.9))),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_left, color: AppColors.teal),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class _HubItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  _HubItem(this.title, this.subtitle, this.icon, this.onTap);
}
