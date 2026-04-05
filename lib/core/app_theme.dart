import 'package:flutter/material.dart';

/// ألوان واضحة ومميزة - عسير الذكية
class AppColors {
  // الأساسية - أزرق داكن من الشعار
  static const Color darkBlue = Color(0xFF0A192F);
  static const Color darkBlueLight = Color(0xFF112240);
  static const Color surface = Color(0xFF0F2847);
  /// لون الكاردات - أوضح من الخلفية
  static const Color cardSurface = Color(0xFF152A45);

  // الألوان المميزة - واضحة وجريئة
  static const Color teal = Color(0xFF00D4AA);
  static const Color tealBright = Color(0xFF00E5FF);
  static const Color cyan = Color(0xFF00B4D8);
  static const Color green = Color(0xFF2DD4BF);
  static const Color greenVivid = Color(0xFF10B981);
  static const Color amber = Color(0xFFF59E0B);
  static const Color orange = Color(0xFFF97316);
  static const Color rose = Color(0xFFF43F5E);
  static const Color violet = Color(0xFF8B5CF6);

  static const Color white = Color(0xFFFFFFFF);
  static const Color white80 = Color(0xFFCCD6F6);
  static const Color cardBg = Color(0xFF0F2847);

  /// تدرجات جريئة
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00D4AA), Color(0xFF00B4D8), Color(0xFF0A192F)],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient passportGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF00D4AA), Color(0xFF10B981)],
  );

  static const LinearGradient cardTeal = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00D4AA), Color(0xFF0D2137)],
    stops: [0.0, 0.7],
  );

  static const LinearGradient cardGreen = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF10B981), Color(0xFF0D2137)],
    stops: [0.0, 0.7],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFF0A192F), Color(0xFF0D2137), Color(0xFF0A192F)],
  );
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'IBMPlexSansArabic',
      scaffoldBackgroundColor: AppColors.darkBlue,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.teal,
        secondary: AppColors.greenVivid,
        surface: AppColors.darkBlue,
        error: AppColors.rose,
        onPrimary: AppColors.darkBlue,
        onSecondary: AppColors.white,
        onSurface: AppColors.white,
        onError: AppColors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
