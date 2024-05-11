import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mydailynote/adSystem/ad_helper.dart';
import 'package:mydailynote/adSystem/models/appeksOpenapp_model.dart';
import 'package:mydailynote/adSystem/models/data_model.dart';

enum LanguageCharacter { en, fa, sv, fr, gr, sp }

class MyController extends GetxController {
  final box = GetStorage();
  bool checkConnect = false;
  Future<void> checkConection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        checkConnect = true;
      }
    } on SocketException catch (_) {
      checkConnect = false;
    }
  }

// speech to text
  RxString textSpeech = "".obs;
  InAppWebViewController? controllerWebView;
//reminder
  RxBool isSelected = true.obs;
  RxBool isNotificationActive = false.obs;
  RxBool repeat = false.obs;
  RxInt hour = 9.obs;
  RxInt minute = 0.obs;
  //=>AD
  AdDataModel? myAdDataModel;
  RxBool nativeIsNotLoaded = false.obs;
  bool bannerIsNotLoaded = false;
  RxInt interAdsCounter = 0.obs;
  InterstitialAd? interstitialAd;
  DateTime countDownTimerShowAdNative = DateTime.now();
  List<DateTime> countDownTimerShowAdInter = [DateTime.now()];
  List<DateTime> countDownTimerShowAdReward = [DateTime.now()];
  List<DateTime> countDownTimerShowAdBanner = [DateTime.now(), DateTime.now()];
  DateTime countDownTimerShowAdBannerCalender = DateTime.now();
  bool isFirstTimeShowNative = true;
  List<bool> isFirstTimeShowInter = [true];
  List<bool> isFirstTimeShowReward = [true];
  List<bool> isFirstTimeShowBanner = [true, true];
  NativeAd? nativeAd;
  NativeAd? nativeAd2;
  BannerAd? bannerCalender;
  BannerAd? bannerBlog;
  RxBool banner1AdIsLoaded = false.obs;
  RxBool banner2AdIsLoaded = false.obs;
  RxList<String> nameEx = <String>[].obs;
  RxList<String> allLink = <String>[].obs;
  RewardedAd? rewardedAd;
  final appeksOpenApp = <AppeksInterListElement>[];
  final appeksInter = <AppeksInterListElement>[];
  final customInter = <AppeksInterListElement>[];
  RxBool unlockAd = false.obs;

  //=>AD

//=>Language
  Rx<LanguageCharacter> languageCharacter = LanguageCharacter.en.obs;
  var locale = const Locale('en', 'EN').obs;
  RxInt selectLanguage = 0.obs;

  final List localee = [
    {
      'name': 'English',
      'code': LanguageCharacter.en,
      'locale': const Locale('en', 'EN'),
    },
    {
      'name': 'Svenska',
      'code': LanguageCharacter.sv,
      'locale': const Locale('sv', 'SV')
    },
    {
      'name': 'Français',
      'code': LanguageCharacter.fr,
      'locale': const Locale('fr', 'FR')
    },
    {
      'name': 'Deutsch',
      'code': LanguageCharacter.gr,
      'locale': const Locale('gr', 'GR')
    },
    {
      'name': 'Español',
      'code': LanguageCharacter.sp,
      'locale': const Locale('sp', 'SP')
    },
    {
      'name': 'فارسی',
      'code': LanguageCharacter.fa,
      'locale': const Locale('fa', 'IR')
    },
  ];
//=>Language

  @override
  void onInit() {
    fetchModels();
    super.onInit();
  }

  Future<AdDataModel?> fetchModels() async {
    AdDataModel? dataModel;
    checkConection();
    if (checkConnect) {
      String baseUrl = "https://apps.appeks.com/toolsProject/test.json";
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        var data1 = const Utf8Decoder().convert(response.bodyBytes);
        dataModel = AdDataModel.fromJson(jsonDecode(data1));
        myAdDataModel = dataModel;
        for (int i = 0; i < dataModel.bannerList.length; i++) {
          AdMobService.bannerIdList.add(dataModel.bannerList[i].admobBannerId);
        }
        for (int i = 0; i < dataModel.interList.length; i++) {
          AdMobService.interstitialIdList
              .add(dataModel.interList[i].admobInterId);
        }
        for (int i = 0; i < dataModel.rewardList.length; i++) {
          AdMobService.rewardIdList.add(dataModel.rewardList[i].admobRewardId);
        }

        for (int i = 0; i < dataModel.appeksInterList.length; i++) {
          appeksInter.add(dataModel.appeksInterList[i]);
        }
        for (int i = 0; i < dataModel.appeksOpenAppList.length; i++) {
          appeksOpenApp.add(dataModel.appeksOpenAppList[i]);
        }
        for (int i = 0; i < dataModel.customInterList.length; i++) {
          customInter.add(dataModel.customInterList[i]);
        }
        for (int i = 0; i < dataModel.nativeList.length; i++) {
          AdMobService.nativIdList.add(dataModel.nativeList[i].admobNativeId);
        }
        return dataModel;
      } else {
        throw Exception('Failed the Load Post');
      }
    }
    return null;
  }

  void checkToCreateBannerAds(int a) async {
    if (myAdDataModel != null) {
      if (Platform.isAndroid) {
        if (myAdDataModel!.showAdmob) {
          if (myAdDataModel!.bannerList[a].showBanner) {
            print('hanaa');

            DateTime currentTime = DateTime.now();
            DateTime timeAdIsShown = countDownTimerShowAdBanner[a];

            DateTime adWhouldBeShown =
                timeAdIsShown.add(const Duration(seconds: 60));

            if (isFirstTimeShowBanner[a]) {
              _createBannerAd(a);

              countDownTimerShowAdBanner[a] = DateTime.now();
              isFirstTimeShowBanner[a] = false;
            } else if (currentTime.isAfter(adWhouldBeShown)) {
              _createBannerAd(a);
              print('hanaaaaa');

              countDownTimerShowAdBanner[a] = DateTime.now();
            }
          }
        }
      } else if (Platform.isIOS) {}
    }
  }

  var b = 0;
  void _createBannerAd(int a) async {
    await checkConection();
    b++;
    bannerCalender = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.bannerIdList[a],
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          banner1AdIsLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          banner1AdIsLoaded.value = false;

          if (b < 2) {
            if (checkConnect) {
              _createBannerAd(a);
              print('hana');
            }
          }
          ad.dispose();
          debugPrint('Ad Failed to Load: $error');
        },
        onAdOpened: (ad) => debugPrint('ad opened'),
        onAdClosed: (ad) => debugPrint('ad CLOSEd'),
      ),
      request: const AdRequest(),
    )..load();
  }

  void checkToCreateNativeAds(int a) async {
    if (myAdDataModel != null) {
      if (Platform.isAndroid) {
        if (myAdDataModel!.showAdmob) {
          if (myAdDataModel!.nativeList[a].showNative) {
            DateTime currentTime = DateTime.now();
            DateTime timeAdIsShown = countDownTimerShowAdBanner[a];

            DateTime adWhouldBeShown =
                timeAdIsShown.add(const Duration(seconds: 60));

            if (isFirstTimeShowBanner[a]) {
              _createBannerAd(a);

              countDownTimerShowAdBanner[a] = DateTime.now();
              isFirstTimeShowBanner[a] = false;
            } else if (currentTime.isAfter(adWhouldBeShown)) {
              print('hanaaaa');

              _createBannerAd(a);

              countDownTimerShowAdBanner[a] = DateTime.now();
            }
          }
        }
      } else if (Platform.isIOS) {}
    }
  }

  void createNativeAd(int a) async {
    await checkConection();
    b++;
    nativeAd = NativeAd(
      adUnitId: AdMobService.nativIdList[a],
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          nativeIsNotLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          nativeIsNotLoaded.value = false;

          if (b < 2) {
            if (checkConnect) {
              createNativeAd(a);
              print('jaja');
            }
          }
          ad.dispose();
          debugPrint('Ad Failed to Load: $error');
        },
        onAdOpened: (ad) => debugPrint('ad opened'),
        onAdClosed: (ad) => debugPrint('ad CLOSEd'),
      ),
      request: const AdRequest(),
      nativeTemplateStyle:
          NativeTemplateStyle(templateType: TemplateType.small),
    )..load();
    countDownTimerShowAdNative = DateTime.now();
    isFirstTimeShowNative = false;
  }

  void startShowingInternAds(int a) async {
    DateTime currentTime = DateTime.now();
    DateTime adIsShown = DateTime.now();

    DateTime adWhouldBeShown = DateTime.now();

    if (Platform.isAndroid) {
      adIsShown = countDownTimerShowAdInter[a];
      adWhouldBeShown = adIsShown
          .add(Duration(minutes: myAdDataModel!.interList[a].interTime));
    } else if (Platform.isIOS) {
      adIsShown = countDownTimerShowAdInter[a];
      adWhouldBeShown = adIsShown
          .add(Duration(minutes: myAdDataModel!.interList[a].interTime));
    }

    if (myAdDataModel != null) {
      if (Platform.isAndroid) {
        if (myAdDataModel!.showAdmob) {
          if (myAdDataModel!.interList[a].showInter) {
            if (isFirstTimeShowInter[a]) {
              await _createInterstitialAd(a);
              _showInterstitialAd(a);
            } else if (currentTime.isAfter(adWhouldBeShown) &&
                interAdsCounter >= myAdDataModel!.interList[a].counterInter) {
              await _createInterstitialAd(a);
              _showInterstitialAd(a);
              interAdsCounter.value = 0;

              print('eeeeeeeeeeeeee${interAdsCounter.value}');
              countDownTimerShowAdInter[a] = DateTime.now();
            }
          }
        }
      } else if (Platform.isIOS) {}
    }
  }

  Future<bool> _createInterstitialAd(int a) async {
    InterstitialAd.load(
        adUnitId: AdMobService.interstitialIdList[a],
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            interstitialAd = null;
            interAdsCounter.value =
                myAdDataModel!.interList[a].counterInter + 1;
            countDownTimerShowAdInter[a] = countDownTimerShowAdInter[a]
                .subtract(const Duration(minutes: 2));
          },
        ));
    return false;
  }

  void _showInterstitialAd(int a) {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createInterstitialAd(a);
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createInterstitialAd(a);
        },
        onAdWillDismissFullScreenContent: (ad) {
          interAdsCounter.value = 0;
          isFirstTimeShowInter[a] = false;

          countDownTimerShowAdInter[a] = DateTime.now();
        },
        onAdClicked: (ad) {
          interAdsCounter.value = 0;
          isFirstTimeShowInter[a] = false;

          countDownTimerShowAdInter[a] = DateTime.now();
        },
        onAdShowedFullScreenContent: (ad) {
          interAdsCounter.value = 0;
          isFirstTimeShowInter[a] = false;

          countDownTimerShowAdInter[a] = DateTime.now();
        },
      );
      interstitialAd!.show();
      interstitialAd = null;
    }
  }

  void startShowingRewardAds(int a) async {
    DateTime currentTime = DateTime.now();
    DateTime adIsShown = DateTime.now();

    DateTime adWhouldBeShown = DateTime.now();

    if (Platform.isAndroid) {
      adIsShown = countDownTimerShowAdReward[a];
      adWhouldBeShown = adIsShown
          .add(Duration(minutes: myAdDataModel!.rewardList[a].rewardTime));
    } else if (Platform.isIOS) {
      adIsShown = countDownTimerShowAdReward[a];
      adWhouldBeShown = adIsShown
          .add(Duration(minutes: myAdDataModel!.rewardList[a].rewardTime));
    }

    if (myAdDataModel != null) {
      if (Platform.isAndroid) {
        if (myAdDataModel!.showAdmob) {
          if (myAdDataModel!.rewardList[a].showReward) {
            if (isFirstTimeShowReward[a]) {
              // createRewardAd(a);
              // showRewardedAd(a);
            } else if (currentTime.isAfter(adWhouldBeShown) &&
                interAdsCounter > myAdDataModel!.rewardList[a].counterReward) {
              // createRewardAd(a);
              // showRewardedAd(a);

              interAdsCounter.value = 0;
              countDownTimerShowAdInter[a] = DateTime.now();
            }
          }
        } else if (myAdDataModel!.showAdAppeks == true &&
            appeksInter[0].showAppeksInter == true) {
          // InterAdAppeks(context);
        }
      } else if (Platform.isIOS) {}
    }
  }

  void createRewardAd() {
    RewardedAd.load(
      adUnitId: AdMobService.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) => rewardedAd = ad,
          onAdFailedToLoad: (LoadAdError error) => rewardedAd = null),
    );
  }
}
