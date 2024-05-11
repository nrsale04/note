

import 'dart:convert';

import 'package:mydailynote/adSystem/models/appeksOpenapp_model.dart';
import 'package:mydailynote/adSystem/models/appeks_native.dart';
import 'package:mydailynote/adSystem/models/banner_ad.dart';
import 'package:mydailynote/adSystem/models/interstitial_ad.dart';
import 'package:mydailynote/adSystem/models/interstitial_video_ad.dart';
import 'package:mydailynote/adSystem/models/native_ad.dart';
import 'package:mydailynote/adSystem/models/native_video_ad.dart';
import 'package:mydailynote/adSystem/models/open_app_model.dart';
import 'package:mydailynote/adSystem/models/reward_interstitial_ad.dart';
import 'package:mydailynote/adSystem/models/update_system.dart';

import 'adaptive_banner_ad.dart';
import 'reward_ad.dart';
AdDataModel adDataModelFromJson(String str) => AdDataModel.fromJson(json.decode(str));

String adDataModelToJson(AdDataModel data) => json.encode(data.toJson());

class AdDataModel {
    List<BannerList> bannerList;
    List<BannerAdaptivList> bannerAdaptivList;
    List<OpenAppList> openAppList;
    List<InterList> interList;
    List<InterVideoList> interVideoList;
    List<RewardList> rewardList;
    List<RewardInterList> rewardInterList;
    List<NativeList> nativeList;
    List<NativeVideoList> nativeVideoList;
    List<AppeksNativeList> appeksNativeList;
    List<AppeksInterListElement> appeksInterList;
    List<AppeksInterListElement> appeksOpenAppList;
    UpdateSystem updateSystem;
    List<AppeksInterListElement> customInterList;
    bool showAdmob;
    bool showAdAppeks;

    AdDataModel({
        required this.bannerList,
        required this.bannerAdaptivList,
        required this.openAppList,
        required this.interList,
        required this.interVideoList,
        required this.rewardList,
        required this.rewardInterList,
        required this.nativeList,
        required this.nativeVideoList,
        required this.appeksNativeList,
        required this.appeksInterList,
        required this.appeksOpenAppList,
        required this.updateSystem,
        required this.customInterList,
        required this.showAdmob,
        required this.showAdAppeks,
    });

    factory AdDataModel.fromJson(Map<String, dynamic> json) => AdDataModel(
        bannerList: List<BannerList>.from(json["bannerList"].map((x) => BannerList.fromJson(x))),
        bannerAdaptivList: List<BannerAdaptivList>.from(json["bannerAdaptivList"].map((x) => BannerAdaptivList.fromJson(x))),
        openAppList: List<OpenAppList>.from(json["openAppList"].map((x) => OpenAppList.fromJson(x))),
        interList: List<InterList>.from(json["interList"].map((x) => InterList.fromJson(x))),
        interVideoList: List<InterVideoList>.from(json["interVideoList"].map((x) => InterVideoList.fromJson(x))),
        rewardList: List<RewardList>.from(json["rewardList"].map((x) => RewardList.fromJson(x))),
        rewardInterList: List<RewardInterList>.from(json["rewardInterList"].map((x) => RewardInterList.fromJson(x))),
        nativeList: List<NativeList>.from(json["nativeList"].map((x) => NativeList.fromJson(x))),
        nativeVideoList: List<NativeVideoList>.from(json["nativeVideoList"].map((x) => NativeVideoList.fromJson(x))),
        appeksNativeList: List<AppeksNativeList>.from(json["appeksNativeList"].map((x) => AppeksNativeList.fromJson(x))),
        appeksInterList: List<AppeksInterListElement>.from(json["appeksInterList"].map((x) => AppeksInterListElement.fromJson(x))),
        appeksOpenAppList: List<AppeksInterListElement>.from(json["appeksOpenAppList"].map((x) => AppeksInterListElement.fromJson(x))),
        updateSystem: UpdateSystem.fromJson(json["updateSystem"]),
        customInterList: List<AppeksInterListElement>.from(json["customInterList"].map((x) => AppeksInterListElement.fromJson(x))),
        showAdmob: json["showAdmob"],
        showAdAppeks: json["showAdAppeks"],
    );

    Map<String, dynamic> toJson() => {
        "bannerList": List<dynamic>.from(bannerList.map((x) => x.toJson())),
        "bannerAdaptivList": List<dynamic>.from(bannerAdaptivList.map((x) => x.toJson())),
        "openAppList": List<dynamic>.from(openAppList.map((x) => x.toJson())),
        "interList": List<dynamic>.from(interList.map((x) => x.toJson())),
        "interVideoList": List<dynamic>.from(interVideoList.map((x) => x.toJson())),
        "rewardList": List<dynamic>.from(rewardList.map((x) => x.toJson())),
        "rewardInterList": List<dynamic>.from(rewardInterList.map((x) => x.toJson())),
        "nativeList": List<dynamic>.from(nativeList.map((x) => x.toJson())),
        "nativeVideoList": List<dynamic>.from(nativeVideoList.map((x) => x.toJson())),
        "appeksNativeList": List<dynamic>.from(appeksNativeList.map((x) => x.toJson())),
        "appeksInterList": List<dynamic>.from(appeksInterList.map((x) => x.toJson())),
        "appeksOpenAppList": List<dynamic>.from(appeksOpenAppList.map((x) => x.toJson())),
        "updateSystem": updateSystem.toJson(),
        "customInterList": List<dynamic>.from(customInterList.map((x) => x.toJson())),
        "showAdmob": showAdmob,
        "showAdAppeks": showAdAppeks,
    };
}