import 'package:flutter/material.dart';

/// ألوان داكنة متناسقة مع شعار ASIR SMART (أزرق كوني + لمسات سماوي/تركواز).
class AppColors {
  /// قاعدة تقريباً #00051A — عمق الشعار
  static const Color darkBlue = Color(0xFF000510);
  static const Color darkBlueMid = Color(0xFF000A18);
  /// سطح مرفوع للبطاقات والشريط
  static const Color darkBlueLight = Color(0xFF0C1624);
  static const Color surface = Color(0xFF081422);
  static const Color cardSurface = Color(0xFF101E2E);

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
  static const Color cardBg = Color(0xFF0A1520);

  /// خلفية شاشات مثل تسجيل الدخول: تدرج عمودي داكن جدًا (بدون بقعة فاتحة في الأعلى).
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF000E18),
      Color(0xFF000C15),
      Color(0xFF000A12),
      Color(0xFF000810),
      Color(0xFF00060D),
      Color(0xFF00050B),
      Color(0xFF000408),
      Color(0xFF000308),
    ],
    stops: [0.0, 0.15, 0.3, 0.45, 0.58, 0.72, 0.86, 1.0],
  );

  static const LinearGradient passportGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF003D4A),
      Color(0xFF002A35),
      Color(0xFF001820),
      Color(0xFF000A12),
    ],
    stops: [0.0, 0.38, 0.72, 1.0],
  );

  static const LinearGradient cardTeal = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF006B5C),
      Color(0xFF004D45),
      Color(0xFF021A18),
      Color(0xFF050A12),
    ],
    stops: [0.0, 0.35, 0.7, 1.0],
  );

  static const LinearGradient cardGreen = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF047857),
      Color(0xFF035C44),
      Color(0xFF021810),
      Color(0xFF050A12),
    ],
    stops: [0.0, 0.35, 0.7, 1.0],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF000E18),
      Color(0xFF000A14),
      Color(0xFF000810),
      Color(0xFF00060C),
      Color(0xFF000408),
      Color(0xFF000208),
    ],
    stops: [0.0, 0.2, 0.42, 0.58, 0.78, 1.0],
  );
}

class AppTheme {
  /// خط الواجهة العربي (يُعرّف في pubspec.yaml).
  static const String arabicFontFamily = 'IBMPlexSansArabic';

  /// بدائل عند تعذّر تحميل IBM (خصوصاً على الويب) حتى تظهر الحروف العربية في الحقول.
  static const List<String> arabicFontFallback = [
    'Segoe UI',
    'Tahoma',
    'Arial',
    'Roboto',
    'Noto Sans Arabic',
    'sans-serif',
  ];

  /// نمط نص يدعم العربية — للاستخدام في حقول أو عناوين تحتاج توحيداً صريحاً.
  static TextStyle arabicTextStyle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
  }) {
    return TextStyle(
      inherit: true,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      fontFamily: arabicFontFamily,
      fontFamilyFallback: arabicFontFallback,
    );
  }

  static ThemeData get theme {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
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
    // لا تضع fontFamily على ThemeData الجذر — يُورّث لـ Icon (مربعات X على الويب).
    final text = base.textTheme.apply(
      fontFamily: arabicFontFamily,
      fontFamilyFallback: arabicFontFallback,
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
    );
    final primaryText = base.primaryTextTheme.apply(
      fontFamily: arabicFontFamily,
      fontFamilyFallback: arabicFontFallback,
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
    );
    final inputBase = TextStyle(
      fontFamily: arabicFontFamily,
      fontFamilyFallback: arabicFontFallback,
    );
    return base.copyWith(
      textTheme: text,
      primaryTextTheme: primaryText,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: inputBase.copyWith(color: AppColors.white80),
        floatingLabelStyle: inputBase.copyWith(color: AppColors.tealBright),
        hintStyle: inputBase.copyWith(
          color: AppColors.white80.withValues(alpha: 0.72),
        ),
        errorStyle: inputBase.copyWith(color: AppColors.rose),
      ),
      dialogTheme: DialogThemeData(
        titleTextStyle: text.titleLarge,
        contentTextStyle: text.bodyMedium,
      ),
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: text.bodyMedium,
        behavior: SnackBarBehavior.floating,
      ),
      popupMenuTheme: PopupMenuThemeData(
        textStyle: text.bodyMedium,
      ),
      chipTheme: ChipThemeData(
        labelStyle: text.labelLarge,
        secondaryLabelStyle: text.labelMedium,
      ),
      tabBarTheme: TabBarThemeData(
        labelStyle: text.titleSmall,
        unselectedLabelStyle: text.titleSmall?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: text.titleMedium,
        subtitleTextStyle: text.bodyMedium,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: text.bodyLarge,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: text.labelSmall,
        unselectedLabelStyle: text.labelSmall,
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => text.labelMedium ?? const TextStyle(),
        ),
      ),
    );
  }
}
