// To parse this JSON data, do
//
//     final exp = expFromJson(jsonString);

import 'dart:convert';

Exp expFromJson(String str) => Exp.fromJson(json.decode(str));

String expToJson(Exp data) => json.encode(data.toJson());

class Exp {
  int status;
  String message;
  List<Len> items;
  Noob orderDetails;

  Exp({
    required this.status,
    required this.message,
    required this.items,
    required this.orderDetails,
  });

  factory Exp.fromJson(Map<String, dynamic> json) => Exp(
        status: json["status"],
        message: json["message"],
        items: List<Len>.from(json["items"].map((x) => Len.fromJson(x))),
        orderDetails: Noob.fromJson(json["order_details"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "order_details": orderDetails.toJson(),
      };
}

class Len {
  String productId;
  String productName;
  String productImg;
  int qtyLeft;
  int qty;
  int amount;
  bool prescribe;

  Len({
    required this.productId,
    required this.productName,
    required this.productImg,
    required this.qtyLeft,
    required this.qty,
    required this.amount,
    required this.prescribe,
  });

  factory Len.fromJson(Map<String, dynamic> json) => Len(
        productId: json["PRODUCT_ID"],
        productName: json["PRODUCT_NAME"],
        productImg: json["PRODUCT_IMG"],
        qtyLeft: json["QTY_LEFT"],
        qty: json["QTY"],
        amount: json["AMOUNT"],
        prescribe: json["PRESCRIBE"],
      );

  Map<String, dynamic> toJson() => {
        "PRODUCT_ID": productId,
        "PRODUCT_NAME": productName,
        "PRODUCT_IMG": productImg,
        "QTY_LEFT": qtyLeft,
        "QTY": qty,
        "AMOUNT": amount,
        "PRESCRIBE": prescribe,
      };
}

class Noob {
  int subtotal;
  int vat;
  int discount;
  int total;
  int deliveryFee;
  int totalPlusDeliveryFee;
  int presribePro;
  String paymentType;
  bool uploadPof;
  String paymentQr;
  String bankNo;

  Noob({
    required this.subtotal,
    required this.vat,
    required this.discount,
    required this.total,
    required this.deliveryFee,
    required this.totalPlusDeliveryFee,
    required this.presribePro,
    required this.paymentType,
    required this.uploadPof,
    required this.paymentQr,
    required this.bankNo,
  });

  factory Noob.fromJson(Map<String, dynamic> json) => Noob(
        subtotal: json["subtotal"],
        vat: json["vat"],
        discount: json["discount"],
        total: json["total"],
        deliveryFee: json["delivery_fee"],
        totalPlusDeliveryFee: json["total_plus_delivery_fee"],
        presribePro: json["presribe_pro"],
        paymentType: json["payment_type"],
        uploadPof: json["upload_pof"],
        paymentQr: json["payment_qr"],
        bankNo: json["bank_no"],
      );

  Map<String, dynamic> toJson() => {
        "subtotal": subtotal,
        "vat": vat,
        "discount": discount,
        "total": total,
        "delivery_fee": deliveryFee,
        "total_plus_delivery_fee": totalPlusDeliveryFee,
        "presribe_pro": presribePro,
        "payment_type": paymentType,
        "upload_pof": uploadPof,
        "payment_qr": paymentQr,
        "bank_no": bankNo,
      };
}
