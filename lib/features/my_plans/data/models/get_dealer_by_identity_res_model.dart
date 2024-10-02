class GetDealerByIdentityResModel {
  GetDealerByIdentityResModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  final String? status;
  final int? code;
  final String? message;
  final Data? data;

  factory GetDealerByIdentityResModel.fromJson(Map<String, dynamic> json) {
    return GetDealerByIdentityResModel(
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
    required this.invitedBy,
    required this.dealerAuthId,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.userType,
    required this.businessName,
    required this.cacNumber,
    required this.cacCertUrl,
    required this.taxIdNumber,
    required this.mmatCertUrl,
    required this.scumlCertUrl,
    required this.isSubDealer,
    required this.dateOfIncorporation,
    required this.businessAddress,
    required this.businessCategory,
    required this.allocatedData,
    required this.allocatedHours,
    required this.businessEmail,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? invitedBy;
  final int? dealerAuthId;
  final String? email;
  final String? name;
  final String? phoneNumber;
  final String? userType;
  final dynamic businessName;
  final dynamic cacNumber;
  final dynamic cacCertUrl;
  final dynamic taxIdNumber;
  final dynamic mmatCertUrl;
  final dynamic scumlCertUrl;
  final bool? isSubDealer;
  final dynamic dateOfIncorporation;
  final dynamic businessAddress;
  final dynamic businessCategory;
  final String? allocatedData;
  final int? allocatedHours;
  final dynamic businessEmail;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      invitedBy: json["invitedBy"],
      dealerAuthId: json["dealerAuthId"],
      email: json["email"],
      name: json["name"],
      phoneNumber: json["phoneNumber"],
      userType: json["userType"],
      businessName: json["businessName"],
      cacNumber: json["cacNumber"],
      cacCertUrl: json["cacCertURL"],
      taxIdNumber: json["taxIdNumber"],
      mmatCertUrl: json["mmatCertURL"],
      scumlCertUrl: json["scumlCertURL"],
      isSubDealer: json["is_sub_dealer"],
      dateOfIncorporation: json["dateOfIncorporation"],
      businessAddress: json["businessAddress"],
      businessCategory: json["businessCategory"],
      allocatedData: json["allocated_data"],
      allocatedHours: json["allocated_hours"],
      businessEmail: json["businessEmail"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}
