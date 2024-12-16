import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/metric_overview_res_model.dart';

final metricOverviewRepositoryProvider = Provider(
  (ref) => MetricOverviewRepository(),
);

class MetricOverviewRepository {
  final api = DealerPoratlApi();
  Future<MetricOverviewResModel> metricOverview({
    required String period,
    required num advertiserId,
  }) async {
    log('--get metrics--');
    try {
      final response = await api.get(
        ApiEndpoints.metricOverView,
        queryParameters: {
          "period": period,
          "advertiserId": advertiserId,
        },
      );
      log('--metric overview: $response');

      // Handle different response types
      dynamic data;
      if (response?.data is String) {
        data = jsonDecode(response?.data);
      } else if (response?.data is List) {
        // If it's a list, take the first item (assuming the list contains the object)
        data = (response?.data as List).isNotEmpty
            ? (response?.data as List).first
            : {};
      } else {
        data = response?.data;
      }

      log('--processed data: $data');
      return MetricOverviewResModel.fromJson(data);
    } catch (e) {
      log('--metric overview Exception error: $e');
      rethrow;
    }
  }
}

// class MetricOverviewRepository {
//   final api = DealerPoratlApi();

//   Future<MetricOverviewResModel> metricOverview({
//     required String period,
//     required num advertiserId,
//   }) async {
//     log('--get metrics--');
//     try {
//       final response = await api.get(
//         ApiEndpoints.metricOverView,
//         queryParameters: {
//           "period": period,
//           "advertiserId": advertiserId,
//         },
//       );
//       log('--metric overview: $response');
//       if (response?.data is String) {
//         log('--metric overview response is String');
//         return MetricOverviewResModel.fromJson(jsonDecode(response?.data));
//       } else {
//         log('--metric overview response is NOT String');
//         return MetricOverviewResModel.fromJson(response?.data);
//       }
//     } catch (e) {
//       log('--metric overview Exception error: $e');
//       rethrow;
//     }
//   }
// }
