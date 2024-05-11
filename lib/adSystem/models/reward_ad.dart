
class RewardList {
    bool showReward;
    String admobRewardId;
    int counterReward;
    int rewardTime;

    RewardList({
        required this.showReward,
        required this.admobRewardId,
        required this.counterReward,
        required this.rewardTime,
    });

    factory RewardList.fromJson(Map<String, dynamic> json) => RewardList(
        showReward: json["showReward"],
        admobRewardId: json["admobRewardId"],
        counterReward: json["counterReward"],
        rewardTime: json["rewardTime"],
    );

    Map<String, dynamic> toJson() => {
        "showReward": showReward,
        "admobRewardId": admobRewardId,
        "counterReward": counterReward,
        "rewardTime": rewardTime,
    };
}
