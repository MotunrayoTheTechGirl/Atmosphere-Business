class MetricOverviewResModel {
  MetricOverviewResModel({
    required this.period,
    required this.reachCount,
    required this.reachPercentage,
    required this.impressionCount,
    required this.impressionPercentage,
    required this.viewCount,
    required this.viewPercentage,
    required this.clickCount,
    required this.clickPercentage,
    required this.visitCount,
    required this.visitPercentage,
  });

  final String? period;
  final int? reachCount;
  final int? reachPercentage;
  final int? impressionCount;
  final int? impressionPercentage;
  final int? viewCount;
  final int? viewPercentage;
  final int? clickCount;
  final int? clickPercentage;
  final int? visitCount;
  final int? visitPercentage;

  factory MetricOverviewResModel.fromJson(Map<String, dynamic> json) {
    return MetricOverviewResModel(
      period: json["period"],
      reachCount: json["reachCount"],
      reachPercentage: json["reachPercentage"],
      impressionCount: json["impressionCount"],
      impressionPercentage: json["impressionPercentage"],
      viewCount: json["viewCount"],
      viewPercentage: json["viewPercentage"],
      clickCount: json["clickCount"],
      clickPercentage: json["clickPercentage"],
      visitCount: json["visitCount"],
      visitPercentage: json["visitPercentage"],
    );
  }
}
