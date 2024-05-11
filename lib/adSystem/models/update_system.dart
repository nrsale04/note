
class UpdateSystem {
    bool activeUpdate;
    bool forceToggleNormalUpdate;
    String title;
    String caption;
    String avatarUrl;
    String textBtn;
    String actions;
    String versionApp;

    UpdateSystem({
        required this.activeUpdate,
        required this.forceToggleNormalUpdate,
        required this.title,
        required this.caption,
        required this.avatarUrl,
        required this.textBtn,
        required this.actions,
        required this.versionApp,
    });

    factory UpdateSystem.fromJson(Map<String, dynamic> json) => UpdateSystem(
        activeUpdate: json["activeUpdate"],
        forceToggleNormalUpdate: json["forceToggleNormalUpdate"],
        title: json["title"],
        caption: json["caption"],
        avatarUrl: json["avatarUrl"],
        textBtn: json["textBtn"],
        actions: json["actions"],
        versionApp: json["versionApp"],
    );

    Map<String, dynamic> toJson() => {
        "activeUpdate": activeUpdate,
        "forceToggleNormalUpdate": forceToggleNormalUpdate,
        "title": title,
        "caption": caption,
        "avatarUrl": avatarUrl,
        "textBtn": textBtn,
        "actions": actions,
        "versionApp": versionApp,
    };
}
