// To parse this JSON data, do
//
//     final cartItems = cartItemsFromJson(jsonString);

import 'dart:convert';

CartItems cartItemsFromJson(String str) => CartItems.fromJson(json.decode(str));

String cartItemsToJson(CartItems data) => json.encode(data.toJson());

class CartItems {
  int status;
  String message;
  String custId;
  String cartId;
  int total;
  List<Lhendcy> data;

  CartItems({
    required this.status,
    required this.message,
    required this.custId,
    required this.cartId,
    required this.total,
    required this.data,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) => CartItems(
        status: json["status"],
        message: json["message"],
        custId: json["cust_id"],
        cartId: json["cart_id"],
        total: json["total"],
        data: List<Lhendcy>.from(json["data"].map((x) => Lhendcy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "cust_id": custId,
        "cart_id": cartId,
        "total": total,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Lhendcy {
  String productName;
  String picture;
  int sellingPrice;
  String productId;
  int qty;
  int amount;

  Lhendcy({
    required this.productName,
    required this.picture,
    required this.sellingPrice,
    required this.productId,
    required this.qty,
    required this.amount,
  });

  factory Lhendcy.fromJson(Map<String, dynamic> json) => Lhendcy(
        productName: json["product_name"],
        picture: json["picture"],
        sellingPrice: json["selling_price"],
        productId: json["product_id"],
        qty: json["qty"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "picture": picture,
        "selling_price": sellingPrice,
        "product_id": productId,
        "qty": qty,
        "amount": amount,
      };
}
