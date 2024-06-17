class OrderDetails {
  int? status;
  String? message;
  List<Orders>? orders;
  String? transactionId;
  String? paymentType;
  String? delType;
  String? delAddress;
  String? orderTime;
  String? orderDate;
  String? subtotal;
  String? vat;
  String? discount;
  String? deliveryFee;
  String? total;
  String? payment;
  String? change;
  Null? prescription;
  String? rider;
  String? orderStatus;

  OrderDetails(
      {this.status,
      this.message,
      this.orders,
      this.transactionId,
      this.paymentType,
      this.delType,
      this.delAddress,
      this.orderTime,
      this.orderDate,
      this.subtotal,
      this.vat,
      this.discount,
      this.deliveryFee,
      this.total,
      this.payment,
      this.change,
      this.prescription,
      this.rider,
      this.orderStatus});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
    transactionId = json['transaction_id'];
    paymentType = json['payment_type'];
    delType = json['del_type'];
    delAddress = json['del_address'];
    orderTime = json['order_time'];
    orderDate = json['order_date'];
    subtotal = json['subtotal'];
    vat = json['vat'];
    discount = json['discount'];
    deliveryFee = json['delivery_fee'];
    total = json['total'];
    payment = json['payment'];
    change = json['change'];
    prescription = json['prescription'];
    rider = json['rider'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    data['transaction_id'] = this.transactionId;
    data['payment_type'] = this.paymentType;
    data['del_type'] = this.delType;
    data['del_address'] = this.delAddress;
    data['order_time'] = this.orderTime;
    data['order_date'] = this.orderDate;
    data['subtotal'] = this.subtotal;
    data['vat'] = this.vat;
    data['discount'] = this.discount;
    data['delivery_fee'] = this.deliveryFee;
    data['total'] = this.total;
    data['payment'] = this.payment;
    data['change'] = this.change;
    data['prescription'] = this.prescription;
    data['rider'] = this.rider;
    data['order_status'] = this.orderStatus;
    return data;
  }
}

class Orders {
  String? productName;
  String? productImg;
  String? sellingPrice;
  String? qty;
  String? amount;

  Orders(
      {this.productName,
      this.productImg,
      this.sellingPrice,
      this.qty,
      this.amount});

  Orders.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productImg = json['product_img'];
    sellingPrice = json['selling_price'];
    qty = json['qty'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_img'] = this.productImg;
    data['selling_price'] = this.sellingPrice;
    data['qty'] = this.qty;
    data['amount'] = this.amount;
    return data;
  }
}
