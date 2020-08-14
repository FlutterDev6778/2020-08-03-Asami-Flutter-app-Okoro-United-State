class UserModel {
  String id;
  String name;
  String email;
  String avatarUrl;
  bool isPremium;
  int expTs;
  bool isAdmin;
  String uid;
  int ts;

  UserModel({
    this.id = "",
    this.name = "",
    this.email = "",
    this.avatarUrl = "",
    this.isPremium = false,
    this.expTs = 0,
    this.isAdmin = false,
    this.uid = "",
    this.ts = 0,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = (json['id'] != null) ? json['id'] : "",
        name = (json["name"] != null) ? json["name"] : "",
        email = (json["email"] != null) ? json["email"] : "",
        avatarUrl = (json["avatarUrl"] != null) ? json["avatarUrl"] : "",
        isPremium = (json["isPremium"] != null) ? json["isPremium"] : false,
        expTs = (json["expTs"] != null) ? json["expTs"] : 0,
        isAdmin = (json["isAdmin"] != null) ? json["isAdmin"] : false,
        uid = (json["uid"] != null) ? json["uid"] : "",
        ts = (json["ts"] != null) ? json["ts"] : 0;

  Map<String, dynamic> toJson() {
    return {
      "id": (id != null) ? id : "",
      "name": (name != null) ? name : "",
      "email": (email != null) ? email : "",
      "avatarUrl": (avatarUrl != null) ? avatarUrl : "",
      "isPremium": (isPremium != null) ? isPremium : false,
      "expTs": (expTs != null) ? expTs : 0,
      "isAdmin": (isAdmin != null) ? isAdmin : false,
      "uid": (uid != null) ? uid : "",
      "ts": (ts != null) ? ts : "",
    };
  }
}
