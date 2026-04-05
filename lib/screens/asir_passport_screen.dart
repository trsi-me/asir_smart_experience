import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/data/database_helper.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/services/auth_service.dart';

/// جواز عسير - المحور المركزي للتطبيق
class AsirPassportScreen extends StatefulWidget {
  const AsirPassportScreen({super.key});

  @override
  State<AsirPassportScreen> createState() => _AsirPassportScreenState();
}

class _AsirPassportScreenState extends State<AsirPassportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DatabaseHelper _db = DatabaseHelper.instance;

  int _points = 0;
  List<Map<String, dynamic>> _stamps = [];
  List<Map<String, dynamic>> _trips = [];
  List<Map<String, dynamic>> _badges = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    final uid = AuthService().currentUserId;
    final points = await _db.getPoints(uid);
    final stamps = await _db.getStamps(uid);
    final trips = await _db.getTrips(uid);
    final badges = await _db.getBadges(uid);
    setState(() {
      _points = points;
      _stamps = stamps;
      _trips = trips;
      _badges = badges;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
        title: Text(context.l10n.passport),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: context.l10n.overview),
            Tab(text: context.l10n.stamps),
            Tab(text: context.l10n.challenges),
            Tab(text: context.l10n.trips),
            Tab(text: context.l10n.certificate),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.teal))
          : TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(context),
                _buildStampsTab(context),
                _buildChallengesTab(context),
                _buildTripsTab(context),
                _buildCertificateTab(context),
              ],
            ),
    );
  }

  Widget _buildOverviewTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildPointsCard(context),
        const SizedBox(height: 16),
        _buildSeasonalStampsInfo(context),
        const SizedBox(height: 16),
        _buildRewardsCard(context),
        const SizedBox(height: 16),
        _buildAddStampButton(context),
      ],
    );
  }

  Widget _buildPointsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.teal.withValues(alpha: 0.15),
            AppColors.darkBlueLight,
            AppColors.teal.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.teal.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(color: AppColors.teal.withValues(alpha: 0.15), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [AppColors.teal, AppColors.green]),
              boxShadow: [BoxShadow(color: AppColors.teal.withValues(alpha: 0.4), blurRadius: 16, spreadRadius: 0)],
            ),
            child: const Icon(Icons.workspace_premium, size: 44, color: AppColors.white),
          ),
          const SizedBox(height: 20),
          Text('$_points', style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: AppColors.teal, height: 1.1)),
          Text(context.l10n.points, style: const TextStyle(fontSize: 18, color: AppColors.white80)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _statChip(context, Icons.badge, '${_stamps.length}', context.l10n.stamps),
              const SizedBox(width: 16),
              _statChip(context, Icons.emoji_events, '${_badges.length}', context.l10n.badges),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statChip(BuildContext context, IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.darkBlue.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.teal.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.teal),
          const SizedBox(width: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12, color: AppColors.white80)),
        ],
      ),
    );
  }

  Widget _buildSeasonalStampsInfo(BuildContext context) {
    final l10n = context.l10n;
    final items = [
      {'name': l10n.stampFog, 'icon': Icons.cloud, 'color': AppColors.cyan},
      {'name': l10n.stampCoffee, 'icon': Icons.coffee, 'color': AppColors.amber},
      {'name': l10n.stampSummer, 'icon': Icons.wb_sunny, 'color': AppColors.orange},
      {'name': l10n.stampWinter, 'icon': Icons.ac_unit, 'color': AppColors.tealBright},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_awesome, color: AppColors.teal, size: 22),
            const SizedBox(width: 8),
            Text(context.l10n.seasonalStamps, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white)),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) {
              final item = items[i];
              return Container(
                width: 90,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (item['color'] as Color).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: (item['color'] as Color).withValues(alpha: 0.4)),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(item['icon'] as IconData, size: 28, color: item['color'] as Color),
                      const SizedBox(height: 8),
                      Text(
                        item['name'] as String,
                        style: TextStyle(fontSize: 13, color: AppColors.white80),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRewardsCard(BuildContext context) {
    final l10n = context.l10n;
    final rewards = [
      {'text': l10n.reward1, 'tag': l10n.offer, 'icon': Icons.local_cafe},
      {'text': l10n.reward2, 'tag': l10n.offer, 'icon': Icons.agriculture},
      {'text': l10n.reward3, 'tag': l10n.demo, 'icon': Icons.card_giftcard},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.discount, color: AppColors.greenVivid, size: 22),
            const SizedBox(width: 8),
            Text(context.l10n.rewardsDiscounts, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white)),
          ],
        ),
        const SizedBox(height: 14),
        ...rewards.map((r) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.darkBlueLight,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.greenVivid.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.greenVivid.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
                    child: Icon(r['icon'] as IconData, color: AppColors.greenVivid, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: Text(r['text'] as String, style: const TextStyle(color: AppColors.white80, fontSize: 14))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.greenVivid.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(8)),
                    child: Text(r['tag'] as String, style: const TextStyle(fontSize: 12, color: AppColors.greenVivid, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildAddStampButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: () => _showAddStampDialog(),
        icon: const Icon(Icons.add_circle_outline),
        label: Text(context.l10n.addStampDemo),
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.teal,
          foregroundColor: AppColors.darkBlue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }

  void _showAddStampDialog() {
    final l10n = context.l10n;
    final places = [
      {'id': 'fog', 'name': l10n.placeFogSeason, 'cat': l10n.catFog},
      {'id': 'coffee', 'name': l10n.placeCoffeeFarm, 'cat': l10n.catCoffeeBean},
      {'id': 'heritage', 'name': l10n.placeRijalVillage, 'cat': l10n.catHeritageShort},
    ];
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        shrinkWrap: true,
        itemCount: places.length,
        itemBuilder: (_, i) {
          final p = places[i];
          return ListTile(
            title: Text(p['name']!),
            onTap: () async {
              await _db.addStamp(AuthService().currentUserId, p['id']!, p['name']!, p['cat']!);
              if (context.mounted) Navigator.pop(context);
              _loadData();
            },
          );
        },
      ),
    );
  }

  Widget _buildStampsTab(BuildContext context) {
    final l10n = context.l10n;
    if (_stamps.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.badge, size: 64, color: AppColors.teal),
            const SizedBox(height: 16),
            Text(l10n.noStampsYet),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _showAddStampDialog,
                icon: const Icon(Icons.add_circle_outline, size: 22),
                label: Text(l10n.addStamp, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.teal,
                  foregroundColor: AppColors.darkBlue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _stamps.length,
        itemBuilder: (_, i) {
        final s = _stamps[i];
        final stampId = s['id'] as int?;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.darkBlueLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.teal.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppColors.teal.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.place, color: AppColors.teal, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s['place_name'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white)),
                    Text('${s['category']}', style: TextStyle(fontSize: 13, color: AppColors.white80)),
                  ],
                ),
              ),
              if (stampId != null)
                IconButton(
                  onPressed: () => _showWithdrawVisitDialog(stampId),
                  icon: const Icon(Icons.remove_circle_outline, color: AppColors.rose, size: 22),
                  tooltip: l10n.withdrawVisit,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChallengesTab(BuildContext context) {
    final l10n = context.l10n;
    final challenges = [
      {'id': 'c1', 'name': l10n.challenge1},
      {'id': 'c2', 'name': l10n.challenge2},
      {'id': 'c3', 'name': l10n.challenge3},
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: challenges.length,
      itemBuilder: (_, i) {
        final c = challenges[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.darkBlueLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.green.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppColors.green.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.flag, color: AppColors.green, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(child: Text(c['name'] as String, style: const TextStyle(fontSize: 16, color: AppColors.white))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: AppColors.amber.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                child: Text(context.l10n.inProgress, style: const TextStyle(fontSize: 12, color: AppColors.amber)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTripsTab(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () => _showAddTripDialog(),
            icon: const Icon(Icons.add_road, size: 24),
            label: Text(l10n.addTrip, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.teal,
              foregroundColor: AppColors.darkBlue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (_trips.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(l10n.noTrips),
            ),
          )
        else
          ..._trips.map((t) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.darkBlueLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.teal.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: AppColors.teal.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.route, color: AppColors.teal, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t['destination'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white)),
                          Text('${t['date']}', style: TextStyle(fontSize: 13, color: AppColors.white80)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
      ],
    );
  }

  void _showAddTripDialog() {
    final l10n = context.l10n;
    final dest = TextEditingController();
    final date = TextEditingController(text: DateTime.now().toString().split(' ')[0]);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.addTrip),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: dest, decoration: InputDecoration(labelText: l10n.destination)),
            TextField(controller: date, decoration: InputDecoration(labelText: l10n.date)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
          ElevatedButton(
            onPressed: () async {
              await _db.addTrip(AuthService().currentUserId, dest.text, date.text);
              if (context.mounted) Navigator.pop(context);
              _loadData();
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  void _showWithdrawVisitDialog(int stampId) {
    final l10n = context.l10n;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.withdrawVisit),
        content: Text(l10n.withdrawVisitConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.rose),
            onPressed: () async {
              await _db.removeStamp(AuthService().currentUserId, stampId);
              if (context.mounted) Navigator.pop(context);
              _loadData();
            },
            child: Text(l10n.withdrawVisit),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateTab(BuildContext context) {
    final l10n = context.l10n;
    final hasCertificate = _stamps.length >= 3 || _badges.isNotEmpty;
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(36),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: hasCertificate
                ? [AppColors.green.withValues(alpha: 0.2), AppColors.darkBlueLight]
                : [AppColors.teal.withValues(alpha: 0.15), AppColors.darkBlueLight],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: hasCertificate ? AppColors.green.withValues(alpha: 0.5) : AppColors.teal.withValues(alpha: 0.5)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (hasCertificate ? AppColors.green : AppColors.teal).withValues(alpha: 0.2),
              ),
              child: Icon(
                hasCertificate ? Icons.verified : Icons.pending_actions,
                size: 64,
                color: hasCertificate ? AppColors.green : AppColors.teal,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              hasCertificate ? l10n.digitalCertificate : l10n.certificatePending,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              hasCertificate ? l10n.certificateComplete : l10n.certificateHint,
              style: TextStyle(fontSize: 15, color: AppColors.white80),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
