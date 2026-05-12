import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/core/locale_provider.dart';
import 'package:asir_smart_experience/core/app_images.dart';
import 'package:asir_smart_experience/core/image_url.dart';
import 'package:asir_smart_experience/core/app_transitions.dart';
import 'package:asir_smart_experience/core/guest_policy.dart'
    show showPassportLoginRequiredDialog, showProviderAccountRequiredDialog;
import 'package:asir_smart_experience/services/auth_service.dart';
import 'package:asir_smart_experience/screens/section_screens/today_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/weather_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/hiking_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/coffee_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/heritage_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/seasons_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/coastal_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/camping_screen.dart';
import 'package:asir_smart_experience/screens/asir_passport_screen.dart';
import 'package:asir_smart_experience/screens/auth/unified_auth_screen.dart';
import 'package:asir_smart_experience/screens/pending_approval_screen.dart';
import 'package:asir_smart_experience/screens/my_bookings_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/guide_hub_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/activities_adventures_screen.dart';
import 'package:asir_smart_experience/screens/section_screens/smart_trip_screen.dart';
import 'package:asir_smart_experience/screens/provider/provider_registration_screen.dart';
import 'package:asir_smart_experience/screens/admin/admin_provider_review_screen.dart';

/// الصفحة الرئيسية — هيدر + طقس + شبكة ٦ + «وش ودّك تسوي اليوم؟» + تسجيل النشاط.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Map<String, dynamic>> _mainGrid = [
    {'route': 'passport', 'icon': Icons.card_membership, 'color': 0xFF26A69A},
    {'route': 'guide_hub', 'icon': Icons.explore_outlined, 'color': 0xFF4FC3F7},
    {'route': 'activities', 'icon': Icons.local_fire_department, 'color': 0xFFFF7043},
    {'route': 'smart_trip', 'icon': Icons.route, 'color': 0xFFAB47BC},
    {'route': 'seasons', 'icon': Icons.festival, 'color': 0xFFFFCA28},
    {'route': 'weather', 'icon': Icons.wb_sunny_outlined, 'color': 0xFF81D4FA},
  ];

  Widget _pageFor(String route) {
    switch (route) {
      case 'passport':
        return const AsirPassportScreen();
      case 'guide_hub':
        return const GuideHubScreen();
      case 'activities':
        return const ActivitiesAdventuresScreen();
      case 'smart_trip':
        return const SmartTripScreen();
      case 'seasons':
        return const SeasonsScreen();
      case 'weather':
        return const WeatherScreen();
      case 'today':
        return const TodayScreen();
      case 'hiking':
        return const HikingScreen();
      case 'coffee':
        return const CoffeeScreen();
      case 'heritage':
        return const HeritageScreen();
      case 'coastal':
        return const CoastalScreen();
      case 'camping':
        return const CampingScreen();
      default:
        return const WeatherScreen();
    }
  }

  void _open(BuildContext context, String route) {
    HapticFeedback.lightImpact();
    if (route == 'passport' && !AuthService().isLoggedIn) {
      showPassportLoginRequiredDialog(context);
      return;
    }
    Navigator.push(context, AppTransitions.slideFromLeft(_pageFor(route)));
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
          child: auth.isLoggedIn
              ? _buildLoggedInMenu(ctx, auth)
              : _buildGuestMenu(ctx),
        ),
      ),
    );
  }

  Widget _buildLoggedInMenu(BuildContext ctx, AuthService auth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Icon(Icons.person, color: AppColors.teal),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                auth.currentUserName ?? ctx.l10n.account,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.white),
              ),
            ),
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
            label: Text(ctx.l10n.myBookings),
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
            label: Text(ctx.l10n.pendingApprovalMenu),
            style: OutlinedButton.styleFrom(foregroundColor: AppColors.teal, side: const BorderSide(color: AppColors.teal)),
          ),
        ),
        if ((auth.currentUserEmail ?? '') == 'admin@asir.sa') ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.push(ctx, MaterialPageRoute(builder: (_) => const AdminProviderReviewScreen()));
              },
              icon: const Icon(Icons.admin_panel_settings, size: 20),
              label: Text(ctx.l10n.adminReviewTitle),
              style: OutlinedButton.styleFrom(foregroundColor: AppColors.amber, side: const BorderSide(color: AppColors.amber)),
            ),
          ),
        ],
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () async {
              await auth.logout();
              if (ctx.mounted) {
                Navigator.pop(ctx);
                // بعد تسجيل الخروج يبقى المستخدم في الصفحة الرئيسية كزائر.
                Navigator.pushAndRemoveUntil(ctx, AppTransitions.fadeScale(const HomeScreen()), (_) => false);
              }
            },
            icon: const Icon(Icons.logout, size: 20),
            label: Text(ctx.l10n.logout),
            style: OutlinedButton.styleFrom(foregroundColor: AppColors.rose, side: const BorderSide(color: AppColors.rose)),
          ),
        ),
      ],
    );
  }

  Widget _buildGuestMenu(BuildContext ctx) {
    final l10n = ctx.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Icon(Icons.person_outline, color: AppColors.teal),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                l10n.guest,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          l10n.guestPermissionsHint,
          style: TextStyle(color: AppColors.white80.withValues(alpha: 0.85), fontSize: 13, height: 1.45),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () {
            Navigator.pop(ctx);
            Navigator.push(ctx, AppTransitions.fadeScale(const UnifiedAuthScreen(initialTab: 0)));
          },
          icon: const Icon(Icons.login, size: 20),
          label: Text(l10n.login),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.teal,
            foregroundColor: AppColors.darkBlue,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.pop(ctx);
            Navigator.push(ctx, AppTransitions.fadeScale(const UnifiedAuthScreen(initialTab: 1)));
          },
          icon: const Icon(Icons.person_add_alt_1, size: 20),
          label: Text(l10n.createAccount),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.teal,
            side: const BorderSide(color: AppColors.teal),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildHero(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 8),
              child: Consumer<LocaleProvider>(
                builder: (_, loc, __) => Text(
                  loc.l10n.mainSectionsTitle,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.white),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.05,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final item = _mainGrid[i];
                  final route = item['route'] as String;
                  return Consumer<LocaleProvider>(
                    builder: (_, loc, __) {
                      final titles = {
                        'passport': loc.l10n.passport,
                        'guide_hub': loc.l10n.guideInAsir,
                        'activities': loc.l10n.activitiesAdventures,
                        'smart_trip': loc.l10n.smartTrip,
                        'seasons': loc.l10n.seasons,
                        'weather': loc.l10n.weather,
                      };
                      final subs = {
                        'passport': loc.l10n.passportSub,
                        'guide_hub': loc.l10n.guideInAsirSub,
                        'activities': loc.l10n.activitiesAdventuresSub,
                        'smart_trip': loc.l10n.smartTripSub,
                        'seasons': loc.l10n.seasonsSub,
                        'weather': loc.l10n.weatherSub,
                      };
                      final color = Color(item['color'] as int);
                      return _MainGridTile(
                        icon: item['icon'] as IconData,
                        title: titles[route] ?? route,
                        subtitle: subs[route],
                        accent: color,
                        onTap: () => _open(context, route),
                      );
                    },
                  );
                },
                childCount: _mainGrid.length,
              ),
            ),
          ),
          SliverToBoxAdapter(child: _buildMoodSection(context)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      if (!AuthService().isLoggedIn) {
                        showProviderAccountRequiredDialog(context);
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ProviderRegistrationScreen()),
                      );
                    },
                    icon: const Icon(Icons.storefront_outlined, color: AppColors.teal),
                    label: Text(
                      context.l10n.registerYourActivity,
                      style: const TextStyle(color: AppColors.teal, fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.teal),
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.registerYourActivitySub,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.white80.withValues(alpha: 0.9),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodSection(BuildContext context) {
    final l10n = context.l10n;
    final moods = <(String label, IconData icon, String route, String imageUrl)>[
      (l10n.moodWalk, Icons.nature_people_outlined, 'hiking', AppImages.hiking),
      (l10n.moodAdventure, Icons.landscape_outlined, 'activities', AppImages.today),
      (l10n.moodSea, Icons.waves, 'coastal', AppImages.coastal),
      (l10n.moodCoffee, Icons.local_cafe_outlined, 'coffee', AppImages.coffee),
      (l10n.moodEvents, Icons.celebration_outlined, 'today', AppImages.seasons),
      (l10n.moodRelax, Icons.spa_outlined, 'heritage', AppImages.heritage),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.moodTodaySection, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.white)),
          const SizedBox(height: 14),
          SizedBox(
            height: 158,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: moods.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (ctx, i) {
                final m = moods[i];
                return _HomeMoodCard(
                  label: m.$1,
                  icon: m.$2,
                  imageSrc: m.$4,
                  onTap: () => _open(context, m.$3),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final l10n = context.l10n;
    final data = context.localizedData;
    final w = data.weatherData.isNotEmpty ? data.weatherData.first : {'day': '', 'temp': '—', 'condition': '', 'iconId': 'sunny'};

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 320,
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
                    AppColors.darkBlue.withValues(alpha: 0.35),
                    AppColors.darkBlue.withValues(alpha: 0.82),
                    AppColors.darkBlue,
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          tooltip: l10n.account,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.darkBlue.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.teal.withValues(alpha: 0.35)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.wb_cloudy_outlined, color: AppColors.teal.withValues(alpha: 0.95)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l10n.currentWeather, style: TextStyle(fontSize: 12, color: AppColors.white80.withValues(alpha: 0.95))),
                                Text(
                                  '${w['temp']} · ${w['condition']}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      l10n.heroWelcome,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.white, height: 1.2),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.heroSubtitle,
                      style: TextStyle(fontSize: 15, color: AppColors.teal.withValues(alpha: 0.95), fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
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

/// بطاقة تفاعلية لقسم «وش ودّك تسوي اليوم؟» — صورة، أيقونة، طبقة داكنة، زوايا دائرية.
class _HomeMoodCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final String imageSrc;
  final VoidCallback onTap;

  const _HomeMoodCard({
    required this.label,
    required this.icon,
    required this.imageSrc,
    required this.onTap,
  });

  static const double _width = 132;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(18);
    return SizedBox(
      width: _width,
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(color: AppColors.teal.withValues(alpha: 0.35)),
            ),
            child: ClipRRect(
              borderRadius: radius,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    proxiedImageUrl(imageSrc),
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return Container(color: AppColors.darkBlueLight);
                    },
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.darkBlueLight,
                      child: Icon(icon, color: AppColors.teal, size: 40),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.08),
                          Colors.black.withValues(alpha: 0.72),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: 10,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.teal.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(icon, color: AppColors.darkBlue, size: 18),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            label,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MainGridTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color accent;
  final VoidCallback onTap;

  const _MainGridTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.darkBlueLight,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: accent.withValues(alpha: 0.35)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                accent.withValues(alpha: 0.12),
                AppColors.darkBlueLight,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: accent, size: 28),
                ),
                const Spacer(),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.white, height: 1.2),
                ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11, color: AppColors.white80.withValues(alpha: 0.9), height: 1.25),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
