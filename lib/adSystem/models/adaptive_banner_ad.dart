
class BannerAdaptivList {
    bool showAdaptiveBanner;
    String admobAdaptiveBannerId;
    int counterAdaptiveBanner;
    int adaptiveBannerTime;

    BannerAdaptivList({
        required this.showAdaptiveBanner,
        required this.admobAdaptiveBannerId,
        required this.counterAdaptiveBanner,
        required this.adaptiveBannerTime,
    });

    factory BannerAdaptivList.fromJson(Map<String, dynamic> json) => BannerAdaptivList(
        showAdaptiveBanner: json["showAdaptiveBanner"],
        admobAdaptiveBannerId: json["admobAdaptiveBannerId"],
        counterAdaptiveBanner: json["counterAdaptiveBanner"],
        adaptiveBannerTime: json["adaptiveBannerTime"],
    );

    Map<String, dynamic> toJson() => {
        "showAdaptiveBanner": showAdaptiveBanner,
        "admobAdaptiveBannerId": admobAdaptiveBannerId,
        "counterAdaptiveBanner": counterAdaptiveBanner,
        "adaptiveBannerTime": adaptiveBannerTime,
    };
}
