import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

extension LocalizationExtention on BuildContext {
  AppLocalizations get localization {
    return AppLocalizations.of(this)!;
  }
}