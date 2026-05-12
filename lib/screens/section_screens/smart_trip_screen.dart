import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/widgets/booking_sheet.dart';

/// رحلتك الذكية — شاشة خطة يومية تلقائية حسب الطقس والاهتمامات.
class SmartTripScreen extends StatelessWidget {
  const SmartTripScreen({super.key});

  static const List<_TripInterest> _interests = [
    _TripInterest('طبيعة', Icons.park_rounded, true),
    _TripInterest('قهوة وتجارب', Icons.coffee_rounded, false),
    _TripInterest('تراث وثقافة', Icons.museum_rounded, false),
    _TripInterest('عائلي', Icons.family_restroom_rounded, false),
  ];

  static const List<_TripStop> _stops = [
    _TripStop(
      time: '9:00',
      period: 'ص',
      dayPart: 'الصباح',
      title: 'زيارة السودة',
      subtitle: 'تجربة طبيعة وإطلالة بانورامية',
      location: 'السودة',
      image: 'assets/attractions/discover_aseer_attraction_01.webp',
      action: 'فتح في الخريطة',
      actionIcon: Icons.map_rounded,
      weatherIcon: Icons.wb_sunny_rounded,
    ),
    _TripStop(
      time: '12:30',
      period: 'م',
      dayPart: 'الظهيرة',
      title: 'قهوة رجال ألمع',
      subtitle: 'تجربة قهوة في الأجواء التراثية',
      location: 'رجال ألمع',
      image: 'assets/cafes/fog_coffee_1.jpg',
      action: 'احجز الآن',
      actionIcon: Icons.calendar_month_rounded,
      weatherIcon: Icons.wb_sunny_rounded,
    ),
    _TripStop(
      time: '4:00',
      period: 'م',
      dayPart: 'العصر',
      title: 'مسار مشي - وادي حلي',
      subtitle: 'أفضل وقت للمشي والاسترخاء',
      location: 'وادي حلي',
      image: 'assets/hiking/ridge_walk_1.jpg',
      action: 'ابدأ المسار',
      actionIcon: Icons.directions_walk_rounded,
      weatherIcon: Icons.cloud_queue_rounded,
    ),
    _TripStop(
      time: '7:30',
      period: 'م',
      dayPart: 'المساء',
      title: 'مطعم تراثي',
      subtitle: 'استمتع بعشاء محلي لذيذ',
      location: 'أبها',
      image: 'assets/restaurants/bab_al_turath_1.jpg',
      action: 'عرض المطاعم',
      actionIcon: Icons.search_rounded,
      weatherIcon: Icons.nightlight_round,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        body: Stack(
          children: [
            const _BackgroundGlow(),
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: _HeroHeader(interests: _interests)),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const _SectionTitle(title: 'خطة يومك في عسير', icon: Icons.work_outline_rounded),
                      const SizedBox(height: 10),
                      ..._stops.asMap().entries.map(
                            (entry) => _TimelineStopCard(
                              stop: entry.value,
                              isFirst: entry.key == 0,
                              isLast: entry.key == _stops.length - 1,
                            ),
                          ),
                      const SizedBox(height: 14),
                      const _ProgressAndPassportRow(),
                      const SizedBox(height: 14),
                      _BottomActions(
                        onShare: () => _snack(context, 'تم تجهيز رابط مشاركة الرحلة'),
                        onSuggest: () => _snack(context, 'تم اقتراح يوم جديد حسب الطقس والاهتمامات'),
                        onEdit: () => showBookingSheet(context, 'تعديل خطتي'),
                      ),
                      const SizedBox(height: 86),
                    ]),
                  ),
                ),
              ],
            ),
            const _FloatingTopBar(),
          ],
        ),
        bottomNavigationBar: const _SmartTripBottomNav(),
      ),
    );
  }

  static void _snack(BuildContext context, String message) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.right),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.cardSurface,
      ),
    );
  }
}

class _FloatingTopBar extends StatelessWidget {
  const _FloatingTopBar();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 8,
      left: 14,
      right: 14,
      child: Row(
        children: [
          _CircleButton(icon: Icons.arrow_back_ios_new_rounded, onTap: () => Navigator.of(context).maybePop()),
          const Spacer(),
          _CircleButton(
            icon: Icons.notifications_none_rounded,
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('لا توجد تنبيهات جديدة'))),
          ),
        ],
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  final List<_TripInterest> interests;
  const _HeroHeader({required this.interests});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/attractions/discover_aseer_attraction_01.webp'), fit: BoxFit.cover),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(18, MediaQuery.of(context).padding.top + 58, 18, 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.darkBlue.withValues(alpha: 0.20),
              AppColors.darkBlue.withValues(alpha: 0.55),
              AppColors.darkBlue.withValues(alpha: 0.96),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'رحلتك الذكية اليوم',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.w800),
                ),
                const SizedBox(width: 8),
                const Text('✨', style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 8,
              children: const [
                _WeatherMini(icon: Icons.location_on_rounded, text: 'أبها'),
                _WeatherMini(icon: Icons.cloud_rounded, text: 'ضباب'),
                _WeatherMini(icon: Icons.thermostat_rounded, text: '18°'),
                _WeatherMini(icon: Icons.air_rounded, text: 'خفيف'),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.eco_rounded, color: AppColors.teal, size: 18),
                SizedBox(width: 6),
                Text('يومك مثالي للمشي وتجربة القهوة', style: TextStyle(color: AppColors.white80, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                reverse: true,
                itemCount: interests.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) => _InterestChip(interest: interests[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineStopCard extends StatelessWidget {
  final _TripStop stop;
  final bool isFirst;
  final bool isLast;
  const _TimelineStopCard({required this.stop, required this.isFirst, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 58,
            child: Column(
              children: [
                Text(stop.time, style: const TextStyle(color: AppColors.teal, fontWeight: FontWeight.w800, fontSize: 15)),
                Text(stop.period, style: const TextStyle(color: AppColors.white80, fontSize: 12)),
                const SizedBox(height: 8),
                Icon(stop.weatherIcon, color: AppColors.amber, size: 20),
                const SizedBox(height: 4),
                Text(stop.dayPart, style: const TextStyle(color: AppColors.white80, fontSize: 11)),
              ],
            ),
          ),
          SizedBox(
            width: 18,
            child: Column(
              children: [
                Expanded(child: Container(width: 1.4, color: isFirst ? Colors.transparent : AppColors.teal.withValues(alpha: 0.35))),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(color: AppColors.teal, shape: BoxShape.circle, boxShadow: [BoxShadow(color: AppColors.teal.withValues(alpha: 0.45), blurRadius: 10)]),
                ),
                Expanded(child: Container(width: 1.4, color: isLast ? Colors.transparent : AppColors.teal.withValues(alpha: 0.35))),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.cardSurface.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.teal.withValues(alpha: 0.13)),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.20), blurRadius: 16, offset: const Offset(0, 8))],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      stop.image,
                      width: 116,
                      height: 92,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 116,
                        height: 92,
                        color: AppColors.darkBlueLight,
                        child: const Icon(Icons.image_not_supported_outlined, color: AppColors.white80),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(stop.title, style: const TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 4),
                        Text(stop.subtitle, style: const TextStyle(color: AppColors.white80, fontSize: 12.5, height: 1.35)),
                        const SizedBox(height: 5),
                        Row(children: [const Icon(Icons.location_on_outlined, color: AppColors.white80, size: 14), const SizedBox(width: 3), Text(stop.location, style: const TextStyle(color: AppColors.white80, fontSize: 12))]),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(child: _TinyButton(label: stop.action, icon: stop.actionIcon, filled: true, onTap: () => showBookingSheet(context, stop.title))),
                            const SizedBox(width: 8),
                            _TinyButton(label: 'إضافة للجواز', icon: Icons.bookmark_border_rounded, onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تمت إضافة ${stop.title} للجواز')))),
                          ],
                        ),
                      ],
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
}

class _ProgressAndPassportRow extends StatelessWidget {
  const _ProgressAndPassportRow();
  @override
  Widget build(BuildContext context) => const Row(children: [Expanded(child: _ProgressCard()), SizedBox(width: 12), Expanded(child: _PassportCard())]);
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      padding: const EdgeInsets.all(14),
      decoration: _glassDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('تقدمك اليوم', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w800)),
          Spacer(),
          Text('٢ / ٤ أنشطة', style: TextStyle(color: AppColors.white80, fontSize: 12)),
          SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(999)),
            child: LinearProgressIndicator(value: 0.5, minHeight: 7, color: AppColors.teal, backgroundColor: AppColors.darkBlueLight),
          ),
          SizedBox(height: 8),
          Row(children: [Icon(Icons.card_giftcard_rounded, color: AppColors.teal, size: 15), SizedBox(width: 5), Expanded(child: Text('أكمل يومك لتحصل على مكافأة', style: TextStyle(color: AppColors.white80, fontSize: 11)))]),
        ],
      ),
    );
  }
}

class _PassportCard extends StatelessWidget {
  const _PassportCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      padding: const EdgeInsets.all(14),
      decoration: _glassDecoration(),
      child: Stack(
        children: [
          Positioned(left: -6, bottom: -10, child: Icon(Icons.verified_rounded, color: AppColors.teal.withValues(alpha: 0.10), size: 86)),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [Expanded(child: Text('جواز عسير', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w800))), Icon(Icons.chevron_left_rounded, color: AppColors.teal)]),
              Spacer(),
              Text('اكتملت اليوم', style: TextStyle(color: AppColors.white80, fontSize: 11)),
              Text('٢', style: TextStyle(color: AppColors.teal, fontSize: 24, fontWeight: FontWeight.w900)),
              Row(children: [Icon(Icons.star_rounded, color: AppColors.amber, size: 16), SizedBox(width: 4), Text('+150 نقطة', style: TextStyle(color: AppColors.white80, fontSize: 11))]),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  final VoidCallback onShare;
  final VoidCallback onSuggest;
  final VoidCallback onEdit;
  const _BottomActions({required this.onShare, required this.onSuggest, required this.onEdit});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: _ActionButton(label: 'مشاركة الرحلة', icon: Icons.share_rounded, onTap: onShare)),
      const SizedBox(width: 10),
      Expanded(flex: 2, child: _ActionButton(label: 'اقتراح يوم جديد ✨', icon: Icons.auto_awesome_rounded, filled: true, onTap: onSuggest)),
      const SizedBox(width: 10),
      Expanded(child: _ActionButton(label: 'غيّر خطتي', icon: Icons.edit_square, onTap: onEdit)),
    ]);
  }
}

class _SmartTripBottomNav extends StatelessWidget {
  const _SmartTripBottomNav();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 74 + MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.fromLTRB(10, 8, 10, MediaQuery.of(context).padding.bottom + 8),
        decoration: BoxDecoration(color: AppColors.darkBlue.withValues(alpha: 0.98), border: Border(top: BorderSide(color: AppColors.teal.withValues(alpha: 0.10)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            _NavItem(icon: Icons.home_rounded, label: 'الرئيسية'),
            _NavItem(icon: Icons.search_rounded, label: 'استكشف'),
            _NavItem(icon: Icons.map_rounded, label: 'رحلتي', active: true),
            _NavItem(icon: Icons.verified_user_outlined, label: 'جواز عسير'),
            _NavItem(icon: Icons.person_outline_rounded, label: 'حسابي'),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  const _NavItem({required this.icon, required this.label, this.active = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: active ? AppColors.teal.withValues(alpha: 0.12) : Colors.transparent, borderRadius: BorderRadius.circular(18)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: active ? AppColors.teal : AppColors.white80, size: 22),
        const SizedBox(height: 3),
        Text(label, style: TextStyle(color: active ? AppColors.teal : AppColors.white80, fontSize: 10, fontWeight: active ? FontWeight.w800 : FontWeight.w500)),
      ]),
    );
  }
}

class _InterestChip extends StatelessWidget {
  final _TripInterest interest;
  const _InterestChip({required this.interest});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
      decoration: BoxDecoration(color: interest.selected ? AppColors.teal : AppColors.darkBlueLight.withValues(alpha: 0.78), borderRadius: BorderRadius.circular(999), border: Border.all(color: AppColors.white.withValues(alpha: interest.selected ? 0.0 : 0.08))),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(interest.icon, size: 16, color: interest.selected ? AppColors.darkBlue : AppColors.white80),
        const SizedBox(width: 7),
        Text(interest.label, style: TextStyle(color: interest.selected ? AppColors.darkBlue : AppColors.white80, fontWeight: FontWeight.w800, fontSize: 13)),
      ]),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionTitle({required this.title, required this.icon});
  @override
  Widget build(BuildContext context) => Row(children: [Icon(icon, color: AppColors.teal, size: 21), const SizedBox(width: 8), Text(title, style: const TextStyle(color: AppColors.white, fontSize: 17, fontWeight: FontWeight.w900))]);
}

class _WeatherMini extends StatelessWidget {
  final IconData icon;
  final String text;
  const _WeatherMini({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: AppColors.white80, size: 15), const SizedBox(width: 3), Text(text, style: const TextStyle(color: AppColors.white80, fontSize: 12, fontWeight: FontWeight.w600))]);
}

class _TinyButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;
  const _TinyButton({required this.label, required this.icon, required this.onTap, this.filled = false});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled ? AppColors.teal : AppColors.darkBlueLight.withValues(alpha: 0.65),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
          child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, size: 14, color: filled ? AppColors.darkBlue : AppColors.white80),
            const SizedBox(width: 4),
            Flexible(child: Text(label, overflow: TextOverflow.ellipsis, style: TextStyle(color: filled ? AppColors.darkBlue : AppColors.white80, fontSize: 10.5, fontWeight: FontWeight.w800))),
          ]),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;
  const _ActionButton({required this.label, required this.icon, required this.onTap, this.filled = false});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled ? AppColors.teal : AppColors.darkBlueLight,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: onTap,
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), border: Border.all(color: filled ? Colors.transparent : AppColors.teal.withValues(alpha: 0.20))),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, color: filled ? AppColors.darkBlue : AppColors.white80, size: 18),
            const SizedBox(width: 6),
            Flexible(child: Text(label, overflow: TextOverflow.ellipsis, style: TextStyle(color: filled ? AppColors.darkBlue : AppColors.white80, fontWeight: FontWeight.w800, fontSize: 12))),
          ]),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleButton({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.darkBlue.withValues(alpha: 0.45),
      shape: const CircleBorder(),
      child: InkWell(customBorder: const CircleBorder(), onTap: onTap, child: SizedBox(width: 42, height: 42, child: Icon(icon, color: AppColors.white, size: 20))),
    );
  }
}

class _BackgroundGlow extends StatelessWidget {
  const _BackgroundGlow();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
      child: Stack(children: [
        Positioned(right: -80, top: 170, child: Container(width: 190, height: 190, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.teal.withValues(alpha: 0.08)))),
        Positioned(left: -90, bottom: 120, child: Container(width: 220, height: 220, decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.cyan.withValues(alpha: 0.06)))),
      ]),
    );
  }
}

BoxDecoration _glassDecoration() {
  return BoxDecoration(
    color: AppColors.cardSurface.withValues(alpha: 0.88),
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: AppColors.teal.withValues(alpha: 0.13)),
  );
}

class _TripStop {
  final String time;
  final String period;
  final String dayPart;
  final String title;
  final String subtitle;
  final String location;
  final String image;
  final String action;
  final IconData actionIcon;
  final IconData weatherIcon;

  const _TripStop({required this.time, required this.period, required this.dayPart, required this.title, required this.subtitle, required this.location, required this.image, required this.action, required this.actionIcon, required this.weatherIcon});
}

class _TripInterest {
  final String label;
  final IconData icon;
  final bool selected;
  const _TripInterest(this.label, this.icon, this.selected);
}
