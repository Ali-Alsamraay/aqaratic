import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io' show Platform;

import 'ar-AE.dart';
import 'en-US.dart';

class LocalizationService extends Translations {
  static final local = Locale('en', 'US');
  static final fallBackLocale = Locale('en', 'US');

  static final langs = ['English', 'Arabic'];
  static final locales = [
    Locale('en', 'US'),
    Locale('ar', 'AE'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS,
    'ar_AE': arAE,
  };

  void changeLocale(String lang) {
    final locale = getLocale(lang);
    final box = GetStorage();
    box.write('lng', lang);
    Get.updateLocale(locale!);
  }

  Locale? getLocale(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }

    return Get.locale;
  }

  Locale getCurrentLocale() {
    String languageCode = Platform.localeName.split('_')[0];
    String countryCode = Platform.localeName.split('_')[1];

    final box = GetStorage();
    Locale defaultLocale;

    if (box.read('lng') != null) {
      final locale = getLocale(box.read('lng'));

      defaultLocale = locale!;
    } else {
      defaultLocale = Locale(languageCode, countryCode);
    }

    return defaultLocale;
  }

  String getCurrentLang() {
    final box = GetStorage();

    return box.read('lng') != null ? box.read('lng') : 'English';
  }
}
