import 'package:flutter/material.dart';
import 'package:asir_smart_experience/core/app_theme.dart';

/// شعار القط العسيري - للشاشة الأولى
class AsiriCatLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const AsiriCatLogo({super.key, this.size = 120, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _AsiriCatLogoPainter(color: color ?? AppColors.teal),
      ),
    );
  }
}

class _AsiriCatLogoPainter extends CustomPainter {
  final Color color;

  _AsiriCatLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width * 0.4;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final stroke = Paint()
      ..color = color.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // رأس القط - مثلث عسيري
    final path = Path();
    path.moveTo(c.dx, c.dy - r);
    path.lineTo(c.dx - r * 0.9, c.dy + r * 0.5);
    path.lineTo(c.dx + r * 0.9, c.dy + r * 0.5);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);

    // عيون - نمط القط العسيري
    canvas.drawCircle(c + Offset(-r * 0.35, -r * 0.15), r * 0.12, stroke);
    canvas.drawCircle(c + Offset(r * 0.35, -r * 0.15), r * 0.12, stroke);
    canvas.drawCircle(c + Offset(-r * 0.35, -r * 0.15), r * 0.05, paint);
    canvas.drawCircle(c + Offset(r * 0.35, -r * 0.15), r * 0.05, paint);

    // أنف
    canvas.drawCircle(c + Offset(0, r * 0.05), r * 0.06, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
