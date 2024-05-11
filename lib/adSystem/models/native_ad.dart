
class NativeList {
    bool showNative;
    String admobNativeId;
    int counterNative;
    int nativeTime;

    NativeList({
        required this.showNative,
        required this.admobNativeId,
        required this.counterNative,
        required this.nativeTime,
    });

    factory NativeList.fromJson(Map<String, dynamic> json) => NativeList(
        showNative: json["showNative"],
        admobNativeId: json["admobNativeId"],
        counterNative: json["counterNative"],
        nativeTime: json["nativeTime"],
    );

    Map<String, dynamic> toJson() => {
        "showNative": showNative,
        "admobNativeId": admobNativeId,
        "counterNative": counterNative,
        "nativeTime": nativeTime,
    };
}
