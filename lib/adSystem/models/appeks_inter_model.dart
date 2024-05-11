
class AppeksInterListElement {
    bool? showAppeksInter;
    String? interTitle;
    String subtitle;
    String titleCaption;
    String interCaption;
    String avatarImage;
    String interBackgroundUrl;
    String backgroundColor;
    String btnText;
    String shareLink;
    String btnTextShare;
    String actionButton;
    bool toggleBackgroundImage;
    String discriptionImage;
    int? interCounter;
    int? interTimer;
    bool? showAppeksOpenApp;
    String? openAppTitle;
    int? openAppCounter;
    int? openAppTimer;
    bool? showCustomInter;
    int? customInterCounter;
    int? customInterTimer;

    AppeksInterListElement({
        this.showAppeksInter,
        this.interTitle,
        required this.subtitle,
        required this.titleCaption,
        required this.interCaption,
        required this.avatarImage,
        required this.interBackgroundUrl,
        required this.backgroundColor,
        required this.btnText,
        required this.shareLink,
        required this.btnTextShare,
        required this.actionButton,
        required this.toggleBackgroundImage,
        required this.discriptionImage,
        this.interCounter,
        this.interTimer,
        this.showAppeksOpenApp,
        this.openAppTitle,
        this.openAppCounter,
        this.openAppTimer,
        this.showCustomInter,
        this.customInterCounter,
        this.customInterTimer,
    });

    factory AppeksInterListElement.fromJson(Map<String, dynamic> json) => AppeksInterListElement(
        showAppeksInter: json["showAppeksInter"],
        interTitle: json["interTitle"],
        subtitle: json["subtitle"],
        titleCaption: json["titleCaption"],
        interCaption: json["interCaption"],
        avatarImage: json["avatarImage"],
        interBackgroundUrl: json["interBackgroundUrl"],
        backgroundColor: json["backgroundColor"],
        btnText: json["btnText"],
        shareLink: json["shareLink"],
        btnTextShare: json["btnTextShare"],
        actionButton: json["actionButton"],
        toggleBackgroundImage: json["toggleBackgroundImage"],
        discriptionImage: json["discriptionImage"],
        interCounter: json["interCounter"],
        interTimer: json["interTimer"],
        showAppeksOpenApp: json["showAppeksOpenApp"],
        openAppTitle: json["openAppTitle"],
        openAppCounter: json["openAppCounter"],
        openAppTimer: json["openAppTimer"],
        showCustomInter: json["showCustomInter"],
        customInterCounter: json["customInterCounter"],
        customInterTimer: json["customInterTimer"],
    );

    Map<String, dynamic> toJson() => {
        "showAppeksInter": showAppeksInter,
        "interTitle": interTitle,
        "subtitle": subtitle,
        "titleCaption": titleCaption,
        "interCaption": interCaption,
        "avatarImage": avatarImage,
        "interBackgroundUrl": interBackgroundUrl,
        "backgroundColor": backgroundColor,
        "btnText": btnText,
        "shareLink": shareLink,
        "btnTextShare": btnTextShare,
        "actionButton": actionButton,
        "toggleBackgroundImage": toggleBackgroundImage,
        "discriptionImage": discriptionImage,
        "interCounter": interCounter,
        "interTimer": interTimer,
        "showAppeksOpenApp": showAppeksOpenApp,
        "openAppTitle": openAppTitle,
        "openAppCounter": openAppCounter,
        "openAppTimer": openAppTimer,
        "showCustomInter": showCustomInter,
        "customInterCounter": customInterCounter,
        "customInterTimer": customInterTimer,
    };
}
