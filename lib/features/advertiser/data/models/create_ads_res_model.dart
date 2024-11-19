class CreateAdsResModel {
  CreateAdsResModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  final String? status;
  final int? code;
  final String? message;
  final String? data;

  factory CreateAdsResModel.fromJson(Map<String, dynamic> json) {
    return CreateAdsResModel(
      status: json["status"],
      code: json["code"],
      message: json["message"],
      data: json["data"],
    );
  }
}
