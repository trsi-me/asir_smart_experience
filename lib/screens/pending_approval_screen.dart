import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ألوان القط العسيري - مستوحاة من الفن التراثي السعودي
class _AlQattColors {
  static const Color red = Color(0xFFC62828);      // أحمر تراثي
  static const Color green = Color(0xFF2E7D32);    // أخضر تراثي
  static const Color gold = Color(0xFFF9A825);     // أصفر ذهبي
  static const Color black = Color(0xFF000000);    // أسود
  static const Color white = Color(0xFFFFFFFF);    // أبيض
}

/// زخارف هندسية مستوحاة من القط العسيري - CustomPainter
/// أشكال مثلثات ومربعات متكررة بسيطة وخفيفة
class _AlQattDecorationPainter extends CustomPainter {
  final bool isTop;

  _AlQattDecorationPainter({required this.isTop});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    const opacity = 0.12;
    final colors = [
      _AlQattColors.red.withValues(alpha: opacity),
      _AlQattColors.green.withValues(alpha: opacity),
      _AlQattColors.gold.withValues(alpha: opacity),
    ];

    const spacing = 24.0;
    final cols = (size.width / spacing).ceil() + 1;
    final rows = (size.height / spacing).ceil() + 1;

    for (var row = 0; row < rows; row++) {
      for (var col = 0; col < cols; col++) {
        final x = col * spacing + (row.isOdd ? spacing / 2 : 0);
        final y = row * spacing * 0.86;
        final colorIndex = (row + col) % 3;
        paint.color = colors[colorIndex];

        // رسم مثلث صغير - شكل أساسي في القط العسيري
        _drawSmallTriangle(canvas, Offset(x, y), 8, paint);
      }
    }
  }

  void _drawSmallTriangle(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path()
      ..moveTo(center.dx, center.dy - size)
      ..lineTo(center.dx + size, center.dy + size * 0.6)
      ..lineTo(center.dx - size, center.dy + size * 0.6)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// إطار دائري مزخرف مستوحى من القط العسيري
class _DecorativeCircleFrame extends StatelessWidget {
  final Widget child;
  final double size;

  const _DecorativeCircleFrame({required this.child, this.size = 140});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size + 24, size + 24),
      painter: _CircleFramePainter(),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: child,
      ),
    );
  }
}

class _CircleFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // الدائرة الخارجية - تدرج ألوان القط العسيري (أحمر، ذهبي، أخضر)
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      colors: [
        _AlQattColors.red,
        _AlQattColors.gold,
        _AlQattColors.green,
        _AlQattColors.red,
      ],
    );
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..shader = gradient.createShader(rect),
    );

    // زخارف صغيرة على المحيط - نقاط مستوحاة من القط العسيري
    const dotCount = 24;
    for (var i = 0; i < dotCount; i++) {
      final angle = (i / dotCount) * 2 * math.pi - math.pi / 2;
      final dotRadius = radius - 2;
      final dotCenter = Offset(
        center.dx + dotRadius * math.cos(angle),
        center.dy + dotRadius * math.sin(angle),
      );
      final dotColor = i % 3 == 0
          ? _AlQattColors.red
          : i % 3 == 1
              ? _AlQattColors.gold
              : _AlQattColors.green;
      canvas.drawCircle(dotCenter, 3, Paint()..color = dotColor.withValues(alpha: 0.7));
    }

    // دائرة داخلية خفيفة
    canvas.drawCircle(
      center,
      radius - 8,
      Paint()
        ..color = _AlQattColors.gold.withValues(alpha: 0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// صفحة قيد الانتظار - مستوحاة من فن القط العسيري
/// تصميم حديث مع الحفاظ على الطابع التراثي
class PendingApprovalScreen extends StatefulWidget {
  /// دالة تُستدعى عند الضغط على "تحديث الحالة"
  final VoidCallback? onRefreshStatus;

  const PendingApprovalScreen({super.key, this.onRefreshStatus});

  @override
  State<PendingApprovalScreen> createState() => _PendingApprovalScreenState();
}

class _PendingApprovalScreenState extends State<PendingApprovalScreen>
    with SingleTickerProviderStateMixin {
  bool _isRefreshing = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;
    setState(() => _isRefreshing = true);
    HapticFeedback.lightImpact();
    widget.onRefreshStatus?.call();
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => _isRefreshing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _AlQattColors.white,
      appBar: AppBar(
        backgroundColor: _AlQattColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: _AlQattColors.black),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // ─── زخارف علوية ───
                      SizedBox(
                        height: 80,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: _AlQattDecorationPainter(isTop: true),
                        ),
                      ),

                      // ─── المحتوى الرئيسي ───
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 24),

                              // الأيقونة مع الإطار المزخرف
                              _DecorativeCircleFrame(
                                size: 120,
                                child: AnimatedBuilder(
                                  animation: _pulseController,
                                  builder: (context, child) {
                                    return Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: _AlQattColors.gold.withValues(
                                          alpha: 0.08 + _pulseController.value * 0.04,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        _isRefreshing
                                            ? Icons.hourglass_empty
                                            : Icons.schedule,
                                        size: 56,
                                        color: _AlQattColors.red,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: 40),

                              // النص الرئيسي
                              Text(
                                'طلبك قيد المراجعة',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: _AlQattColors.black,
                                  height: 1.4,
                                  letterSpacing: 0.5,
                                ),
                              ),

                              const SizedBox(height: 20),

                              // النص التوضيحي
                              Text(
                                'يتم الآن مراجعة طلبك من قبل الإدارة.\nسيتم إشعارك فور الموافقة.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: _AlQattColors.black.withValues(alpha: 0.7),
                                  height: 1.7,
                                ),
                              ),

                              const SizedBox(height: 48),
                            ],
                          ),
                        ),
                      ),

                      // ─── زخارف سفلية ───
                      SizedBox(
                        height: 80,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: _AlQattDecorationPainter(isTop: false),
                        ),
                      ),

                      // ─── زر تحديث الحالة ───
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                        child: SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _isRefreshing ? null : _handleRefresh,
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _AlQattColors.red,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _AlQattColors.red.withValues(alpha: 0.35),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: _isRefreshing
                                      ? SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              _AlQattColors.white,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          'تحديث الحالة',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: _AlQattColors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
