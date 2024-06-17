// To parse this JSON data, do
//
//     final orderList = orderListFromJson(jsonString);

import 'dart:convert';

OrderList orderListFromJson(String str) => OrderList.fromJson(json.decode(str));

String orderListToJson(OrderList data) => json.encode(data.toJson());

class OrderList {
  int status;
  String message;
  List<Data> data;

  OrderList({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        status: json["status"],
        message: json["message"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  String transactionId;
  String orderTime;
  DateTime orderDate;
  String orderStatus;

  Data({
    required this.transactionId,
    required this.orderTime,
    required this.orderDate,
    required this.orderStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactionId: json["transaction_id"],
        orderTime: json["order_time"],
        orderDate: DateTime.parse(json["order_date"]),
        orderStatus: json["order_status"],
      );

  Map<String, dynamic> toJson() => {
        "transaction_id": transactionId,
        "order_time": orderTime,
        "order_date":
            "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
        "order_status": orderStatus,
      };
}
