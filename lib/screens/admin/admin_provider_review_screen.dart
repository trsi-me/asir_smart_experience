import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/data/database_helper.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/services/auth_service.dart';

/// مراجعة طلبات مقدّمي الأنشطة — للمسؤول فقط.
class AdminProviderReviewScreen extends StatefulWidget {
  const AdminProviderReviewScreen({super.key});

  @override
  State<AdminProviderReviewScreen> createState() => _AdminProviderReviewScreenState();
}

class _AdminProviderReviewScreenState extends State<AdminProviderReviewScreen> {
  List<Map<String, dynamic>> _list = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final pending = await DatabaseHelper.instance.getProviderApplicationsPending();
    if (mounted) {
      setState(() {
        _list = pending;
        _loading = false;
      });
    }
  }

  Future<void> _setStatus(int id, String status) async {
    HapticFeedback.lightImpact();
    await DatabaseHelper.instance.updateProviderApplicationStatus(id, status);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final email = AuthService().currentUserEmail ?? '';
    if (email != 'admin@asir.sa') {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.adminReviewTitle)),
        body: Center(child: Text(l10n.adminReviewHint, textAlign: TextAlign.center)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        title: Text(l10n.adminReviewTitle),
        actions: [
          IconButton(onPressed: _load, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.teal))
          : _list.isEmpty
              ? Center(child: Text(l10n.noPendingProviders, style: const TextStyle(color: AppColors.white80)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _list.length,
                  itemBuilder: (_, i) {
                    final r = _list[i];
                    final id = r['id'] as int;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.darkBlueLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.teal.withValues(alpha: 0.25)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${r['establishment_name']}', style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text('${r['category']} • ${r['city']}', style: const TextStyle(color: AppColors.teal)),
                          if (r['status'] == 'needs_revision') ...[
                            const SizedBox(height: 8),
                            Chip(
                              label: Text(l10n.statusNeedsEdit, style: const TextStyle(fontSize: 12)),
                              backgroundColor: AppColors.orange.withValues(alpha: 0.25),
                              side: BorderSide.none,
                            ),
                          ],
                          const SizedBox(height: 6),
                          Text('${r['email']} — ${r['phone']}', style: const TextStyle(color: AppColors.white80, fontSize: 13)),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              FilledButton(
                                onPressed: () => _setStatus(id, 'accepted'),
                                style: FilledButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: AppColors.white),
                                child: Text(l10n.statusAccepted),
                              ),
                              OutlinedButton(
                                onPressed: () => _setStatus(id, 'rejected'),
                                child: Text(l10n.statusRejected),
                              ),
                              OutlinedButton(
                                onPressed: () => _setStatus(id, 'needs_revision'),
                                child: Text(l10n.statusNeedsEdit),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
