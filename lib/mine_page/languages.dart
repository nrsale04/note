

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mydailynote/adSystem/uiAdAppeks/appeks_inter.dart';
import 'package:mydailynote/adSystem/uiAdAppeks/customInter.dart';
import 'package:mydailynote/get/controller.dart';
import 'package:mydailynote/get/getx_controller.dart';
import 'package:mydailynote/language/constant.dart';
import 'package:mydailynote/language/utils.dart';

import '../colors and styles/colors.dart';


class LanguagePage extends StatefulWidget {
  


  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final MyController _languageController = Get.find<MyController>();
  @override
  void initState() {
    controller.interAdsCounter.value++;
    super.initState();
  }

  updateLanguage(Locale locale) {
    if (_languageController.languageCharacter.value == LanguageCharacter.en) {
      _languageController.locale.value = const Locale('en', 'US');
      MiscUtil().setLocale(Environment.en);
      // onLanguageChangeClick(Environment.en);
    } else if (_languageController.languageCharacter.value ==
        LanguageCharacter.fa) {
      MiscUtil().setLocale(Environment.fa);
      _languageController.locale.value = const Locale('fa', 'IR');
      // onLanguageChangeClick(Environment.fa);
    } else if (_languageController.languageCharacter.value ==
        LanguageCharacter.sv) {
      MiscUtil().setLocale(Environment.sv);
      _languageController.locale.value = const Locale('sv', 'SV');
    } else if (_languageController.languageCharacter.value ==
        LanguageCharacter.sp) {
      MiscUtil().setLocale(Environment.sp);
      _languageController.locale.value = const Locale('sp', 'SP');
    } else if (_languageController.languageCharacter.value ==
        LanguageCharacter.fr) {
      MiscUtil().setLocale(Environment.fr);
      _languageController.locale.value = const Locale('fr', 'FR');
    } else if (_languageController.languageCharacter.value ==
        LanguageCharacter.gr) {
      MiscUtil().setLocale(Environment.gr);
      _languageController.locale.value = const Locale('gr', 'GR');
    }
    Get.updateLocale(_languageController.locale.value);

    // controller.box.write('Language', locale);
  }

  @override
  void dispose() {
    if (controller.myAdDataModel != null) {
      if (controller.myAdDataModel!.showAdmob == true &&
          controller.myAdDataModel!.interList[0].showInter == true) {
             controller.startShowingInternAds(0);

      } else if (controller.myAdDataModel!.showAdAppeks == true &&
          controller.appeksInter[0].showAppeksInter == true &&
          controller.interAdsCounter.value >=
              controller.appeksInter[0].interCounter!) {
                  InterAdAppeks();

        controller.interAdsCounter.value = 0;
      } else if (controller.customInter[0].showCustomInter == true &&
          controller.interAdsCounter.value >=
              controller.customInter[0].customInterCounter!) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CustomInter()));
        controller.interAdsCounter.value = 0;
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (controller.myAdDataModel != null) {
                        if (controller.myAdDataModel!.showAdmob == true &&
                            controller.myAdDataModel!.interList[0].showInter ==
                                true) {
                                  controller.startShowingInternAds(0);

                        } else if (controller.myAdDataModel!.showAdAppeks ==
                                true &&
                            controller.appeksInter[0].showAppeksInter == true &&
                            controller.interAdsCounter.value >=
                                controller.appeksInter[0].interCounter!) {
                                      InterAdAppeks();

                          controller.interAdsCounter.value = 0;
                        } else if (controller.customInter[0].showCustomInter ==
                                true &&
                            controller.interAdsCounter.value >=
                                controller.customInter[0].customInterCounter!) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CustomInter()));
                          controller.interAdsCounter.value = 0;
                          } else if (controller
                                      .customInter[0].showCustomInter ==
                                  true &&
                              controller.interAdsCounter.value >=
                                  controller
                                      .customInter[0].customInterCounter!) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CustomInter()));
                            controller.interAdsCounter.value = 0;
                          }
                        }
                      },
                      icon:Icon(Icons.backpack),
                    ),
                    Text(
                      'Languages'.tr,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Center(
                child: Container(
                  height: size.width * .8,
                  width: size.width * .85,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: black.withOpacity(.2),
                            // offset: Offset(.5, .7),
                            blurRadius: 5),
                      ]),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: controller.localee.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.localee[index]['name'],
                            ),
                            Obx(
                              () => Stack(
                                children: [
                                  Container(
                                    height: 19,
                                    width: 19,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: controller
                                                        .selectLanguage.value ==
                                                    index
                                                ? darkred
                                                : grey),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: EdgeInsets.all(2),
                                      child: SizedBox(
                                        child: CircleAvatar(
                                          backgroundColor:
                                              controller.selectLanguage.value ==
                                                      index
                                                  ? darkred
                                                  : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onTap: () async {
                          setState(() {
                            controller.selectLanguage.value = index;
                          });
                          _languageController.languageCharacter.value =
                              controller.localee[index]['code'];
                          await updateLanguage(
                              controller.localee[index]['locale']);

                          controller.box.write('selectLanguage',
                              controller.selectLanguage.value);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
