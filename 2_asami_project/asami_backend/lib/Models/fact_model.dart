class FactModel {
  String id;
  String countryName;
  String description;
  int ts;

  FactModel({
    this.id = "",
    this.countryName = "",
    this.description = "",
    this.ts = 0,
  });

  FactModel.fromJson(Map<String, dynamic> json)
      : id = (json['id'] != null) ? json['id'] : "",
        countryName = (json["countryName"] != null) ? json["countryName"] : "",
        description = (json["description"] != null) ? json["description"] : "",
        ts = (json["ts"] != null) ? json["ts"] : 0;

  Map<String, dynamic> toJson() {
    return {
      "id": (id != null) ? id : "",
      "countryName": (countryName != null) ? countryName : "",
      "description": (description != null) ? description : "",
      "ts": (ts != null) ? ts : "",
    };
  }
}
