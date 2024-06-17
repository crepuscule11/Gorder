class Delivered {
  int? status;
  String? message;
  List<Del>? del;

  Delivered({this.status, this.message, this.del});

  Delivered.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      del = <Del>[];
      json['data'].forEach((v) {
        del!.add(new Del.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.del != null) {
      data['data'] = this.del!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Del {
  String? transactionId;
  String? orderTime;
  String? orderDate;
  String? orderStatus;
  String? price;

  Del(
      {this.transactionId,
      this.orderTime,
      this.orderDate,
      this.orderStatus,
      this.price});

  Del.fromJson(Map<String, dynamic> json) {
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
