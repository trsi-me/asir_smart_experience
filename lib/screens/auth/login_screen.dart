import 'package:flutter/material.dart';
import 'package:asir_smart_experience/screens/auth/unified_auth_screen.dart';

/// نقطة دخول تسجيل الدخول — شاشة موحّدة (تبويب الدخول).
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const UnifiedAuthScreen(initialTab: 0);
  }
}
