class OrderInvoiceResModel {
  OrderInvoiceResModel({
    required this.id,
    required this.transactionReference,
    required this.orderId,
    required this.userId,
    required this.dealerId,
    required this.subDealer,
    required this.amount,
    required this.status,
    required this.paymentStatus,
    required this.invoicefileUrl,
    required this.recieptfileUrl,
    required this.invoiceReference,
    required this.dueDate,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? transactionReference;
  final int? orderId;
  final int? userId;
  final int? dealerId;
  final int? subDealer;
  final String? amount;
  final String? status;
  final String? paymentStatus;
  final dynamic invoicefileUrl;
  final dynamic recieptfileUrl;
  final dynamic invoiceReference;
  final dynamic dueDate;
  final List<Item> items;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory OrderInvoiceResModel.fromJson(Map<String, dynamic> json) {
    return OrderInvoiceResModel(
      id: json["id"],
      transactionReference: json["transaction_reference"],
      orderId: json["orderId"],
      userId: json["userId"],
      dealerId: json["dealerId"],
      subDealer: json["sub_dealer"],
      amount: json["amount"],
      status: json["status"],
      paymentStatus: json["payment_status"],
      invoicefileUrl: json["invoicefileUrl"],
      recieptfileUrl: json["recieptfileUrl"],
      invoiceReference: json["invoice_reference"],
      dueDate: json["due_date"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}

class Item {
  Item({
    required this.id,
    required this.orderId,
    required this.discount,
    required this.subtotal,
    required this.validity,
    required this.dealerId,
    required this.itemName,
    required this.vendorId,
    required this.productId,
    required this.subDealer,
    required this.unitPrice,
    required this.totalHours,
    required this.orderQuantity,
  });

  final int? id;
  final int? orderId;
  final dynamic discount;
  final int? subtotal;
  final int? validity;
  final int? dealerId;
  final String? itemName;
  final int? vendorId;
  final int? productId;
  final int? subDealer;
  final int? unitPrice;
  final int? totalHours;
  final int? orderQuantity;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      orderId: json["orderId"],
      discount: json["discount"],
      subtotal: json["subtotal"],
      validity: json["validity"],
      dealerId: json["dealer_id"],
      itemName: json["item_name"],
      vendorId: json["vendor_id"],
      productId: json["product_id"],
      subDealer: json["sub_dealer"],
      unitPrice: json["unit_price"],
      totalHours: json["total_hours"],
      orderQuantity: json["order_quantity"],
    );
  }
}
