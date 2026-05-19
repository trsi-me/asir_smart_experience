import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/data/database_helper.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/screens/provider/provider_dashboard_screen.dart';

/// باقات الاشتراك والدفع (تجريبي محلي) — ثم قيد المراجعة.
class ProviderSubscriptionScreen extends StatefulWidget {
  final Map<String, dynamic> draft;

  const ProviderSubscriptionScreen({super.key, required this.draft});

  @override
  State<ProviderSubscriptionScreen> createState() => _ProviderSubscriptionScreenState();
}

class _ProviderSubscriptionScreenState extends State<ProviderSubscriptionScreen> {
  String _packageId = 'basic';
  String _payment = 'mada';

  Future<void> _submit() async {
    HapticFeedback.lightImpact();
    final now = DateTime.now().toIso8601String();
    final row = {
      'establishment_name': widget.draft['establishment_name'],
      'activity_type': widget.draft['activity_type'],
      'contact_name': widget.draft['contact_name'],
      'phone': widget.draft['phone'],
      'email': widget.draft['email'],
      'city': widget.draft['city'],
      'description': widget.draft['description'],
      'category': widget.draft['category'],
      'map_url': widget.draft['map_url'],
      'hours': widget.draft['hours'],
      'price_note': widget.draft['price_note'],
      'booking_link': widget.draft['booking_link'],
      'social': widget.draft['social'],
      'activity_photos': widget.draft['activity_photos'] ?? '',
      'package_id': _packageId,
      'payment_method': _payment,
      'status': 'pending',
      'subscribed_until': DateTime.now().add(const Duration(days: 365)).toIso8601String(),
      'created_at': now,
    };
    await DatabaseHelper.instance.insertProviderApplication(row);
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkBlueLight,
        title: Text(context.l10n.pendingApprovalTitle, style: const TextStyle(color: AppColors.white)),
        content: Text(
          context.l10n.pendingApprovalSubtitle,
          style: const TextStyle(color: AppColors.white80),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(context.l10n.save, style: const TextStyle(color: AppColors.teal)),
          ),
        ],
      ),
    );
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ProviderDashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        title: Text(l10n.subscriptionPackages),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _packageTile(
            context,
            id: 'basic',
            title: l10n.packageBasic,
            body: l10n.packageBasicFeatures,
            price: '٩٩ ر.س / شهر',
          ),
          _packageTile(
            context,
            id: 'featured',
            title: l10n.packageFeatured,
            body: l10n.packageFeaturedFeatures,
            price: '٢٩٩ ر.س / شهر',
          ),
          _packageTile(
            context,
            id: 'pro',
            title: l10n.packagePro,
            body: l10n.packageProFeatures,
            price: '٥٩٩ ر.س / شهر',
          ),
          const SizedBox(height: 16),
          Text(l10n.paymentMethod, style: const TextStyle(color: AppColors.teal, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ...['mada', 'apple_pay', 'stc_pay', 'bank'].map((p) {
            final labels = {
              'mada': l10n.isArabic ? 'مدى' : 'mada',
              'apple_pay': 'Apple Pay',
              'stc_pay': 'STC Pay',
              'bank': l10n.isArabic ? 'تحويل بنكي' : 'Bank transfer',
            };
            return RadioListTile<String>(
              value: p,
              groupValue: _payment,
              onChanged: (v) => setState(() => _payment = v ?? 'mada'),
              title: Text(labels[p]!, style: const TextStyle(color: AppColors.white)),
              activeColor: AppColors.teal,
            );
          }),
          const SizedBox(height: 24),
          Text(l10n.paySimulated, style: TextStyle(color: AppColors.white80.withValues(alpha: 0.85))),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: _submit,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.teal,
              foregroundColor: AppColors.darkBlue,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(l10n.confirmSubscription),
          ),
        ],
      ),
    );
  }

  Widget _packageTile(
    BuildContext context, {
    required String id,
    required String title,
    required String body,
    required String price,
  }) {
    final sel = _packageId == id;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppColors.darkBlueLight,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => setState(() => _packageId = id),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: sel ? AppColors.teal : AppColors.teal.withValues(alpha: 0.2), width: sel ? 2 : 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(sel ? Icons.check_circle : Icons.circle_outlined, color: AppColors.teal),
                    const SizedBox(width: 8),
                    Expanded(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white))),
                    Text(price, style: const TextStyle(color: AppColors.amber, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(body, style: const TextStyle(color: AppColors.white80, height: 1.45)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
