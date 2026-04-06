import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/image_url.dart';

/// عنصر قائمة بصورة - كارد واضح، صورة موحدة باليمين تملأ الارتفاع
class ImageListItem extends StatelessWidget {
  static const double _cardHeight = 120;
  static const double _imageSize = 120;

  final String? imageUrl;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const ImageListItem({
    super.key,
    this.imageUrl,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final imageWidget = imageUrl != null
        ? SizedBox(
            width: _imageSize,
            height: _cardHeight,
            child: Image.network(
              proxiedImageUrl(imageUrl!),
              fit: BoxFit.cover,
              loadingBuilder: (_, child, p) => p == null ? child : Container(color: AppColors.surface, child: const Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: AppColors.teal, strokeWidth: 2)))),
              errorBuilder: (_, __, ___) => Container(color: AppColors.surface, child: Icon(Icons.place, color: AppColors.teal.withValues(alpha: 0.5), size: 36)),
            ),
          )
        : null;

    final content = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
            if (subtitle != null) ...[
              const SizedBox(height: 6),
              Text(subtitle!, style: const TextStyle(fontSize: 13, color: AppColors.white80), maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ],
        ),
      ),
    );

    final arrow = onTap != null
        ? const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.white80),
          )
        : null;

    return GestureDetector(
      onTap: onTap != null ? () { HapticFeedback.lightImpact(); onTap!(); } : null,
      child: Container(
        height: _cardHeight,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Row(
            children: isRtl && imageWidget != null
                ? [imageWidget, content, if (arrow != null) arrow]
                : [content, if (arrow != null) arrow, if (imageWidget != null) imageWidget],
          ),
        ),
      ),
    );
  }
}
