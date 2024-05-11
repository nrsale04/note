import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mydailynote/get/controller.dart';

bool canShowOpenAd = true;

class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  static bool isLoaded = false;
  DateTime? _appOpenLoadTime;
  final Duration maxCacheDuration = const Duration(hours: 4);

  /// Load an AppOpenAd.
  void loadAd() {
    if (controller.myAdDataModel != null &&
        controller.myAdDataModel!.showAdmob == true) {
      if (controller.myAdDataModel!.openAppList[0].showOpenApp == true) {
        AppOpenAd.load(
          adUnitId: controller.myAdDataModel!.openAppList[0].admobOpenAppId,
          // orientation: AppOpenAd.orientationPortrait,
          request: const AdRequest(),
          adLoadCallback: AppOpenAdLoadCallback(
            onAdLoaded: (ad) {
              _appOpenAd = ad;
              isLoaded = true;

              _appOpenLoadTime = DateTime.now();
              _appOpenAd = ad;

              // here is where I show the Ad as soon as it's loaded
              showAdIfAvailable();
              print('Im here');
            },
            onAdFailedToLoad: (error) {
              // Handle the error.
            },
          ),
        );
      }
    }
  }

  // Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  void showAdIfAvailable() {
    if (!canShowOpenAd) return;

    if (!isAdAvailable) {
      loadAd();
      return;
    }
    if (_appOpenAd == null) {
      loadAd();
      return;
    }
    if (_isShowingAd) {
      canShowOpenAd = false;

      return;
    }
    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    canShowOpenAd = false;
    _appOpenAd!.show();
  }
}
