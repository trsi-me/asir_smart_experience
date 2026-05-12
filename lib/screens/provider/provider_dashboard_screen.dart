import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/passport_stamp_policy.dart';
import 'package:asir_smart_experience/data/database_helper.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/services/auth_service.dart';
import 'package:asir_smart_experience/screens/provider/provider_subscription_screen.dart';

/// لوحة تحكم صاحب النشاط — حالة النشر، تفاصيل الاشتراك، العروض، تجديد الباقة.
class ProviderDashboardScreen extends StatefulWidget {
  const ProviderDashboardScreen({super.key});

  @override
  State<ProviderDashboardScreen> createState() =>
      _ProviderDashboardScreenState();
}

class _ProviderDashboardScreenState extends State<ProviderDashboardScreen> {
  Map<String, dynamic>? _application;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final email = AuthService().currentUserEmail;
    if (email == null) {
      setState(() => _loading = false);
      return;
    }
    final app =
        await DatabaseHelper.instance.getLatestProviderApplicationByEmail(email);
    if (mounted) {
      setState(() {
        _application = app;
        _loading = false;
      });
    }
  }

  String _statusLabel(BuildContext context, String? status) {
    final l10n = context.l10n;
    switch (status) {
      case 'accepted':
        return l10n.statusAccepted;
      case 'rejected':
        return l10n.statusRejected;
      case 'needs_revision':
        return l10n.statusNeedsEdit;
      default:
        return l10n.statusPendingReview;
    }
  }

  Color _statusColor(String? status) {
    switch (status) {
      case 'accepted':
        return AppColors.green;
      case 'rejected':
        return AppColors.rose;
      case 'needs_revision':
        return AppColors.orange;
      default:
        return AppColors.amber;
    }
  }

  String _formatDate(String? iso) {
    if (iso == null || iso.isEmpty) return '—';
    try {
      final dt = DateTime.parse(iso);
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return iso;
    }
  }

  List<String> _decodePhotoPaths(String? raw) {
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list.map((e) => e.toString()).where((s) => s.isNotEmpty).toList();
    } catch (_) {
      return [];
    }
  }

  List<Map<String, String>> _decodeOffers(String? raw) {
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .whereType<Map<String, dynamic>>()
          .map((e) => {
                'title': (e['title'] ?? '').toString(),
                'description': (e['description'] ?? '').toString(),
              })
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _showAddOfferSheet() async {
    if (_application == null) return;
    final id = _application!['id'] as int;
    final l10n = context.l10n;
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final added = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkBlueLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.addOffer,
              style: AppTheme.arabicTextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: titleCtrl,
              style: AppTheme.arabicTextStyle(color: AppColors.white),
              decoration: InputDecoration(
                hintText: l10n.offerHint,
                hintStyle: AppTheme.arabicTextStyle(color: AppColors.white80),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descCtrl,
              maxLines: 2,
              style: AppTheme.arabicTextStyle(color: AppColors.white),
              decoration: InputDecoration(
                hintText: l10n.shortDescription,
                hintStyle: AppTheme.arabicTextStyle(color: AppColors.white80),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.teal,
                foregroundColor: AppColors.darkBlue,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
    if (added == true && titleCtrl.text.trim().isNotEmpty) {
      final list = _decodeOffers(_application!['offers'] as String?);
      list.add({
        'title': titleCtrl.text.trim(),
        'description': descCtrl.text.trim(),
      });
      await DatabaseHelper.instance
          .updateProviderApplicationOffers(id, jsonEncode(list));
      await _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        appBar: AppBar(
          title: Text(l10n.providerDashboardTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
          ),
          actions: [
            IconButton(onPressed: _load, icon: const Icon(Icons.refresh)),
          ],
        ),
        body: _loading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.teal),
              )
            : _application == null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        l10n.providerEmailNotMatched,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.white80,
                          height: 1.5,
                        ),
                      ),
                    ),
                  )
                : _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final l10n = context.l10n;
    final app = _application!;
    final status = app['status'] as String?;
    final category = app['category'] as String? ?? '';
    final mappedStamp = PassportStampPolicy.categoryToStampPlaceId[category];
    final isAccepted = status == 'accepted';
    final linkedToPassport = isAccepted && mappedStamp != null;
    final offers = _decodeOffers(app['offers'] as String?);
    final photos = _decodePhotoPaths(app['activity_photos'] as String?);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _card(
          context,
          title: l10n.publishStatus,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _statusLabel(context, status),
                style: TextStyle(
                  color: _statusColor(status),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${app['establishment_name']}  •  ${app['category']}',
                style: const TextStyle(color: AppColors.white80),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    linkedToPassport ? Icons.verified : Icons.link_off,
                    color: linkedToPassport ? AppColors.green : AppColors.white80,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      linkedToPassport
                          ? l10n.linkedToPassport
                          : l10n.notLinkedToPassport,
                      style: TextStyle(
                        color: linkedToPassport
                            ? AppColors.green
                            : AppColors.white80,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _card(
          context,
          title: l10n.subscriptionInfo,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _kv(context, l10n.categoryPick, '${app['category']}'),
              _kv(context, l10n.activityPhotosCount, '${photos.length}'),
              _kv(context, l10n.subscriptionPackages,
                  _packageLabel(context, app['package_id'] as String?)),
              _kv(context, l10n.paymentMethod,
                  '${app['payment_method'] ?? '—'}'),
              _kv(context, l10n.subscriptionUntil,
                  _formatDate(app['subscribed_until'] as String?)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _card(
          context,
          title: l10n.offersAndDiscounts,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (offers.isEmpty)
                Text(l10n.noOffersYet,
                    style: const TextStyle(color: AppColors.white80)),
              ...offers.map(
                (o) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.local_offer,
                          color: AppColors.teal, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              o['title'] ?? '',
                              style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if ((o['description'] ?? '').isNotEmpty)
                              Text(
                                o['description'] ?? '',
                                style: const TextStyle(
                                  color: AppColors.white80,
                                  fontSize: 13,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: isAccepted ? _showAddOfferSheet : null,
                icon: const Icon(Icons.add),
                label: Text(l10n.addOffer),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.teal,
                  side: const BorderSide(color: AppColors.teal),
                ),
              ),
              if (!isAccepted) ...[
                const SizedBox(height: 6),
                Text(
                  l10n.notLinkedToPassport,
                  style: const TextStyle(
                    color: AppColors.white80,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        _card(
          context,
          title: l10n.editListing,
          child: Text(
            l10n.isArabic
                ? 'تعديل الوصف، الصور، ساعات العمل، العروض — يُفعّل بالكامل بعد اعتماد النشاط من الإدارة.'
                : 'Edit description, photos, hours, offers — fully enabled after admin approval.',
            style: const TextStyle(color: AppColors.white80, height: 1.5),
          ),
        ),
        const SizedBox(height: 12),
        _card(
          context,
          title: l10n.renewPackage,
          child: FilledButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProviderSubscriptionScreen(
                    draft: {
                      'establishment_name': app['establishment_name'] ?? '—',
                      'activity_type': app['activity_type'] ?? '—',
                      'contact_name': app['contact_name'] ?? '—',
                      'phone': app['phone'] ?? '—',
                      'email': app['email'] ?? 'renew@local',
                      'city': app['city'] ?? '—',
                      'description': app['description'] ?? '—',
                      'category': app['category'] ?? 'أخرى',
                      'map_url': app['map_url'] ?? '',
                      'hours': app['hours'] ?? '',
                      'price_note': app['price_note'] ?? '',
                      'booking_link': app['booking_link'] ?? '',
                      'social': app['social'] ?? '',
                      'activity_photos': app['activity_photos'] ?? '[]',
                    },
                  ),
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.teal,
              foregroundColor: AppColors.darkBlue,
            ),
            child: Text(l10n.renewPackage),
          ),
        ),
      ],
    );
  }

  String _packageLabel(BuildContext context, String? id) {
    final l10n = context.l10n;
    switch (id) {
      case 'featured':
        return l10n.packageFeatured;
      case 'pro':
        return l10n.packagePro;
      default:
        return l10n.packageBasic;
    }
  }

  Widget _kv(BuildContext context, String k, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              k,
              style: const TextStyle(
                color: AppColors.white80,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              v,
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkBlueLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.teal.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.teal,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
