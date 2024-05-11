
class RewardInterList {
    bool showRewardInter;
    String admobRewardInterId;
    int counterRewardInter;
    int rewardInterTime;

    RewardInterList({
        required this.showRewardInter,
        required this.admobRewardInterId,
        required this.counterRewardInter,
        required this.rewardInterTime,
    });

    factory RewardInterList.fromJson(Map<String, dynamic> json) => RewardInterList(
        showRewardInter: json["showRewardInter"],
        admobRewardInterId: json["admobRewardInterId"],
        counterRewardInter: json["counterRewardInter"],
        rewardInterTime: json["rewardInterTime"],
    );

    Map<String, dynamic> toJson() => {
        "showRewardInter": showRewardInter,
        "admobRewardInterId": admobRewardInterId,
        "counterRewardInter": counterRewardInter,
        "rewardInterTime": rewardInterTime,
    };
}