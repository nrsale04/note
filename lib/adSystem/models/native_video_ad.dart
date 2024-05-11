
class NativeVideoList {
    bool showNativeVideo;
    String admobNativeVideoId;
    int counterNativeVideo;
    int nativeVideoTime;

    NativeVideoList({
        required this.showNativeVideo,
        required this.admobNativeVideoId,
        required this.counterNativeVideo,
        required this.nativeVideoTime,
    });

    factory NativeVideoList.fromJson(Map<String, dynamic> json) => NativeVideoList(
        showNativeVideo: json["showNativeVideo"],
        admobNativeVideoId: json["admobNativeVideoId"],
        counterNativeVideo: json["counterNativeVideo"],
        nativeVideoTime: json["nativeVideoTime"],
    );

    Map<String, dynamic> toJson() => {
        "showNativeVideo": showNativeVideo,
        "admobNativeVideoId": admobNativeVideoId,
        "counterNativeVideo": counterNativeVideo,
        "nativeVideoTime": nativeVideoTime,
    };
}
