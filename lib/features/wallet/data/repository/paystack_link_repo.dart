import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/monify_res_model.dart';
import '../models/paystack_link_res_model.dart';

final generatePaystackLinkRepositoryProvider = Provider(
  (ref) => GeneratePaystackLinkRepository(),
);

// class GeneratePaystackLinkRepository {
//   final api = DealerPoratlApi();

//   Future<GeneratePaystackLinResModel> paystackLink({
//     required String identity,
//     required num amount,
//     required String reference,
//     required String paymentMethod,
//   }) async {
//     try {
//       final response = await api.post(
//         ApiEndpoints.generatePaystackPayment,
//         body: {
//           "identity": identity,
//           "amount": amount,
//           "reference": reference,
//           "redirectUrl": "https://wifi.atmosphere.net.ng/wallet",
//           "paymentMethod": paymentMethod,
//         },
//       );

//       if (response?.data is String) {
//         return GeneratePaystackLinResModel.fromJson(jsonDecode(response?.data));
//       } else {
//         return GeneratePaystackLinResModel.fromJson(response?.data);
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

class GeneratePaystackLinkRepository {
  final api = DealerPoratlApi();

  Future<dynamic> paystackLink({
    required String identity,
    required num amount,
    required String reference,
    // required String paymentMethod,
    required bool isPaystack,
  }) async {
    try {
      final response = await api.post(
        ApiEndpoints.generatePaystackPayment,
        body: {
          "identity": identity,
          "amount": amount,
          "reference": reference,
          "redirectUrl": "https://wifi.atmosphere.net.ng/wallet",
          "paymentMethod": isPaystack ? "paystack" : "monify",
        },
      );

      if (isPaystack == true) {
        if (response?.data is String) {
          return GeneratePaystackLinResModel.fromJson(
              jsonDecode(response?.data));
        } else {
          return GeneratePaystackLinResModel.fromJson(response?.data);
        }
      } else if (isPaystack == false) {
        if (response?.data is String) {
          return MonifyResModel.fromJson(jsonDecode(response?.data));
        } else {
          return MonifyResModel.fromJson(response?.data);
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
