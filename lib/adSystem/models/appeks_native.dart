
class AppeksNativeList {
    bool showAppeksNative;
    String nativeBackgroundUrl;
    String nativeTitle;
    String nativeCaption;
    String nativeAvatarUrl;
    String nativeTextBtn;
    String nativeActionUrl;
    int nativeCounter;
    int nativeTimer;

    AppeksNativeList({
        required this.showAppeksNative,
        required this.nativeBackgroundUrl,
        required this.nativeTitle,
        required this.nativeCaption,
        required this.nativeAvatarUrl,
        required this.nativeTextBtn,
        required this.nativeActionUrl,
        required this.nativeCounter,
        required this.nativeTimer,
    });

    factory AppeksNativeList.fromJson(Map<String, dynamic> json) => AppeksNativeList(
        showAppeksNative: json["showAppeksNative"],
        nativeBackgroundUrl: json["nativeBackgroundUrl"],
        nativeTitle: json["nativeTitle"],
        nativeCaption: json["nativeCaption"],
        nativeAvatarUrl: json["nativeAvatarUrl"],
        nativeTextBtn: json["nativeTextBtn"],
        nativeActionUrl: json["nativeActionUrl"],
        nativeCounter: json["nativeCounter"],
        nativeTimer: json["nativeTimer"],
    );

    Map<String, dynamic> toJson() => {
        "showAppeksNative": showAppeksNative,
        "nativeBackgroundUrl": nativeBackgroundUrl,
        "nativeTitle": nativeTitle,
        "nativeCaption": nativeCaption,
        "nativeAvatarUrl": nativeAvatarUrl,
        "nativeTextBtn": nativeTextBtn,
        "nativeActionUrl": nativeActionUrl,
        "nativeCounter": nativeCounter,
        "nativeTimer": nativeTimer,
    };
}