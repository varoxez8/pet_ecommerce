// To parse this JSON data, do
//
//     final allStores = allStoresFromJson(jsonString);

import 'dart:convert';

AllStores allStoresFromJson(String str) => AllStores.fromJson(json.decode(str));

String allStoresToJson(AllStores data) => json.encode(data.toJson());

class AllStores {
  AllStores({
    this.stores,
  });

  List<Store> stores;

  factory AllStores.fromJson(Map<String, dynamic> json) => AllStores(
    stores: List<Store>.from(json["stores"].map((x) => Store.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
  };
}

class Store {
  Store({
    this.id,
    this.name,
    this.image,
    this.email,
    this.phone,
    this.district,
    this.openFrom,
    this.closedAt,
    this.info,
    this.favourites,
    this.storeContacts,
  });

  int id;
  String name;
  String image;
  String email;
  String phone;
  String district;
  String openFrom;
  String closedAt;
  String info;
  int favourites;
  List<StoreContact> storeContacts;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    email: json["email"],
    phone: json["phone"],
    district: json["district"],
    openFrom: json["open_from"],
    closedAt: json["closed_at"],
    info: json["info"],
    favourites: json["favourites"],
    storeContacts: List<StoreContact>.from(json["store_contacts"].map((x) => StoreContact.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "email": email,
    "phone": phone,
    "district": district,
    "open_from": openFrom,
    "closed_at": closedAt,
    "info": info,
    "favourites": favourites,
    "store_contacts": List<dynamic>.from(storeContacts.map((x) => x.toJson())),
  };
}

class StoreContact {
  StoreContact({
    this.id,
    this.storeId,
    this.doctorId,
    this.link,
    this.type,
  });

  int id;
  int storeId;
  String doctorId;
  String link;
  String type;

  factory StoreContact.fromJson(Map<String, dynamic> json) => StoreContact(
    id: json["id"],
    storeId: json["store_id"],
    doctorId: json["doctor_id"],
    link: json["link"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "doctor_id": doctorId,
    "link": link,
    "type": type,
  };
}