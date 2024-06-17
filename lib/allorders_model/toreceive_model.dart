class Receiveee {
  int? status;
  String? message;
  List<Rec>? rec;

  Receiveee({this.status, this.message, this.rec});

  Receiveee.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      rec = <Rec>[];
      json['data'].forEach((v) {
        rec!.add(new Rec.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.rec != null) {
      data['data'] = this.rec!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rec {
  String? transactionId;
  String? orderTime;
  String? orderDate;
  String? orderStatus;
  String? price;

  Rec(
      {this.transactionId,
      this.orderTime,
      this.orderDate,
      this.orderStatus,
      this.price});

  Rec.fromJson(Map<String, dynamic> json) {
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
