class CaptiveDigitalPrdResModel {
  CaptiveDigitalPrdResModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  final String? status;
  final int? code;
  final String? message;
  final List<Datum> data;

  factory CaptiveDigitalPrdResModel.fromJson(Map<String, dynamic> json) {
    return CaptiveDigitalPrdResModel(
      status: json["status"],
      code: json["code"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
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
  // final int? salePrice;
  final num? salePrice;
  final String? sku;
  final bool? isTaxable;
  final String? status;
  final String? image;
  final DateTime? deletedAt;
  final bool? isDeleted;
  final bool? isDisable;
  final int? bukketId;
  final bool? isCustomer;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
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
      deletedAt: DateTime.tryParse(json["deleted_at"] ?? ""),
      isDeleted: json["is_deleted"],
      isDisable: json["is_disable"],
      bukketId: json["bukket_id"],
      isCustomer: json["is_customer"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
