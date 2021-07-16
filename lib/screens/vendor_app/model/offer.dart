// To parse this JSON data, do
//
//     final storeProduct = storeProductFromJson(jsonString);

import 'dart:convert';

StoreProduct storeProductFromJson(String str) => StoreProduct.fromJson(json.decode(str));

String storeProductToJson(StoreProduct data) => json.encode(data.toJson());

class StoreProduct {
  StoreProduct({
    this.offers,
  });

  List<Offer> offers;

  factory StoreProduct.fromJson(Map<String, dynamic> json) => StoreProduct(
    offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
  };
}

class Offer {
  Offer({
    this.id,
    this.storeId,
    this.storeName,
    this.category,
    this.type,
    this.desc,
    this.image,
  });

  int id;
  int storeId;
  String storeName;
  String category;
  String type;
  String desc;
  String image;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    storeId: json["store_id"],
    storeName: json["store_name"],
    category: json["category"],
    type: json["type"],
    desc: json["desc"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "store_name": storeName,
    "category": category,
    "type": type,
    "desc": desc,
    "image": image,
  };
}