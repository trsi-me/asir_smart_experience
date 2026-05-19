import 'package:flutter/material.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/image_url.dart';

/// صورة من مسار شبكة أو من `assets/...`.
bool isAssetImagePath(String path) => path.startsWith('assets/');

class ContentImage extends StatelessWidget {
  final String path;
  final BoxFit fit;
  final double? width;
  final double? height;

  const ContentImage({
    super.key,
    required this.path,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final error = Container(
      color: AppColors.surface,
      alignment: Alignment.center,
      child: Icon(Icons.image_not_supported_outlined, color: AppColors.teal.withValues(alpha: 0.45), size: 36),
    );
    if (isAssetImagePath(path)) {
      return Image.asset(
        path,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (_, __, ___) => error,
      );
    }
    return Image.network(
      proxiedImageUrl(path),
      fit: fit,
      width: width,
      height: height,
      loadingBuilder: (_, child, progress) {
        if (progress == null) return child;
        return Container(
          width: width,
          height: height,
          color: AppColors.surface,
          alignment: Alignment.center,
          child: const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(color: AppColors.teal, strokeWidth: 2),
          ),
        );
      },
      errorBuilder: (_, __, ___) => error,
    );
  }
}
