class CreateDigitalProductResModel {
  CreateDigitalProductResModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.productType,
    required this.price,
    required this.vendorId,
    required this.hours,
    required this.isCombined,
    required this.vendorPlanId,
    required this.totalBandwidth,
    required this.totalValidity,
    required this.dealerId,
    required this.subDealerId,
    required this.salePrice,
    required this.sku,
    required this.isTaxable,
    required this.status,
    required this.image,
    required this.deletedAt,
    required this.isDeleted,
    required this.isDisable,
    required this.bukketId,
    required this.isCustomer,
    required this.isAutoCreated,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final String? productType;
  final int? price;
  final int? vendorId;
  final int? hours;
  final bool? isCombined;
  final String? vendorPlanId;
  final String? totalBandwidth;
  final int? totalValidity;
  final int? dealerId;
  final int? subDealerId;
  final int? salePrice;
  final String? sku;
  final bool? isTaxable;
  final String? status;
  final String? image;
  final dynamic deletedAt;
  final bool? isDeleted;
  final bool? isDisable;
  final int? bukketId;
  final bool? isCustomer;
  final bool? isAutoCreated;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CreateDigitalProductResModel.fromJson(Map<String, dynamic> json) {
    return CreateDigitalProductResModel(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      description: json["description"],
      productType: json["product_type"],
      price: json["price"],
      vendorId: json["vendor_id"],
      hours: json["hours"],
      isCombined: json["is_combined"],
      vendorPlanId: json["vendor_plan_id"],
      totalBandwidth: json["total_bandwidth"],
      totalValidity: json["total_validity"],
      dealerId: json["dealer_id"],
      subDealerId: json["sub_dealer_id"],
      salePrice: json["sale_price"],
      sku: json["sku"],
      isTaxable: json["is_taxable"],
      status: json["status"],
      image: json["image"],
      deletedAt: json["deleted_at"],
      isDeleted: json["is_deleted"],
      isDisable: json["is_disable"],
      bukketId: json["bukket_id"],
      isCustomer: json["is_customer"],
      isAutoCreated: json["is_auto_created"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
