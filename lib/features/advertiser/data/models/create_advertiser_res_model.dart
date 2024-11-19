class CreateAdvertiserResModel {
  CreateAdvertiserResModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  final String? status;
  final int? code;
  final String? message;
  final String? data;

  factory CreateAdvertiserResModel.fromJson(Map<String, dynamic> json) {
    return CreateAdvertiserResModel(
      status: json["status"],
      code: json["code"],
      message: json["message"],
      data: json["data"],
    );
  }
}
