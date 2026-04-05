import 'package:flutter/material.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/core/app_images.dart';
import 'package:asir_smart_experience/services/api_service.dart';
import 'package:asir_smart_experience/widgets/booking_sheet.dart';
import 'package:asir_smart_experience/widgets/section_scaffold.dart';
import 'package:asir_smart_experience/widgets/image_tile.dart';

/// وش فيه اليوم؟ - بلاطات مصورة
class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  List<Map<String, dynamic>> _events = [];
  bool _loading = true;
  bool _smartMode = false;

  @override
  void initState() {
    super.initState();
    _loadRecommendations();
  }

  Future<void> _loadRecommendations() async {
    setState(() => _loading = true);
    final smart = await ApiService().getSmartTodayRecommendations(weather: 'مشمس');
    if (!mounted) return;
    final data = context.localizedData;
    setState(() {
      _events = smart ?? data.todayEvents;
      _smartMode = smart != null;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final data = context.localizedData;
    return SectionScaffold(
      title: l10n.today,
      actions: [
        if (_smartMode)
          Container(
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.greenVivid.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.auto_awesome, color: AppColors.greenVivid, size: 14),
                const SizedBox(width: 4),
                Text(l10n.smart, style: const TextStyle(fontSize: 12, color: AppColors.greenVivid, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
      ],
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.teal))
          : RefreshIndicator(
              onRefresh: _loadRecommendations,
              color: AppColors.teal,
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                  ImageTile(
                    imageUrl: AppImages.today,
                    title: l10n.todayEvents,
                    subtitle: _smartMode ? l10n.personalizedRecommendations : l10n.discoverWhatAwaits,
                    onTap: () => showBookingSheet(context, l10n.todayEvents),
                  ),
                  ..._events.asMap().entries.map((e) {
                    final event = e.value;
                    final eventImages = [AppImages.today, AppImages.weather, AppImages.heritage];
                    final img = event['image'] as String? ?? eventImages[e.key % eventImages.length];
                    return ImageTile(
                      imageUrl: img,
                      title: event['title'] as String,
                      subtitle: '${event['time']} • ${event['location']}',
                      onTap: () => showBookingSheet(context, event['title'] as String),
                    );
                  }),
                  const SizedBox(height: 16),
                  ...data.weekendEvents.map((e) => ImageTile(
                    imageUrl: (e['image'] as String?) ?? AppImages.local,
                    title: e['title'] as String,
                    subtitle: '${e['day']} • ${e['location']}',
                    onTap: () {},
                  )),
                ],
              ),
            ),
    );
  }
}
