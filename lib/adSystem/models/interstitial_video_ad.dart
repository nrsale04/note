
class InterVideoList {
    bool showInterVideo;
    String admobInterVideoId;
    int counterInterVideo;
    int interVideoTime;

    InterVideoList({
        required this.showInterVideo,
        required this.admobInterVideoId,
        required this.counterInterVideo,
        required this.interVideoTime,
    });

    factory InterVideoList.fromJson(Map<String, dynamic> json) => InterVideoList(
        showInterVideo: json["showInterVideo"],
        admobInterVideoId: json["admobInterVideoId"],
        counterInterVideo: json["counterInterVideo"],
        interVideoTime: json["interVideoTime"],
    );

    Map<String, dynamic> toJson() => {
        "showInterVideo": showInterVideo,
        "admobInterVideoId": admobInterVideoId,
        "counterInterVideo": counterInterVideo,
        "interVideoTime": interVideoTime,
    };
}