import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:asir_smart_experience/core/app_theme.dart';
import 'package:asir_smart_experience/core/locale_provider.dart';
import 'package:asir_smart_experience/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: AppColors.darkBlue,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const AsirSmartExperienceApp());
}

class AsirSmartExperienceApp extends StatelessWidget {
  const AsirSmartExperienceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: Consumer<LocaleProvider>(
        builder: (_, localeProv, __) {
          return MaterialApp(
            title: 'عسير - التجربة الذكية',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.theme,
            locale: localeProv.locale,
            supportedLocales: const [
              Locale('ar'),
              Locale('ar', 'SA'),
              Locale('en'),
            ],
            localeListResolutionCallback: (locales, supported) {
              if (locales == null || locales.isEmpty) {
                return localeProv.locale;
              }
              for (final device in locales) {
                for (final s in supported) {
                  if (s.languageCode == device.languageCode) {
                    return s;
                  }
                }
              }
              return localeProv.locale;
            },
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) {
              return Directionality(
                textDirection: localeProv.isArabic ? TextDirection.rtl : TextDirection.ltr,
                child: DefaultTextStyle.merge(
                  style: TextStyle(
                    fontFamily: AppTheme.arabicFontFamily,
                    fontFamilyFallback: AppTheme.arabicFontFallback,
                  ),
                  child: child ?? const SizedBox(),
                ),
              );
            },
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
