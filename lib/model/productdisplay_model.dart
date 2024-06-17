// To parse this JSON data, do
//
//     final display = displayFromMap(jsonString);

import 'dart:convert';

Display displayFromMap(String str) => Display.fromMap(json.decode(str));

String displayToMap(Display data) => json.encode(data.toMap());

class Display {
  int status;
  String message;
  List<Dproduct> products;

  Display({
    required this.status,
    required this.message,
    required this.products,
  });

  factory Display.fromMap(Map<String, dynamic> json) => Display(
        status: json["status"],
        message: json["message"],
        products: List<Dproduct>.from(
            json["products"].map((x) => Dproduct.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };

  static Display fromJson(Map<String, dynamic> json) {
    return Display.fromMap(json);
  }
}

class Dproduct {
  int qty;
  String productId;
  String productName;
  String? g;
  String? mg;
  String? ml;
  Description description;
  String img;
  double price;
  bool prescribe;

  Dproduct({
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

  factory Dproduct.fromMap(Map<String, dynamic> json) => Dproduct(
        qty: json["qty"],
        productId: json["product_id"],
        productName: json["product_name"],
        g: json["g"],
        mg: json["mg"],
        ml: json["ml"],
        description: descriptionValues.map[json["description"]]!,
        img: json["img"],
        price: json["price"]?.toDouble(),
        prescribe: json["prescribe"],
      );

  Map<String, dynamic> toMap() => {
        "qty": qty,
        "product_id": productId,
        "product_name": productName,
        "g": g,
        "mg": mg,
        "ml": ml,
        "description": descriptionValues.reverse[description],
        "img": img,
        "price": price,
        "prescribe": prescribe,
      };
  String getImageUrl(String img) {
    if (img.startsWith('img: ')) {
      return img.substring(5); // Remove the 'img: ' prefix
    }
    return img;
  }
}

enum Description { EMPTY, THIS_IS_SAMPLE_ONLY }

final descriptionValues = EnumValues({
  "": Description.EMPTY,
  "This is sample only": Description.THIS_IS_SAMPLE_ONLY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
