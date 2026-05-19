import 'package:flutter/material.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/app_transitions.dart';
import 'package:asir_smart_experience/l10n/app_localizations_ext.dart';
import 'package:asir_smart_experience/screens/auth/login_screen.dart';
import 'package:asir_smart_experience/screens/auth/register_screen.dart';

/// سياسة الزائر والمستخدم المسجل حسب وثيقة المنصة.
Future<void> showPassportLoginRequiredDialog(BuildContext context) async {
  final l10n = context.l10n;
  await showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: AppColors.darkBlueLight,
      title: Text(
        l10n.passportLoginTitle,
        style: const TextStyle(color: AppColors.white),
      ),
      content: Text(
        l10n.passportLoginMessage,
        style: const TextStyle(color: AppColors.white80),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(
            l10n.cancel,
            style: const TextStyle(color: AppColors.teal),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
            Navigator.push(
              ctx,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
          child: Text(
            l10n.login,
            style: const TextStyle(color: AppColors.teal),
          ),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(ctx);
            Navigator.push(
              ctx,
              AppTransitions.fadeScale(const RegisterScreen()),
            );
          },
          child: Text(l10n.createAccount),
        ),
      ],
    ),
  );
}

Future<void> showProviderAccountRequiredDialog(BuildContext context) async {
  final l10n = context.l10n;
  await showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: AppColors.darkBlueLight,
      title: Text(
        l10n.providerAccountRequiredTitle,
        style: const TextStyle(color: AppColors.white),
      ),
      content: Text(
        l10n.providerAccountRequiredMessage,
        style: const TextStyle(color: AppColors.white80, height: 1.45),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(
            l10n.cancel,
            style: const TextStyle(color: AppColors.teal),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
            Navigator.push(
              ctx,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
          child: Text(
            l10n.login,
            style: const TextStyle(color: AppColors.teal),
          ),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(ctx);
            Navigator.push(
              ctx,
              AppTransitions.fadeScale(const RegisterScreen()),
            );
          },
          child: Text(l10n.createAccount),
        ),
      ],
    ),
  );
}

Future<void> showRegisteredFeatureDialog(
  BuildContext context,
  String message,
) async {
  final l10n = context.l10n;
  await showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: AppColors.darkBlueLight,
      content: Text(message, style: const TextStyle(color: AppColors.white80, height: 1.45)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(l10n.cancel, style: const TextStyle(color: AppColors.teal)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
            Navigator.push(
              ctx,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
          child: Text(l10n.login, style: const TextStyle(color: AppColors.teal)),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(ctx);
            Navigator.push(
              ctx,
              AppTransitions.fadeScale(const RegisterScreen()),
            );
          },
          child: Text(l10n.createAccount),
        ),
      ],
    ),
  );
}
