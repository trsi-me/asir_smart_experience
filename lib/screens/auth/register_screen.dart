import 'package:flutter/material.dart';
import 'package:asir_smart_experience/screens/auth/unified_auth_screen.dart';

/// فتح إنشاء الحساب — نفس الشاشة الموحّدة على تبويب التسجيل.
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const UnifiedAuthScreen(initialTab: 1);
  }
}
