import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mydailynote/adSystem/uiAdAppeks/appeks_banner_ad.dart';
import 'package:mydailynote/adSystem/uiAdAppeks/appeks_inter.dart';
import 'package:mydailynote/get/controller.dart';


class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  void initState() {
    controller.checkToCreateBannerAds(0);
    controller.interAdsCounter.value++;
    if (controller.myAdDataModel != null) {
      if (controller.myAdDataModel!.showAdmob == true &&
          controller.myAdDataModel!.interList[0].showInter == true) {
        controller.startShowingInternAds(0);
      } else if (controller.myAdDataModel!.showAdAppeks == true &&
          controller.appeksInter[0].showAppeksInter == true &&
          controller.interAdsCounter.value >=
              controller.appeksInter[0].interCounter!) {
        naveInterAppeks();
        controller.interAdsCounter.value = 0;
      } else if (controller.customInter[0].showCustomInter == true &&
          controller.interAdsCounter.value >=
              controller.customInter[0].customInterCounter!) {
        naveCustomInter();
        controller.interAdsCounter.value = 0;
      }
    }
    super.initState();
  }

  Future<void> naveInterAppeks() async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const InterAdAppeks()));
    });
  }

  Future<void> naveCustomInter() async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const InterAdAppeks()));
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'banner ad',
            style: TextStyle(fontSize: 25),
          ),
          Container(
            child: controller.checkConnect
                ? SizedBox(
                    height: MediaQuery.sizeOf(context).width * .2,
                    width: MediaQuery.of(context).size.width,
                    child: controller.myAdDataModel != null
                        ? controller.myAdDataModel!.showAdmob
                            ? controller.myAdDataModel!.bannerList[0].showBanner
                                ? controller.bannerCalender != null &&
                                        controller.banner1AdIsLoaded.value
                                    ? Container(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        margin: const EdgeInsets.only(top: 5),
                                        height: 100,
                                        child: AdWidget(
                                            ad: controller.bannerCalender!),
                                      )
                                    : const SizedBox()
                                : const SizedBox()
                            : controller.myAdDataModel!.showAdAppeks
                                ? controller
                                        .myAdDataModel!
                                        .appeksNativeList[0]
                                        // ignore: unrelated_type_equality_checks
                                        .showAppeksNative
                                    ? const BannerAppeks()
                                    : const SizedBox()
                                : const SizedBox()
                        : const SizedBox())
                : const SizedBox(),
          ),
          Container(
            height: 50,
            color: Colors.amber,
            child: controller.checkConnect == false
                ? SizedBox(
                    height: MediaQuery.sizeOf(context).width * .2,
                    width: MediaQuery.of(context).size.width,
                    child: controller.myAdDataModel != null
                        ? controller.myAdDataModel!.showAdmob
                            ? controller.myAdDataModel!.nativeList[0].showNative
                                ? controller.nativeAd != null &&
                                        controller.nativeIsNotLoaded.value
                                    ? Container(
                                        color: Colors.black,
                                        margin: const EdgeInsets.only(top: 5),
                                        height: 100,
                                        child:
                                            AdWidget(ad: controller.nativeAd!),
                                      )
                                    : const SizedBox()
                                : const SizedBox()
                            : controller.myAdDataModel!.showAdAppeks
                                ? controller.myAdDataModel!.appeksNativeList[0]
                                        .showAppeksNative
                                    ? const BannerAppeks()
                                    : const SizedBox()
                                : const SizedBox()
                        : const SizedBox())
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
