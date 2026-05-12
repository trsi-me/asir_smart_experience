import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/app_transitions.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/services/auth_service.dart';
import 'package:asir_smart_experience/screens/auth/unified_auth_screen.dart';
import 'package:asir_smart_experience/screens/home_screen.dart';

/// نقطة الدخول: ثلاثة خيارات واضحة (وثيقة المنصة — الدخول كزائر / تسجيل الدخول / إنشاء حساب).
class WelcomeEntryScreen extends StatelessWidget {
  const WelcomeEntryScreen({super.key});

  Future<void> _continueGuest(BuildContext context) async {
    HapticFeedback.lightImpact();
    await AuthService().logout();
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      AppTransitions.fadeScale(const HomeScreen()),
    );
  }

  void _openAuth(BuildContext context, int tab) {
    HapticFeedback.lightImpact();
    Navigator.pushReplacement(
      context,
      AppTransitions.fadeScale(UnifiedAuthScreen(initialTab: tab)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: const Color(0xFF000408),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.heroGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      width: 80,
                      height: 80,
                      color: AppColors.darkBlueMid,
                      padding: const EdgeInsets.all(6),
                      child: Image.asset(
                        'assets/images/Logo.jpg',
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.landscape_outlined,
                          size: 40,
                          color: AppColors.tealBright,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.appName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.appSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.teal.withValues(alpha: 0.95),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.authEntrySubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: AppColors.white.withValues(alpha: 0.92),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.welcomeEntryChoicesHint,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.45,
                    color: AppColors.white80.withValues(alpha: 0.88),
                  ),
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () => _continueGuest(context),
                  icon: const Icon(Icons.travel_explore, size: 22, color: AppColors.tealBright),
                  label: Text(
                    l10n.continueAsGuest,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    side: BorderSide(
                      color: AppColors.tealBright.withValues(alpha: 0.95),
                      width: 1.5,
                    ),
                    backgroundColor: AppColors.darkBlue.withValues(alpha: 0.35),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () => _openAuth(context, 0),
                  icon: const Icon(Icons.login, size: 22),
                  label: Text(
                    l10n.login,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.teal,
                    foregroundColor: AppColors.darkBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => _openAuth(context, 1),
                  icon: const Icon(Icons.person_add_alt_1, size: 22),
                  label: Text(
                    l10n.createAccount,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    side: BorderSide(
                      color: AppColors.white.withValues(alpha: 0.35),
                      width: 1.2,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
