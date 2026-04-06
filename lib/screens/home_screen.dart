import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/core/locale_provider.dart';
import 'package:asir_smart_experience/core/app_images.dart';
import 'package:asir_smart_experience/core/image_url.dart';
import 'package:asir_smart_experience/core/app_transitions.dart';
import 'package:asir_smart_experience/services/auth_service.dart';
import 'package:asir_smart_experience/widgets/image_tile.dart';
import 'package:asir_smart_experience/screens/section_screens/today_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/weather_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/camping_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/hiking_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/coffee_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/heritage_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/local_shops_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/seasons_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/services_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/food_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/shopping_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/coastal_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/maps_screen.dart';
import 'package:asir_smart_experience/screens/asir_passport_screen.dart';
import 'package:asir_smart_experience/screens/auth/login_screen.dart';
import 'package:asir_smart_experience/screens/pending_approval_screen.dart';
import 'package:asir_smart_experience/screens/my_bookings_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/places_guide_screen.dart';

/// واجهة مصورة - بدون كاردات أو خطوط جانبية
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Map<String, dynamic>> _sections = [
    {'route': 'passport', 'image': AppImages.passport},
    {'route': 'places_guide', 'image': AppImages.heritage},
    {'route': 'today', 'image': AppImages.today},
    {'route': 'weather', 'image': AppImages.weather},
    {'route': 'maps', 'image': AppImages.maps},
    {'route': 'camping', 'image': AppImages.camping},
    {'route': 'hiking', 'image': AppImages.hiking},
    {'route': 'coffee', 'image': AppImages.coffee},
    {'route': 'heritage', 'image': AppImages.heritage},
    {'route': 'local', 'image': AppImages.local},
    {'route': 'seasons', 'image': AppImages.seasons},
    {'route': 'services', 'image': AppImages.services},
    {'route': 'food', 'image': AppImages.food},
    {'route': 'shopping', 'image': AppImages.shopping},
    {'route': 'coastal', 'image': AppImages.coastal},
  ];

  Widget _navigateTo(String route) {
    switch (route) {
      case 'passport': return const AsirPassportScreen();
      case 'places_guide': return const PlacesGuideScreen();
      case 'today': return const TodayScreen();
      case 'weather': return const WeatherScreen();
      case 'camping': return const CampingScreen();
      case 'hiking': return const HikingScreen();
      case 'coffee': return const CoffeeScreen();
      case 'heritage': return const HeritageScreen();
      case 'local': return const LocalShopsScreen();
      case 'seasons': return const SeasonsScreen();
      case 'services': return const ServicesScreen();
      case 'food': return const FoodScreen();
      case 'shopping': return const ShoppingScreen();
      case 'coastal': return const CoastalScreen();
      case 'maps': return const MapsScreen();
      default: return const TodayScreen();
    }
  }

  void _open(BuildContext context, String route) {
    HapticFeedback.lightImpact();
    Navigator.push(context, AppTransitions.slideFromLeft(_navigateTo(route)));
  }

  void _showAccountMenu(BuildContext context) {
    HapticFeedback.lightImpact();
    final auth = AuthService();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkBlueLight,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.person, color: AppColors.teal),
                  const SizedBox(width: 12),
                  Text(auth.currentUserName ?? context.l10n.guest, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.white)),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.push(ctx, MaterialPageRoute(builder: (_) => const MyBookingsScreen()));
                  },
                  icon: const Icon(Icons.book_online, size: 20),
                  label: Text(context.l10n.myBookings),
                  style: OutlinedButton.styleFrom(foregroundColor: AppColors.teal, side: const BorderSide(color: AppColors.teal)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.push(ctx, MaterialPageRoute(builder: (_) => PendingApprovalScreen(onRefreshStatus: () {})));
                  },
                  icon: const Icon(Icons.pending_actions, size: 20),
                  label: Text(context.l10n.pendingApprovalMenu),
                  style: OutlinedButton.styleFrom(foregroundColor: AppColors.teal, side: const BorderSide(color: AppColors.teal)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await auth.logout();
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(context, AppTransitions.fadeScale(const LoginScreen()), (_) => false);
                    }
                  },
                  icon: const Icon(Icons.logout, size: 20),
                  label: Text(context.l10n.logout),
                  style: OutlinedButton.styleFrom(foregroundColor: AppColors.rose, side: const BorderSide(color: AppColors.rose)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildHero(context),
          SliverToBoxAdapter(
            child: Consumer<LocaleProvider>(
              builder: (_, loc, __) => Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Text(
                  loc.l10n.explore,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) {
                final s = _sections[i];
                final route = s['route'] as String;
                return Consumer<LocaleProvider>(
                  builder: (_, loc, __) {
                    final titles = {
                      'passport': loc.l10n.passport,
                      'places_guide': loc.l10n.placesGuide,
                      'today': loc.l10n.today,
                      'weather': loc.l10n.weather,
                      'maps': loc.l10n.maps,
                      'camping': loc.l10n.camping,
                      'hiking': loc.l10n.hiking,
                      'coffee': loc.l10n.coffee,
                      'heritage': loc.l10n.heritage,
                      'local': loc.l10n.local,
                      'seasons': loc.l10n.seasons,
                      'services': loc.l10n.services,
                      'food': loc.l10n.food,
                      'shopping': loc.l10n.shopping,
                      'coastal': loc.l10n.coastal,
                    };
                    final subs = {
                      'passport': loc.l10n.passportSub,
                      'places_guide': loc.l10n.placesGuideSub,
                      'today': loc.l10n.todaySub,
                      'weather': loc.l10n.weatherSub,
                      'maps': loc.l10n.mapsSub,
                      'camping': loc.l10n.campingSub,
                      'hiking': loc.l10n.hikingSub,
                      'coffee': loc.l10n.coffeeSub,
                      'heritage': loc.l10n.heritageSub,
                      'local': loc.l10n.localSub,
                      'seasons': loc.l10n.seasonsSub,
                      'services': loc.l10n.servicesSub,
                      'food': loc.l10n.foodSub,
                      'shopping': loc.l10n.shoppingSub,
                      'coastal': loc.l10n.coastalSub,
                    };
                    return ImageTile(
                      imageUrl: s['image'] as String,
                      title: titles[route] ?? route,
                      subtitle: subs[route],
                      onTap: () => _open(context, route),
                    );
                  },
                );
              },
              childCount: _sections.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 280,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              proxiedImageUrl(AppImages.hero),
              fit: BoxFit.cover,
              loadingBuilder: (_, child, progress) {
                if (progress == null) return child;
                return Container(color: AppColors.darkBlue, child: const Center(child: CircularProgressIndicator(color: AppColors.teal)));
              },
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.darkBlue,
                child: Image.asset('assets/images/Logo.jpg', fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox()),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.darkBlue.withValues(alpha: 0.3),
                    AppColors.darkBlue.withValues(alpha: 0.8),
                    AppColors.darkBlue,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => context.read<LocaleProvider>().toggle(),
                          icon: const Icon(Icons.language, color: AppColors.white, size: 26),
                          tooltip: 'عربي / English',
                        ),
                        IconButton(
                          onPressed: () => _showAccountMenu(context),
                          icon: const Icon(Icons.person_outline, color: AppColors.white, size: 26),
                          tooltip: 'الحساب',
                        ),
                      ],
                    ),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                'assets/images/Logo.jpg',
                                width: 72,
                                height: 72,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 72,
                                  height: 72,
                                  color: AppColors.teal.withValues(alpha: 0.3),
                                  child: const Icon(Icons.place, size: 36, color: AppColors.teal),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'عسير',
                              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.white),
                            ),
                            Text(
                              'التجربة الذكية',
                              style: TextStyle(fontSize: 18, color: AppColors.teal, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
