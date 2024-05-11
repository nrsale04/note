import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mydailynote/language/fr_FR.dart';
import 'package:mydailynote/language/gr_GR.dart';
import 'package:mydailynote/language/sp_SP.dart';


import 'en_US.dart';
import 'fa_IR.dart';
import 'sv_SV.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('en', 'EN');
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'fa_IR': fa_IR,
        'sv_SV': sv_SV,
        'fr_FR': fr_FR,
        'gr_GR': gr_GR,
        'sp_SP': sp_SP,
      };
}
