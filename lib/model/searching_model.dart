import 'package:meta/meta.dart';
import 'dart:convert';

class Searching {
  int status;
  String message;
  List<Etits> etits;

  Searching({
    required this.status,
    required this.message,
    required this.etits,
  });

  factory Searching.fromJson(String str) => Searching.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Searching.fromMap(Map<String, dynamic> json) => Searching(
        status: json["status"],
        message: json["message"],
        etits: List<Etits>.from(json["products"].map((x) => Etits.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "products": List<dynamic>.from(etits.map((x) => x.toMap())),
      };
}

class Etits {
  int qty;
  String productId;
  String productName;
  dynamic g;
  dynamic mg;
  dynamic ml;
  String description;
  String img;
  int price;
  bool prescribe;

  Etits({
    required this.qty,
    required this.productId,
    required this.productName,
    required this.g,
    required this.mg,
    required this.ml,
    required this.description,
    required this.img,
    required this.price,
    required this.prescribe,
  });

  factory Etits.fromJson(String str) => Etits.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Etits.fromMap(Map<String, dynamic> json) => Etits(
        qty: json["qty"],
        productId: json["product_id"],
        productName: json["product_name"],
        g: json["g"],
        mg: json["mg"],
        ml: json["ml"],
        description: json["description"],
        img: json["img"],
        price: json["price"],
        prescribe: json["prescribe"],
      );

  Map<String, dynamic> toMap() => {
        "qty": qty,
        "product_id": productId,
        "product_name": productName,
        "g": g,
        "mg": mg,
        "ml": ml,
        "description": description,
        "img": img,
        "price": price,
        "prescribe": prescribe,
      };
}
