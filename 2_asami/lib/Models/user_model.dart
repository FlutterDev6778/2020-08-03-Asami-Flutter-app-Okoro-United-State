class UserModel {
  String id;
  String name;
  String email;
  String avatarUrl;
  String uid;
  int ts;

  UserModel({
    this.id = "",
    this.name = "",
    this.email = "",
    this.avatarUrl = "",
    this.uid = "",
    this.ts = 0,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = (json['id'] != null) ? json['id'] : "",
        name = (json["name"] != null) ? json["name"] : "",
        email = (json["email"] != null) ? json["email"] : "",
        avatarUrl = (json["avatarUrl"] != null) ? json["avatarUrl"] : "",
        uid = (json["uid"] != null) ? json["uid"] : "",
        ts = (json["ts"] != null) ? json["ts"] : 0;

  Map<String, dynamic> toJson() {
    return {
      "id": (id != null) ? id : "",
      "name": (name != null) ? name : "",
      "email": (email != null) ? email : "",
      "avatarUrl": (avatarUrl != null) ? avatarUrl : "",
      "uid": (uid != null) ? uid : "",
      "ts": (ts != null) ? ts : "",
    };
  }
}
