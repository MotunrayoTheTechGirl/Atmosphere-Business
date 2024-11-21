class GetAdvertiserIdResModel {
  GetAdvertiserIdResModel({
    required this.id,
    required this.name,
    required this.businessName,
    required this.businessCategory,
    required this.businessAddress,
    required this.userId,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? businessName;
  final dynamic businessCategory;
  final dynamic businessAddress;
  final int? userId;
  final String? email;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GetAdvertiserIdResModel.fromJson(Map<String, dynamic> json) {
    return GetAdvertiserIdResModel(
      id: json["id"],
      name: json["name"],
      businessName: json["business_name"],
      businessCategory: json["business_category"],
      businessAddress: json["business_address"],
      userId: json["userId"],
      email: json["email"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
