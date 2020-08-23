class HerbModel {
  String id;
  String countryName;
  String name;
  String description;
  String imageUrl;
  int ts;

  HerbModel({
    this.id = "",
    this.countryName = "",
    this.name = "",
    this.description = "",
    this.imageUrl = "",
    this.ts = 0,
  });

  HerbModel.fromJson(Map<String, dynamic> json)
      : id = (json['id'] != null) ? json['id'] : "",
        countryName = (json["countryName"] != null) ? json["countryName"] : "",
        name = (json["name"] != null) ? json["name"] : "",
        description = (json["description"] != null) ? json["description"] : "",
        imageUrl = (json["imageUrl"] != null) ? json["imageUrl"] : "",
        ts = (json["ts"] != null) ? json["ts"] : 0;

  Map<String, dynamic> toJson() {
    return {
      "id": (id != null) ? id : "",
      "countryName": (countryName != null) ? countryName : "",
      "name": (name != null) ? name : "",
      "description": (description != null) ? description : "",
      "imageUrl": (imageUrl != null) ? imageUrl : "",
      "ts": (ts != null) ? ts : "",
    };
  }
}
