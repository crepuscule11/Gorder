class Pending {
  int? status;
  String? message;
  List<Pen>? pen;

  Pending({this.status, this.message, this.pen});

  Pending.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      pen = <Pen>[];
      json['data'].forEach((v) {
        pen!.add(new Pen.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.pen != null) {
      data['data'] = this.pen!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pen {
  String? transactionId;
  String? orderTime;
  String? orderDate;
  String? orderStatus;
  String? price;

  Pen(
      {this.transactionId,
      this.orderTime,
      this.orderDate,
      this.orderStatus,
      this.price});

  Pen.fromJson(Map<String, dynamic> json) {
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
