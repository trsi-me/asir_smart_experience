import 'package:flutter/material.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/services/api_service.dart';
import 'package:asir_smart_experience/widgets/section_scaffold.dart';

/// جوّك اليوم - توصيات ذكية حسب الطقس
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic>? _smartRecommendations;
  bool _loading = true;
  bool _smartMode = false;

  @override
  void initState() {
    super.initState();
    _loadRecommendations();
  }

  Future<void> _loadRecommendations() async {
    setState(() => _loading = true);
    final api = ApiService();
    final r = await api.getWeatherRecommendations('مشمس');
    setState(() {
      _smartRecommendations = r;
      _smartMode = r != null;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final data = context.localizedData;
    return SectionScaffold(
      title: l10n.weather,
      actions: [
        if (_smartMode)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Chip(
              label: Text(l10n.smart, style: const TextStyle(fontSize: 12)),
              backgroundColor: AppColors.green,
            ),
          ),
      ],
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.teal))
          : RefreshIndicator(
              onRefresh: _loadRecommendations,
              color: AppColors.teal,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildWeatherCard(context, data.weatherData[0], isToday: true),
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, l10n.fogRainAlerts),
                  _buildAlertsCard(context),
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, l10n.upcomingForecast),
                  ...data.weatherData.skip(1).map((w) => _buildWeatherCard(context, w)),
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, l10n.weatherSuggestions),
                  _buildSuggestionsCard(context),
                ],
              ),
            ),
    );
  }

  IconData _weatherIcon(String? iconId) {
    switch (iconId) {
      case 'sunny': return Icons.wb_sunny;
      case 'fog': return Icons.cloud;
      case 'cloud': return Icons.cloud;
      default: return Icons.wb_sunny;
    }
  }

  Widget _buildAlertsCard(BuildContext context) {
    final alertsRaw = _smartRecommendations?['alerts'];
    final alerts = alertsRaw is List && alertsRaw.isNotEmpty
        ? alertsRaw.map((e) => e.toString()).toList()
        : [context.l10n.isArabic ? 'توقعات ضباب خفيف صباح الغد - ينصح بتأخير الرحلات الصباحية' : 'Light fog expected tomorrow morning - delay morning trips'];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: alerts.map<Widget>((a) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber, color: AppColors.amber, size: 24),
              const SizedBox(width: 12),
              Expanded(child: Text(a.toString(), style: const TextStyle(fontSize: 15, color: AppColors.white))),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildSuggestionsCard(BuildContext context) {
    final l10n = context.l10n;
    final data = context.localizedData;
    final condition = data.weatherData[0]['condition'] ?? (l10n.isArabic ? 'مشمس' : 'Sunny');
    List<Map<String, dynamic>> suggestions = [];
    final cond = condition.toString().toLowerCase();
    if (cond.contains('Fog') || cond.contains('ضباب') || cond.contains('Cloud') || cond.contains('غائم')) {
      suggestions = [
        {'place': l10n.isArabic ? 'ممشى الضباب - النماص' : 'Fog Walk - Al Namas', 'activity': l10n.isArabic ? 'تجربة الضباب' : 'Fog experience'},
        {'place': l10n.isArabic ? 'حديقة السحاب - أبها' : 'Cloud Garden - Abha', 'activity': l10n.isArabic ? 'التصوير' : 'Photography'},
        {'place': l10n.isArabic ? 'مقهى جبلي' : 'Mountain cafe', 'activity': l10n.southernCoffee},
      ];
    } else if (cond.contains('Sun') || cond.contains('مشمس')) {
      suggestions = [
        {'place': l10n.isArabic ? 'شلالات الدهناء' : 'Dahna Waterfalls', 'activity': l10n.isArabic ? 'مشي وتصوير' : 'Hiking & photography'},
        {'place': l10n.isArabic ? 'منتزه تهلل' : 'Tahlal Park', 'activity': l10n.isArabic ? 'تخييم' : 'Camping'},
        {'place': l10n.isArabic ? 'قرية رجال ألمع' : 'Rijal Almaa Village', 'activity': l10n.isArabic ? 'تراث' : 'Heritage'},
      ];
    } else {
      suggestions = [
        {'place': l10n.isArabic ? 'متحف أبها' : 'Abha Museum', 'activity': l10n.isArabic ? 'ثقافة' : 'Culture'},
        {'place': l10n.isArabic ? 'سوق الثلاثاء' : 'Tuesday Market', 'activity': l10n.isArabic ? 'تسوق' : 'Shopping'},
        {'place': l10n.isArabic ? 'المدينة العالية' : 'Al Taelya City', 'activity': l10n.isArabic ? 'إطلالات' : 'Views'},
      ];
    }
    if (_smartMode && _smartRecommendations != null) {
      final activities = _smartRecommendations!['best_activities'] as List?;
      if (activities != null && activities.isNotEmpty) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardSurface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.weatherSuggestions, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.white)),
              const SizedBox(height: 12),
              ...activities.map<Widget>((a) {
                final map = a is Map ? a as Map<String, dynamic> : <String, dynamic>{};
                final name = map['name'] ?? '';
                final places = map['places'] as List? ?? [];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text('• $name ${places.isNotEmpty ? '- ${places.join(', ')}' : ''}', style: const TextStyle(color: AppColors.white80)),
                );
              }),
            ],
          ),
        );
      }
    }
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${l10n.todaySuggestions} ($condition)', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.white)),
          const SizedBox(height: 12),
          ...suggestions.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(Icons.place, size: 18, color: AppColors.teal),
                    const SizedBox(width: 8),
                    Expanded(child: Text('${s['place']} - ${s['activity']}', style: const TextStyle(fontSize: 14, color: AppColors.white80))),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.teal),
      ),
    );
  }

  Widget _buildWeatherCard(BuildContext context, Map<String, dynamic> w, {bool isToday = false}) {
    final iconId = w['iconId'] as String? ?? w['icon'];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            w['day'] as String,
            style: TextStyle(
              fontSize: isToday ? 20 : 16,
              fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
              color: AppColors.white,
            ),
          ),
          Icon(_weatherIcon(iconId?.toString()), color: AppColors.amber, size: 32),
          Text(w['temp'] as String, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.teal)),
          Expanded(
            child: Text(w['condition'] as String, style: const TextStyle(fontSize: 14, color: AppColors.white80), textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }
}
