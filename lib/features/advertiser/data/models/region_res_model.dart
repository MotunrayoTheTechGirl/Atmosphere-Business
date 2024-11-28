class RegionResModel {
  RegionResModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  final String? status;
  final int? code;
  final String? message;
  final List<Datum> data;

  factory RegionResModel.fromJson(Map<String, dynamic> json) {
    return RegionResModel(
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
    required this.state,
    required this.lga,
    required this.area,
    required this.hotspotIdentifier,
    required this.additionalInfo,
    required this.coordinates,
  });

  final int? id;
  final String? state;
  final String? lga;
  final String? area;
  final dynamic hotspotIdentifier;
  final dynamic additionalInfo;
  final List<List<double>> coordinates;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      state: json["state"],
      lga: json["lga"],
      area: json["area"],
      hotspotIdentifier: json["hotspotIdentifier"],
      additionalInfo: json["additionalInfo"],
      coordinates: json["coordinates"] == null
          ? []
          : List<List<double>>.from(json["coordinates"]!.map(
              (x) => x == null ? [] : List<double>.from(x!.map((x) => x)))),
    );
  }
}
