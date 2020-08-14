class FeedModel {
  String id;
  String description;
  String imageUrl;
  String userID;
  int ts;

  FeedModel({
    this.id = "",
    this.description = "",
    this.imageUrl = "",
    this.userID = "",
    this.ts = 0,
  });

  FeedModel.fromJson(Map<String, dynamic> json)
      : id = (json['id'] != null) ? json['id'] : "",
        description = (json["description"] != null) ? json["description"] : "",
        imageUrl = (json["imageUrl"] != null) ? json["imageUrl"] : "",
        userID = (json["userID"] != null) ? json["userID"] : "",
        ts = (json["ts"] != null) ? json["ts"] : 0;

  Map<String, dynamic> toJson() {
    return {
      "id": (id != null) ? id : "",
      "description": (description != null) ? description : "",
      "imageUrl": (imageUrl != null) ? imageUrl : "",
      "userID": (userID != null) ? userID : "",
      "ts": (ts != null) ? ts : "",
    };
  }
}
