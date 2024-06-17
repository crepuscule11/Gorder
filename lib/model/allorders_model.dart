class OlOrders {
  int? status;
  String? message;
  List<Data>? data;

  OlOrders({this.status, this.message, this.data});

  OlOrders.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  late String transactionId;
  String? orderTime;
  String? orderDate;
  String? orderStatus;
  String? price;

  Data(
      {required this.transactionId,
      this.orderTime,
      this.orderDate,
      this.orderStatus,
      this.price});

  Data.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    orderTime = json['order_time'];
    orderDate = json['order_date'];
    orderStatus = json['order_status'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['order_time'] = this.orderTime;
    data['order_date'] = this.orderDate;
    data['order_status'] = this.orderStatus;
    data['price'] = this.price;
    return data;
  }
}
