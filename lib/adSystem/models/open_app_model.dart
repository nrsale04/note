
class OpenAppList {
    bool showOpenApp;
    String admobOpenAppId;
    int counterOpenApp;
    int openAppTime;

    OpenAppList({
        required this.showOpenApp,
        required this.admobOpenAppId,
        required this.counterOpenApp,
        required this.openAppTime,
    });

    factory OpenAppList.fromJson(Map<String, dynamic> json) => OpenAppList(
        showOpenApp: json["showOpenApp"],
        admobOpenAppId: json["admobOpenAppId"],
        counterOpenApp: json["counterOpenApp"],
        openAppTime: json["openAppTime"],
    );

    Map<String, dynamic> toJson() => {
        "showOpenApp": showOpenApp,
        "admobOpenAppId": admobOpenAppId,
        "counterOpenApp": counterOpenApp,
        "openAppTime": openAppTime,
    };
}