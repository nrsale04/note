
class InterList {
    bool showInter;
    String admobInterId;
    int counterInter;
    int interTime;

    InterList({
        required this.showInter,
        required this.admobInterId,
        required this.counterInter,
        required this.interTime,
    });

    factory InterList.fromJson(Map<String, dynamic> json) => InterList(
        showInter: json["showInter"],
        admobInterId: json["admobInterId"],
        counterInter: json["counterInter"],
        interTime: json["interTime"],
    );

    Map<String, dynamic> toJson() => {
        "showInter": showInter,
        "admobInterId": admobInterId,
        "counterInter": counterInter,
        "interTime": interTime,
    };
}
