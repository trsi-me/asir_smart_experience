import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/image_url.dart';

/// بلاطة صورة بخلفية كاملة - بدون كارد أو خط جانبي
class ImageTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback onTap;

  const ImageTile({
    super.key,
    required this.imageUrl,
    required this.title,
    this.subtitle,
    this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                proxiedImageUrl(imageUrl),
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    color: AppColors.darkBlue,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: progress.expectedTotalBytes != null
                            ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes ?? 1)
                            : null,
                        color: AppColors.teal,
                      ),
                    ),
                  );
                },
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.surface,
                  child: Icon(icon ?? Icons.image, size: 48, color: AppColors.teal.withValues(alpha: 0.5)),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withValues(alpha: 0.85)],
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Row(
                  children: [
                    if (icon != null) ...[
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(icon, color: AppColors.white, size: 24),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              subtitle!,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.white.withValues(alpha: 0.9),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
