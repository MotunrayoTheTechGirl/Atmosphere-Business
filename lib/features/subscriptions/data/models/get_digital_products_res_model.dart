class DigitalProductsResModel {
  DigitalProductsResModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.productType,
    required this.price,
    required this.vendorId,
    required this.hours,
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
    required this.createdAt,
    required this.updatedAt,
    this.isSelected = false,
  });

  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final String? productType;
  final double? price;
  final int? vendorId;
  final int? hours;
  final String? totalBandwidth;
  final int? totalValidity;
  final int? dealerId;
  final int? subDealerId;
  final double? salePrice;
  final String? sku;
  final bool? isTaxable;
  final String? status;
  final String? image;
  final DateTime? deletedAt;
  final bool? isDeleted;
  final bool? isDisable;
  final int? bukketId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  bool isSelected;

  factory DigitalProductsResModel.fromJson(Map<String, dynamic> json) {
    return DigitalProductsResModel(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      description: json["description"],
      productType: json["product_type"],
      price: json["price"] != null ? (json["price"] as num).toDouble() : null,
      vendorId: json["vendor_id"],
      hours: json["hours"],
      totalBandwidth: json["total_bandwidth"],
      totalValidity: json["total_validity"],
      dealerId: json["dealer_id"],
      subDealerId: json["sub_dealer_id"],
      salePrice: json["sale_price"] != null
          ? (json["sale_price"] as num).toDouble()
          : null,
      sku: json["sku"],
      isTaxable: json["is_taxable"],
      status: json["status"],
      image: json["image"],
      deletedAt: DateTime.tryParse(json["deleted_at"] ?? ""),
      isDeleted: json["is_deleted"],
      isDisable: json["is_disable"],
      bukketId: json["bukket_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "product_type": productType,
        "price": price,
        "vendor_id": vendorId,
        "hours": hours,
        "total_bandwidth": totalBandwidth,
        "total_validity": totalValidity,
        "dealer_id": dealerId,
        "sub_dealer_id": subDealerId,
        "sale_price": salePrice,
        "sku": sku,
        "is_taxable": isTaxable,
        "status": status,
        "image": image,
        "deleted_at": deletedAt?.toIso8601String(),
        "is_deleted": isDeleted,
        "is_disable": isDisable,
        "bukket_id": bukketId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  DigitalProductsResModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    String? productType,
    double? price,
    int? vendorId,
    int? hours,
    String? totalBandwidth,
    int? totalValidity,
    int? dealerId,
    int? subDealerId,
    double? salePrice,
    String? sku,
    bool? isTaxable,
    String? status,
    String? image,
    DateTime? deletedAt,
    bool? isDeleted,
    bool? isDisable,
    int? bukketId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSelected,
  }) {
    return DigitalProductsResModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      productType: productType ?? this.productType,
      price: price ?? this.price,
      vendorId: vendorId ?? this.vendorId,
      hours: hours ?? this.hours,
      totalBandwidth: totalBandwidth ?? this.totalBandwidth,
      totalValidity: totalValidity ?? totalValidity,
      dealerId: dealerId ?? this.dealerId,
      subDealerId: subDealerId ?? this.subDealerId,
      salePrice: salePrice ?? this.salePrice,
      sku: sku ?? this.sku,
      isTaxable: this.isTaxable,
      status: status ?? this.status,
      image: image ?? this.image,
      deletedAt: deletedAt ?? deletedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      isDisable: isDisable ?? isDisable,
      bukketId: bukketId ?? this.bukketId,
      createdAt: this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
