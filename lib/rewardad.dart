import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mydailynote/adSystem/uiAdAppeks/appeks_inter.dart';
import 'package:mydailynote/get/controller.dart';

class Reward extends StatefulWidget {
  const Reward({super.key});

  @override
  State<Reward> createState() => _RewardState();
}

class _RewardState extends State<Reward> {


  
  @override
  void initState() {
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

  void showRewardedAd() {
    if (controller.rewardedAd != null) {
      controller.rewardedAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        controller.createRewardAd();
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        controller.createRewardAd();
      });
      controller.rewardedAd!.show(onUserEarnedReward: (ad, reward) async {
        setState(() {
          controller.unlockAd.value = true;
        });
      });
      controller.rewardedAd = null;
    }
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [

          Text(
            'reward ad',
            style: TextStyle(fontSize: 25),
          ),
          IconButton(
              onPressed: () {
                if (controller.myAdDataModel != null) {
                  if (controller.myAdDataModel!.showAdmob &&
                      controller.myAdDataModel!.rewardList[0].showReward ==
                          true) {
                    showRewardedAd();
                  } else if (controller.myAdDataModel!.showAdAppeks == true &&
                      controller.appeksInter[0].showAppeksInter == true 
                  ) {
                    naveInterAppeks();
                    controller.interAdsCounter.value = 0;
                  } else if (controller.customInter[0].showCustomInter ==
                          true &&
                      controller.interAdsCounter.value >=
                          controller.customInter[0].customInterCounter!) {
                    naveCustomInter();
                    controller.interAdsCounter.value = 0;
                  }
                }
              },
              icon: Icon(Icons.circle_notifications)),
        ],
      ),
    ));
  }
}
