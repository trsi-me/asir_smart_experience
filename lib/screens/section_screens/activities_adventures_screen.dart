import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/app_images.dart';
import 'package:asir_smart_experience/core/image_url.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/core/app_transitions.dart';
import 'package:asir_smart_experience/data/asir_real_content.dart';
import 'package:asir_smart_experience/screens/place_detail_screen.dart';
import 'package:asir_smart_experience/widgets/booking_sheet.dart';
import 'package:asir_smart_experience/widgets/image_list_item.dart';
import 'package:asir_smart_experience/widgets/section_scaffold.dart';

/// الأنشطة والمغامرات — بطاقات + فلاتر (بحري، جبلي، عائلي، صعوبة، موقع، طقس).
class ActivitiesAdventuresScreen extends StatefulWidget {
  const ActivitiesAdventuresScreen({super.key});

  @override
  State<ActivitiesAdventuresScreen> createState() => _ActivitiesAdventuresScreenState();
}

class _ActivitiesAdventuresScreenState extends State<ActivitiesAdventuresScreen> {
  String? _typeFilter;
  String? _difficultyFilter;
  String? _weatherFilter;
  String? _locationFilter;

  static final List<Map<String, String>> _activities = [
    {'title': 'زيارة الجزر', 'type': 'sea', 'diff': 'beginner', 'loc': 'البرك', 'weather': 'sunny', 'duration': '٥ ساعات', 'price': '٢٠٠ ر.س', 'img': AppImages.coastal},
    {'title': 'رحلة بحرية', 'type': 'sea', 'diff': 'beginner', 'loc': 'القحمة', 'weather': 'sunny', 'duration': '٣ ساعات', 'price': '١٢٠ ر.س', 'img': AppImages.coastal},
    {'title': 'غوص واستكشاف', 'type': 'sea', 'diff': 'intermediate', 'loc': 'البرك', 'weather': 'sunny', 'duration': '٤ ساعات', 'price': '٢٥٠ ر.س', 'img': AppImages.coastal},
    {'title': 'هايكنق — مسار مشي', 'type': 'mountain', 'diff': 'beginner', 'loc': 'السودة', 'weather': 'fog', 'duration': '٢ ساعة', 'price': '', 'img': AppImages.hiking},
    {'title': 'هايكنق للمبتدئين', 'type': 'mountain', 'diff': 'beginner', 'loc': 'رجال ألمع', 'weather': 'cloud', 'duration': '١.٥ ساعة', 'price': '', 'img': AppImages.hiking},
    {'title': 'رحلة مع مرشد', 'type': 'mountain', 'diff': 'intermediate', 'loc': 'أبها', 'weather': 'sunny', 'duration': '٥ ساعات', 'price': '٣٠٠ ر.س', 'img': AppImages.heritage},
    {'title': 'مغامرة جبلية', 'type': 'mountain', 'diff': 'advanced', 'loc': 'السودة', 'weather': 'sunny', 'duration': '٦ ساعات', 'price': '٤٠٠ ر.س', 'img': AppImages.hiking},
    {'title': 'تخييم وليل', 'type': 'family', 'diff': 'beginner', 'loc': 'رغدان', 'weather': 'fog', 'duration': 'ليلة', 'price': '١٥٠ ر.س', 'img': AppImages.camping},
    {'title': 'دراجات جبلية', 'type': 'mountain', 'diff': 'intermediate', 'loc': 'أبها', 'weather': 'sunny', 'duration': '٣ ساعات', 'price': '١٨٠ ر.س', 'img': AppImages.hiking},
    {'title': 'سفاري وطبيعة', 'type': 'family', 'diff': 'beginner', 'loc': 'طريق الفهيد', 'weather': 'sunny', 'duration': '٤ ساعات', 'price': '٢٢٠ ر.س', 'img': AppImages.heritage},
    {'title': 'جلسة تصوير طبيعية', 'type': 'family', 'diff': 'beginner', 'loc': 'السودة', 'weather': 'fog', 'duration': '٢ ساعة', 'price': '٣٥٠ ر.س', 'img': AppImages.today},
    {'title': 'نشاط عائلي', 'type': 'family', 'diff': 'beginner', 'loc': 'خميس مشيط', 'weather': 'cloud', 'duration': '٣ ساعات', 'price': '٨٠ ر.س', 'img': AppImages.local},
  ];

  List<Map<String, String>> get _filtered {
    return _activities.where((a) {
      if (_typeFilter != null && a['type'] != _typeFilter) return false;
      if (_difficultyFilter != null && a['diff'] != _difficultyFilter) return false;
      if (_weatherFilter != null && a['weather'] != _weatherFilter) return false;
      if (_locationFilter != null && a['loc'] != _locationFilter) return false;
      return true;
    }).toList();
  }

  String _diffLabel(BuildContext context, String key) {
    final l10n = context.l10n;
    switch (key) {
      case 'beginner':
        return l10n.difficultyBeginner;
      case 'intermediate':
        return l10n.difficultyIntermediate;
      case 'advanced':
        return l10n.difficultyAdvanced;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final list = _filtered;
    return SectionScaffold(
      title: l10n.activitiesAdventures,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Text(l10n.verifiedPlacesTitle, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.teal)),
          const SizedBox(height: 10),
          ...AsirRealContent.byCategory('activities').map((raw) {
            final place = AsirRealContent.toPlaceDetailMap(raw, isArabic: context.isArabic);
            final priceInfo = raw['price_info']?.toString();
            return ImageListItem(
              imageUrl: raw['primary_image'] as String?,
              title: place['name'] as String,
              subtitle: [place['subtitle'] as String?, priceInfo].whereType<String>().where((s) => s.isNotEmpty).join(' · '),
              onTap: () => Navigator.push(context, AppTransitions.slideFromLeft(PlaceDetailScreen(place: place))),
            );
          }),
          const SizedBox(height: 20),
          Text(l10n.filterByType, style: const TextStyle(color: AppColors.teal, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _chip(context, l10n.catCoastal, 'sea', _typeFilter, (v) => setState(() => _typeFilter = v)),
              _chip(context, l10n.catNature, 'mountain', _typeFilter, (v) => setState(() => _typeFilter = v)),
              _chip(context, l10n.activityFamily, 'family', _typeFilter, (v) => setState(() => _typeFilter = v)),
              ActionChip(
                label: Text(l10n.cancel),
                onPressed: () => setState(() => _typeFilter = null),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(l10n.filterByDifficulty, style: const TextStyle(color: AppColors.teal, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _chip(context, l10n.difficultyBeginner, 'beginner', _difficultyFilter, (v) => setState(() => _difficultyFilter = v)),
              _chip(context, l10n.difficultyIntermediate, 'intermediate', _difficultyFilter, (v) => setState(() => _difficultyFilter = v)),
              _chip(context, l10n.difficultyAdvanced, 'advanced', _difficultyFilter, (v) => setState(() => _difficultyFilter = v)),
              ActionChip(label: Text(l10n.cancel), onPressed: () => setState(() => _difficultyFilter = null)),
            ],
          ),
          const SizedBox(height: 16),
          Text(l10n.filterByLocation, style: const TextStyle(color: AppColors.teal, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _locChip('أبها', 'أبها'),
              _locChip('السودة', 'السودة'),
              _locChip('رجال ألمع', 'رجال ألمع'),
              _locChip('القحمة', 'القحمة'),
              _locChip('البرك', 'البرك'),
              ActionChip(label: Text(l10n.cancel), onPressed: () => setState(() => _locationFilter = null)),
            ],
          ),
          const SizedBox(height: 16),
          Text(l10n.filterByWeather, style: const TextStyle(color: AppColors.teal, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              FilterChip(
                label: Text(l10n.isArabic ? 'مشمس' : 'Sunny'),
                selected: _weatherFilter == 'sunny',
                onSelected: (_) => setState(() => _weatherFilter = _weatherFilter == 'sunny' ? null : 'sunny'),
              ),
              FilterChip(
                label: Text(l10n.isArabic ? 'ضباب' : 'Fog'),
                selected: _weatherFilter == 'fog',
                onSelected: (_) => setState(() => _weatherFilter = _weatherFilter == 'fog' ? null : 'fog'),
              ),
              FilterChip(
                label: Text(l10n.isArabic ? 'غائم' : 'Cloudy'),
                selected: _weatherFilter == 'cloud',
                onSelected: (_) => setState(() => _weatherFilter = _weatherFilter == 'cloud' ? null : 'cloud'),
              ),
              ActionChip(
                label: Text(l10n.cancel),
                onPressed: () => setState(() => _weatherFilter = null),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...list.map((a) => _ActivityCard(
                title: a['title']!,
                image: a['img']!,
                difficulty: _diffLabel(context, a['diff']!),
                duration: a['duration']!,
                price: a['price']!,
                location: a['loc']!,
                onBook: () {
                  HapticFeedback.lightImpact();
                  showBookingSheet(context, a['title']!);
                },
              )),
        ],
      ),
    );
  }

  Widget _chip(
    BuildContext context,
    String label,
    String value,
    String? selected,
    void Function(String?) onSelect,
  ) {
    final sel = selected == value;
    return FilterChip(
      label: Text(label),
      selected: sel,
      onSelected: (_) => onSelect(sel ? null : value),
    );
  }

  Widget _locChip(String label, String value) {
    final sel = _locationFilter == value;
    return FilterChip(
      label: Text(label),
      selected: sel,
      onSelected: (_) => setState(() => _locationFilter = sel ? null : value),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String title;
  final String image;
  final String difficulty;
  final String duration;
  final String price;
  final String location;
  final VoidCallback onBook;

  const _ActivityCard({
    required this.title,
    required this.image,
    required this.difficulty,
    required this.duration,
    required this.price,
    required this.location,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.darkBlueLight,
        border: Border.all(color: AppColors.teal.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  proxiedImageUrl(image),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: AppColors.surface, child: const Icon(Icons.landscape, color: AppColors.teal, size: 48)),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withValues(alpha: 0.65)],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$location • $difficulty', style: const TextStyle(color: AppColors.white80)),
                const SizedBox(height: 6),
                Text('${l10n.durationLabel}: $duration${price.isNotEmpty ? ' • ${l10n.priceOptional}: $price' : ''}', style: TextStyle(color: AppColors.teal.withValues(alpha: 0.9))),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: onBook,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.teal,
                    foregroundColor: AppColors.darkBlue,
                    minimumSize: const Size(double.infinity, 44),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(l10n.bookNow),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
