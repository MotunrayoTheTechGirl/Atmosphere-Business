class GeneratePaystackLinResModel {
  GeneratePaystackLinResModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory GeneratePaystackLinResModel.fromJson(Map<String, dynamic> json) {
    return GeneratePaystackLinResModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.authorizationUrl,
    required this.accessCode,
    required this.reference,
  });

  final String? authorizationUrl;
  final String? accessCode;
  final String? reference;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      authorizationUrl: json["authorization_url"],
      accessCode: json["access_code"],
      reference: json["reference"],
    );
  }
}
