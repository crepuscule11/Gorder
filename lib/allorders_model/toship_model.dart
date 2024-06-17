class Toship {
  int? status;
  String? message;
  List<Tosh>? tosh;

  Toship({this.status, this.message, this.tosh});

  Toship.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      tosh = <Tosh>[];
      json['data'].forEach((v) {
        tosh!.add(new Tosh.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.tosh != null) {
      data['data'] = this.tosh!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tosh {
  String? transactionId;
  String? orderTime;
  String? orderDate;
  String? orderStatus;
  String? price;

  Tosh(
      {this.transactionId,
      this.orderTime,
      this.orderDate,
      this.orderStatus,
      this.price});

  Tosh.fromJson(Map<String, dynamic> json) {
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
