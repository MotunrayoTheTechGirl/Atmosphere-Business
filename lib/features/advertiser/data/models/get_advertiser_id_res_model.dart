class GetAdvertiserIdResModel {
  GetAdvertiserIdResModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  final String? status;
  final int? code;
  final String? message;
  final Data? data;

  factory GetAdvertiserIdResModel.fromJson(Map<String, dynamic> json) {
    return GetAdvertiserIdResModel(
      status: json["status"],
      code: json["code"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.id,
    required this.businessName,
    required this.email,
    required this.name,
    required this.userId,
  });

  final String? id;
  final String? businessName;
  final String? email;
  final String? name;
  final int? userId;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      businessName: json["business_name"],
      email: json["email"],
      name: json["name"],
      userId: json["user_id"],
    );
  }
}
