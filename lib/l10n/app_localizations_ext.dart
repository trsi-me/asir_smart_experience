import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:asir_smart_experience/core/locale_provider.dart';
import 'package:asir_smart_experience/l10n/app_localizations.dart';
import 'package:asir_smart_experience/l10n/data_translations.dart';
import 'package:asir_smart_experience/data/localized_app_data.dart';

/// امتداد للوصول السريع للترجمة
extension AppLocalizationsExt on BuildContext {
  LocaleProvider get localeProvider => read<LocaleProvider>();
  AppLocalizations get l10n => localeProvider.l10n;
  LocalizedAppData get localizedData => localeProvider.localizedData;
  DataTranslations get dataT => DataTranslations(localeProvider.isArabic);
  bool get isArabic => localeProvider.isArabic;
}
