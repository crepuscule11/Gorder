// To parse this JSON data, do
//
//     final sorting = sortingFromMap(jsonString);

import 'dart:convert';

Sorting sortingFromMap(String str) => Sorting.fromMap(json.decode(str));

String sortingToMap(Sorting data) => json.encode(data.toMap());

class Sorting {
  int status;
  String message;
  List<Category> categories;

  Sorting({
    required this.status,
    required this.message,
    required this.categories,
  });

  factory Sorting.fromMap(Map<String, dynamic> json) => Sorting(
        status: json["status"],
        message: json["message"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
      };
  static Sorting fromJson(Map<String, dynamic> json) {
    return Sorting.fromMap(json);
  }
}

class Category {
  String catId;
  String catName;

  Category({
    required this.catId,
    required this.catName,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        catId: json["cat_id"],
        catName: json["cat_name"],
      );

  Map<String, dynamic> toMap() => {
        "cat_id": catId,
        "cat_name": catName,
      };
}
