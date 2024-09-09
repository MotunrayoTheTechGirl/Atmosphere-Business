class InvoiceUrlResModel {
  InvoiceUrlResModel({
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
    required this.receiptUploaded,
    required this.invoiceReference,
    required this.dueDate,
    required this.items,
    required this.receiptApprovedByUserId,
    required this.receiptApprovedByUserFullName,
    required this.dateReceiptApproved,
    required this.dateReceiptConfirmed,
    required this.receiptConfirmedByUserId,
    required this.receiptConfirmedByUserFullName,
    required this.isApproved,
    required this.isConfirmedReceipt,
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
  final String? recieptfileUrl;
  final bool? receiptUploaded;
  final dynamic invoiceReference;
  final dynamic dueDate;
  final List<Item> items;
  final dynamic receiptApprovedByUserId;
  final dynamic receiptApprovedByUserFullName;
  final dynamic dateReceiptApproved;
  final dynamic dateReceiptConfirmed;
  final dynamic receiptConfirmedByUserId;
  final dynamic receiptConfirmedByUserFullName;
  final bool? isApproved;
  final bool? isConfirmedReceipt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory InvoiceUrlResModel.fromJson(Map<String, dynamic> json) {
    return InvoiceUrlResModel(
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
      receiptUploaded: json["receipt_uploaded"],
      invoiceReference: json["invoice_reference"],
      dueDate: json["due_date"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      receiptApprovedByUserId: json["receipt_approved_by_user_id"],
      receiptApprovedByUserFullName: json["receipt_approved_by_user_full_name"],
      dateReceiptApproved: json["date_receipt_approved"],
      dateReceiptConfirmed: json["date_receipt_confirmed"],
      receiptConfirmedByUserId: json["receipt_confirmed_by_user_id"],
      receiptConfirmedByUserFullName:
          json["receipt_confirmed_by_user_full_name"],
      isApproved: json["is_approved"],
      isConfirmedReceipt: json["is_confirmed_receipt"],
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
    required this.createdAt,
    required this.dealerId,
    required this.itemName,
    required this.updatedAt,
    required this.vendorId,
    required this.productId,
    required this.subDealer,
    required this.unitPrice,
    required this.isCombined,
    required this.isConbined,
    required this.totalHours,
    required this.productType,
    required this.orderQuantity,
    required this.vendorPlanId,
    required this.totalBandwidth,
  });

  final int? id;
  final int? orderId;
  final dynamic discount;
  final int? subtotal;
  final int? validity;
  final DateTime? createdAt;
  final int? dealerId;
  final String? itemName;
  final DateTime? updatedAt;
  final int? vendorId;
  final int? productId;
  final int? subDealer;
  final int? unitPrice;
  final bool? isCombined;
  final bool? isConbined;
  final int? totalHours;
  final String? productType;
  final int? orderQuantity;
  final dynamic vendorPlanId;
  final dynamic totalBandwidth;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      orderId: json["orderId"],
      discount: json["discount"],
      subtotal: json["subtotal"],
      validity: json["validity"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      dealerId: json["dealer_id"],
      itemName: json["item_name"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      vendorId: json["vendor_id"],
      productId: json["product_id"],
      subDealer: json["sub_dealer"],
      unitPrice: json["unit_price"],
      isCombined: json["is_combined"],
      isConbined: json["is_conbined"],
      totalHours: json["total_hours"],
      productType: json["product_type"],
      orderQuantity: json["order_quantity"],
      vendorPlanId: json["vendor_plan_id"],
      totalBandwidth: json["total_bandwidth"],
    );
  }
}
