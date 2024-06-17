class CheckOut2 {
  CheckOut2({
    required this.status,
    required this.message,
    required this.items,
    required this.subtotal,
    required this.vat,
    required this.discount,
    required this.total,
    required this.deliveryFee,
    required this.totalPlusDeliveryFee,
  });
  late final int status;
  late final String message;
  late final List<Items> items;
  late final int subtotal;
  late final int vat;
  late final int discount;
  late final int total;
  late final int deliveryFee;
  late final int totalPlusDeliveryFee;

  CheckOut2.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
    subtotal = json['subtotal'];
    vat = json['vat'];
    discount = json['discount'];
    total = json['total'];
    deliveryFee = json['delivery_fee'];
    totalPlusDeliveryFee = json['total_plus_delivery_fee'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['subtotal'] = subtotal;
    _data['vat'] = vat;
    _data['discount'] = discount;
    _data['total'] = total;
    _data['delivery_fee'] = deliveryFee;
    _data['total_plus_delivery_fee'] = totalPlusDeliveryFee;
    return _data;
  }
}

class Items {
  Items({
    required this.PRODUCTID,
    required this.PRODUCTNAME,
    required this.PRODUCTIMG,
    required this.QTYLEFT,
    required this.QTY,
    required this.AMOUNT,
  });
  late final String PRODUCTID;
  late final String PRODUCTNAME;
  late final String PRODUCTIMG;
  late final int QTYLEFT;
  late final int QTY;
  late final int AMOUNT;

  Items.fromJson(Map<String, dynamic> json) {
    PRODUCTID = json['PRODUCT_ID'];
    PRODUCTNAME = json['PRODUCT_NAME'];
    PRODUCTIMG = json['PRODUCT_IMG'];
    QTYLEFT = json['QTY_LEFT'];
    QTY = json['QTY'];
    AMOUNT = json['AMOUNT'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['PRODUCT_ID'] = PRODUCTID;
    _data['PRODUCT_NAME'] = PRODUCTNAME;
    _data['PRODUCT_IMG'] = PRODUCTIMG;
    _data['QTY_LEFT'] = QTYLEFT;
    _data['QTY'] = QTY;
    _data['AMOUNT'] = AMOUNT;
    return _data;
  }
}
