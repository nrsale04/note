
class BannerList {
    bool showBanner;
    String admobBannerId;
    int counterBanner;
    int bannerTime;

    BannerList({
        required this.showBanner,
        required this.admobBannerId,
        required this.counterBanner,
        required this.bannerTime,
    });

    factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(
        showBanner: json["showBanner"],
        admobBannerId: json["admobBannerId"],
        counterBanner: json["counterBanner"],
        bannerTime: json["bannerTime"],
    );

    Map<String, dynamic> toJson() => {
        "showBanner": showBanner,
        "admobBannerId": admobBannerId,
        "counterBanner": counterBanner,
        "bannerTime": bannerTime,
    };
}
