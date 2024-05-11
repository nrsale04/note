import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mydailynote/get/controller.dart';


class AdMobService {
  static final BannerAdListener bannerListner = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('ad loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Ad Failed to lLoad: $error');
    },
    onAdOpened: (ad) => debugPrint('ad opened'),
    onAdClosed: (ad) => debugPrint('ad CLOSEd'),
  );
  static final NativeAdListener nativListner = NativeAdListener(
    onAdLoaded: (Ad ad) {
      controller.isFirstTimeShowNative = false;
      controller.nativeAd2 = ad as NativeAd?;

      log("Ad Loaded");
    },
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
    },
    onAdOpened: (ad) => debugPrint('ad native opened'),
    onAdClosed: (ad) => debugPrint('ad native CLOSEd'),
  );
  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/5224354917';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static List<String> bannerIdList = [];
  static List<String> interstitialIdList = [];
  static List<String> rewardIdList = [];
  static List<String> nativIdList = [];

  static String rewardID = "";
}
