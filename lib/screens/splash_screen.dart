import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/core/app_transitions.dart';
import 'package:asir_smart_experience/widgets/asiri_cat_logo.dart';
import 'package:asir_smart_experience/services/auth_service.dart';
import 'package:asir_smart_experience/data/database_helper.dart';
import 'package:asir_smart_experience/screens/home_screen.dart';
import 'package:asir_smart_experience/screens/auth/login_screen.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// ألوان القط العسيري - مستوحاة من الفن التراثي السعودي (Al-Qatt Al-Asiri)
// ═══════════════════════════════════════════════════════════════════════════════
class _AlQattColors {
  static const Color red = Color(0xFFC62828);      // أحمر تراثي
  static const Color green = Color(0xFF2E7D32);    // أخضر تراثي
  static const Color gold = Color(0xFFF9A825);     // أصفر ذهبي
  static const Color black = Color(0xFF000000);    // أسود
  static const Color white = Color(0xFFFFFFFF);    // أبيض
}

// ═══════════════════════════════════════════════════════════════════════════════
// زخارف هندسية مستوحاة من القط العسيري - CustomPainter
// أشكال مثلثات ومربعات متكررة بسيطة وخفيفة في أعلى وأسفل الشاشة
// ═══════════════════════════════════════════════════════════════════════════════
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

// ═══════════════════════════════════════════════════════════════════════════════
// إطار دائري مزخرف مستوحى من القط العسيري - يحيط بالشعار
// ═══════════════════════════════════════════════════════════════════════════════
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

// ═══════════════════════════════════════════════════════════════════════════════
// شاشة البداية - انيمشن مستوحى من فن القط العسيري
// خلفية بيضاء + زخارف هندسية + شعار في إطار مزخرف + نصوص
// ═══════════════════════════════════════════════════════════════════════════════
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // أنيميشن الظهور الرئيسي (Fade + Scale)
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOutCubic),
    );
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOutBack),
    );

    // أنيميشن نبض خفيف للشعار
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat(reverse: true);

    _mainController.forward();
    _initAndNavigate();
  }

  Future<void> _initAndNavigate() async {
    await Future.wait([
      AuthService().init(),
      DatabaseHelper.instance.database,
    ]);
    await Future.delayed(const Duration(milliseconds: 2400));
    if (!mounted) return;
    HapticFeedback.lightImpact();
    final destination = AuthService().isLoggedIn ? const HomeScreen() : const LoginScreen();
    Navigator.pushReplacement(context, AppTransitions.fadeScale(destination));
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _AlQattColors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // ─── زخارف علوية (القط العسيري) ───
                      SizedBox(
                        height: 72,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: _AlQattDecorationPainter(isTop: true),
                        ),
                      ),

                      // ─── المحتوى الرئيسي ───
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: ScaleTransition(
                              scale: _scaleAnimation,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 16),

                                  // الشعار في إطار دائري مزخرف
                                  AnimatedBuilder(
                                    animation: _pulseController,
                                    builder: (context, child) {
                                      return Opacity(
                                        opacity: 0.92 + _pulseController.value * 0.08,
                                        child: child,
                                      );
                                    },
                                    child: _DecorativeCircleFrame(
                                      size: 130,
                                      child: Container(
                                        width: 130,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          color: _AlQattColors.gold.withValues(alpha: 0.06),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(20),
                                          child: AsiriCatLogo(
                                            size: 90,
                                            color: _AlQattColors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 32),

                                  // النص الرئيسي: عسير
                                  Builder(
                                    builder: (ctx) {
                                      final l10n = ctx.l10n;
                                      return Column(
                                        children: [
                                          Text(
                                            l10n.appName,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold,
                                              color: _AlQattColors.black,
                                              height: 1.3,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            l10n.appSubtitle,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: _AlQattColors.green,
                                              height: 1.4,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 48),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ─── زخارف سفلية ───
                      SizedBox(
                        height: 72,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: _AlQattDecorationPainter(isTop: false),
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
