// To parse this JSON data, do
//
//     final emmanMakulit = emmanMakulitFromJson(jsonString);

import 'dart:convert';

EmmanMakulit emmanMakulitFromJson(String str) =>
    EmmanMakulit.fromJson(json.decode(str));

String emmanMakulitToJson(EmmanMakulit data) => json.encode(data.toJson());

class EmmanMakulit {
  int status;
  String message;
  List<OrderItem> orderItems;
  String transactionId;
  String custId;
  String paymentType;
  String deliveryType;
  String unitSt;
  String bgyId;
  String time;
  DateTime date;
  int subtotal;
  int vat;
  int discount;
  int total;
  String delStatus;
  String df;

  EmmanMakulit({
    required this.status,
    required this.message,
    required this.orderItems,
    required this.transactionId,
    required this.custId,
    required this.paymentType,
    required this.deliveryType,
    required this.unitSt,
    required this.bgyId,
    required this.time,
    required this.date,
    required this.subtotal,
    required this.vat,
    required this.discount,
    required this.total,
    required this.delStatus,
    required this.df,
  });

  factory EmmanMakulit.fromJson(Map<String, dynamic> json) => EmmanMakulit(
        status: json["status"],
        message: json["message"],
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
        transactionId: json["transaction_id"],
        custId: json["cust_id"],
        paymentType: json["payment_type"],
        deliveryType: json["delivery_type"],
        unitSt: json["unit_st"],
        bgyId: json["bgy_id"],
        time: json["time"],
        date: DateTime.parse(json["date"]),
        subtotal: json["subtotal"],
        vat: json["VAT"],
        discount: json["discount"],
        total: json["total"],
        delStatus: json["del_status"],
        df: json["df"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "transaction_id": transactionId,
        "cust_id": custId,
        "payment_type": paymentType,
        "delivery_type": deliveryType,
        "unit_st": unitSt,
        "bgy_id": bgyId,
        "time": time,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "subtotal": subtotal,
        "VAT": vat,
        "discount": discount,
        "total": total,
        "del_status": delStatus,
        "df": df,
      };
}

class OrderItem {
  String productId;
  int qtyLeft;
  String qty;
  String amount;

  OrderItem({
    required this.productId,
    required this.qtyLeft,
    required this.qty,
    required this.amount,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        productId: json["PRODUCT_ID"],
        qtyLeft: json["QTY_LEFT"],
        qty: json["QTY"],
        amount: json["AMOUNT"],
      );

  Map<String, dynamic> toJson() => {
        "PRODUCT_ID": productId,
        "QTY_LEFT": qtyLeft,
        "QTY": qty,
        "AMOUNT": amount,
      };
}
