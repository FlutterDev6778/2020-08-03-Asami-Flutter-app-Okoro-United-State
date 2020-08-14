class PromoCodeModel {
  String id;
  String title;
  String description;
  String promoCode;
  int ts;

  PromoCodeModel({
    this.id = "",
    this.title = "",
    this.description = "",
    this.promoCode = "",
    this.ts = 0,
  });

  PromoCodeModel.fromJson(Map<String, dynamic> json)
      : id = (json['id'] != null) ? json['id'] : "",
        title = (json["title"] != null) ? json["title"] : "",
        description = (json["description"] != null) ? json["description"] : "",
        promoCode = (json["promoCode"] != null) ? json["promoCode"] : "",
        ts = (json["ts"] != null) ? json["ts"] : 0;

  Map<String, dynamic> toJson() {
    return {
      "id": (id != null) ? id : "",
      "title": (title != null) ? title : "",
      "description": (description != null) ? description : "",
      "promoCode": (promoCode != null) ? promoCode : "",
      "ts": (ts != null) ? ts : "",
    };
  }
}
