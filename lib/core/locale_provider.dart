import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:asir_smart_experience/l10n/app_localizations.dart';
import 'package:asir_smart_experience/data/localized_app_data.dart';

/// مزود اللغة - عربي / إنجليزي
class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('ar', 'SA');
  static const _key = 'app_locale';

  Locale get locale => _locale;
  AppLocalizations get l10n => AppLocalizations(_locale.languageCode);
  LocalizedAppData get localizedData => LocalizedAppData(isArabic);
  bool get isArabic => _locale.languageCode == 'ar';

  LocaleProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);
    if (code != null) {
      _locale = Locale(code, code == 'ar' ? 'SA' : null);
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale loc) async {
    _locale = loc;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, loc.languageCode);
    notifyListeners();
  }

  Future<void> toggle() async {
    final next = isArabic ? const Locale('en') : const Locale('ar', 'SA');
    await setLocale(next);
  }
}
