import 'package:flutter/material.dart';
import 'package:asir_smart_experience/core/app_theme.dart';

/// زخرفة القط العسيري - لمسات الهوية العسيرية
class AsiriCatDecoration extends StatelessWidget {
  final double height;
  final Color? color;

  const AsiriCatDecoration({super.key, this.height = 24, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.teal.withValues(alpha: 0.6);
    return CustomPaint(
      size: Size(double.infinity, height),
      painter: _AsiriCatPainter(color: c),
    );
  }
}

class _AsiriCatPainter extends CustomPainter {
  final Color color;

  _AsiriCatPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final step = w / 12;
    for (var i = 0.0; i < w; i += step) {
      _drawCatSilhouette(canvas, Offset(i + step / 2, h / 2), step * 0.4);
    }
  }

  void _drawCatSilhouette(Canvas canvas, Offset center, double r) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, r, paint);
    canvas.drawCircle(center + Offset(-r * 0.4, -r * 0.3), r * 0.2, paint);
    canvas.drawCircle(center + Offset(r * 0.4, -r * 0.3), r * 0.2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
