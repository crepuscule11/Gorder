// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
  int status;
  String message;
  List<PaymentType> paymentTypes;

  Payment({
    required this.status,
    required this.message,
    required this.paymentTypes,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        status: json["status"],
        message: json["message"],
        paymentTypes: List<PaymentType>.from(
            json["payment_types"].map((x) => PaymentType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "payment_types":
            List<dynamic>.from(paymentTypes.map((x) => x.toJson())),
      };
}

class PaymentType {
  String typeId;
  String paymentType;

  PaymentType({
    required this.typeId,
    required this.paymentType,
  });

  factory PaymentType.fromJson(Map<String, dynamic> json) => PaymentType(
        typeId: json["type_id"],
        paymentType: json["payment_type"],
      );

  Map<String, dynamic> toJson() => {
        "type_id": typeId,
        "payment_type": paymentType,
      };
}
