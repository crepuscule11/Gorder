import 'package:meta/meta.dart';
import 'dart:convert';

class Where {
  int status;
  String message;
  List<Whe> where;
  String transactionId;
  String paymentType;
  String delType;
  String delAddress;
  String orderTime;
  DateTime orderDate;
  String subtotal;
  String vat;
  String discount;
  String deliveryFee;
  String total;
  String payment;
  String change;
  dynamic prescription;
  String rider;
  String orderStatus;
  bool uploadPof;
  bool canReturn;

  Where({
    required this.status,
    required this.message,
    required this.where,
    required this.transactionId,
    required this.paymentType,
    required this.delType,
    required this.delAddress,
    required this.orderTime,
    required this.orderDate,
    required this.subtotal,
    required this.vat,
    required this.discount,
    required this.deliveryFee,
    required this.total,
    required this.payment,
    required this.change,
    required this.prescription,
    required this.rider,
    required this.orderStatus,
    required this.uploadPof,
    required this.canReturn,
  });

  factory Where.fromJson(String str) => Where.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Where.fromMap(Map<String, dynamic> json) => Where(
        status: json["status"],
        message: json["message"],
        where: List<Whe>.from(json["orders"].map((x) => Whe.fromMap(x))),
        transactionId: json["transaction_id"],
        paymentType: json["payment_type"],
        delType: json["del_type"],
        delAddress: json["del_address"],
        orderTime: json["order_time"],
        orderDate: DateTime.parse(json["order_date"]),
        subtotal: json["subtotal"],
        vat: json["vat"],
        discount: json["discount"],
        deliveryFee: json["delivery_fee"],
        total: json["total"],
        payment: json["payment"],
        change: json["change"],
        prescription: json["prescription"],
        rider: json["rider"],
        orderStatus: json["order_status"],
        uploadPof: json["upload_pof"],
        canReturn: json["canReturn"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "orders": List<dynamic>.from(where.map((x) => x.toMap())),
        "transaction_id": transactionId,
        "payment_type": paymentType,
        "del_type": delType,
        "del_address": delAddress,
        "order_time": orderTime,
        "order_date":
            "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
        "subtotal": subtotal,
        "vat": vat,
        "discount": discount,
        "delivery_fee": deliveryFee,
        "total": total,
        "payment": payment,
        "change": change,
        "prescription": prescription,
        "rider": rider,
        "order_status": orderStatus,
        "upload_pof": uploadPof,
        "canReturn": canReturn,
      };
}

class Whe {
  String productName;
  String productImg;
  String sellingPrice;
  String qty;
  String amount;

  Whe({
    required this.productName,
    required this.productImg,
    required this.sellingPrice,
    required this.qty,
    required this.amount,
  });

  factory Whe.fromJson(String str) => Whe.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Whe.fromMap(Map<String, dynamic> json) => Whe(
        productName: json["product_name"],
        productImg: json["product_img"],
        sellingPrice: json["selling_price"],
        qty: json["qty"],
        amount: json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "product_name": productName,
        "product_img": productImg,
        "selling_price": sellingPrice,
        "qty": qty,
        "amount": amount,
      };
}
