import 'package:flutter/material.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/app_images.dart';
import 'package:asir_smart_experience/core/image_url.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/widgets/section_scaffold.dart';
import 'package:asir_smart_experience/widgets/image_list_item.dart';

/// من أهلها - أسر منتجة بتصميم مصور
class LocalShopsScreen extends StatelessWidget {
  const LocalShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final data = context.localizedData;
    return SectionScaffold(
      title: l10n.local,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          _buildHeaderImage(context),
          const SizedBox(height: 24),
          ...data.localShops.map((s) => ImageListItem(
            imageUrl: s['image'] as String?,
            title: s['name'] as String,
            subtitle: '⭐ ${s['rating']}',
          )),
        ],
      ),
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            proxiedImageUrl(AppImages.local),
            fit: BoxFit.cover,
            loadingBuilder: (_, child, p) => p == null ? child : Container(color: AppColors.darkBlue, child: const Center(child: CircularProgressIndicator(color: AppColors.teal))),
            errorBuilder: (_, __, ___) => Container(color: AppColors.surface),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Text(context.l10n.supportLocalEconomy, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.white)),
          ),
        ],
      ),
    );
  }
}
