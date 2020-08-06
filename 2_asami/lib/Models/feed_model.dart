class FeedModel {
  String id;
  String title;
  String description;
  String avatarUrl;
  String imageUrl;
  int ts;

  FeedModel({
    this.id = "",
    this.title = "",
    this.description = "",
    this.avatarUrl = "",
    this.imageUrl = "",
    this.ts = 0,
  });

  FeedModel.fromJson(Map<String, dynamic> json)
      : id = (json['id'] != null) ? json['id'] : "",
        title = (json["title"] != null) ? json["title"] : "",
        description = (json["description"] != null) ? json["description"] : "",
        avatarUrl = (json["avatarUrl"] != null) ? json["avatarUrl"] : "",
        imageUrl = (json["imageUrl"] != null) ? json["imageUrl"] : "",
        ts = (json["ts"] != null) ? json["ts"] : 0;

  Map<String, dynamic> toJson() {
    return {
      "id": (id != null) ? id : "",
      "title": (title != null) ? title : "",
      "description": (description != null) ? description : "",
      "avatarUrl": (avatarUrl != null) ? avatarUrl : "",
      "imageUrl": (imageUrl != null) ? imageUrl : "",
      "ts": (ts != null) ? ts : "",
    };
  }
}
