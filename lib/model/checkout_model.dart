// To parse this JSON data, do
//
//     final checkOut = checkOutFromJson(jsonString);

import 'dart:convert';

CheckOut checkOutFromJson(String str) => CheckOut.fromJson(json.decode(str));

String checkOutToJson(CheckOut data) => json.encode(data.toJson());

class CheckOut {
  int status;
  String message;
  List<Pepito> items;
  int subtotal;
  double vat;
  int discount;
  double total;
  int deliveryFee;
  double totalPlusDeliveryFee;

  CheckOut({
    required this.status,
    required this.message,
    required this.items,
    required this.subtotal,
    required this.vat,
    required this.discount,
    required this.total,
    required this.deliveryFee,
    required this.totalPlusDeliveryFee,
  });

  factory CheckOut.fromJson(Map<String, dynamic> json) => CheckOut(
        status: json["status"],
        message: json["message"],
        items: List<Pepito>.from(json["items"].map((x) => Pepito.fromJson(x))),
        subtotal: json["subtotal"],
        vat: json["vat"]?.toDouble(),
        discount: json["discount"],
        total: json["total"]?.toDouble(),
        deliveryFee: json["delivery_fee"],
        totalPlusDeliveryFee: json["total_plus_delivery_fee"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "subtotal": subtotal,
        "vat": vat,
        "discount": discount,
        "total": total,
        "delivery_fee": deliveryFee,
        "total_plus_delivery_fee": totalPlusDeliveryFee,
      };
}

class Pepito {
  String productId;
  String productName;
  String productImg;
  int qtyLeft;
  int qty;
  int amount;

  Pepito({
    required this.productId,
    required this.productName,
    required this.productImg,
    required this.qtyLeft,
    required this.qty,
    required this.amount,
  });

  factory Pepito.fromJson(Map<String, dynamic> json) => Pepito(
        productId: json["PRODUCT_ID"],
        productName: json["PRODUCT_NAME"],
        productImg: json["PRODUCT_IMG"],
        qtyLeft: json["QTY_LEFT"]?.toDouble(),
        qty: json["QTY"]?.toDouble(),
        amount: json["AMOUNT"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "PRODUCT_ID": productId,
        "PRODUCT_NAME": productName,
        "PRODUCT_IMG": productImg,
        "QTY_LEFT": qtyLeft,
        "QTY": qty,
        "AMOUNT": amount,
      };
}
