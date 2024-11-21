class MonifyResModel {
  MonifyResModel({
    required this.requestSuccessful,
    required this.responseMessage,
    required this.responseCode,
    required this.responseBody,
  });

  final bool? requestSuccessful;
  final String? responseMessage;
  final String? responseCode;
  final ResponseBody? responseBody;

  factory MonifyResModel.fromJson(Map<String, dynamic> json) {
    return MonifyResModel(
      requestSuccessful: json["requestSuccessful"],
      responseMessage: json["responseMessage"],
      responseCode: json["responseCode"],
      responseBody: json["responseBody"] == null
          ? null
          : ResponseBody.fromJson(json["responseBody"]),
    );
  }
}

class ResponseBody {
  ResponseBody({
    required this.transactionReference,
    required this.paymentReference,
    required this.merchantName,
    required this.apiKey,
    required this.redirectUrl,
    required this.enabledPaymentMethod,
    required this.checkoutUrl,
  });

  final String? transactionReference;
  final String? paymentReference;
  final String? merchantName;
  final String? apiKey;
  final String? redirectUrl;
  final List<String> enabledPaymentMethod;
  final String? checkoutUrl;

  factory ResponseBody.fromJson(Map<String, dynamic> json) {
    return ResponseBody(
      transactionReference: json["transactionReference"],
      paymentReference: json["paymentReference"],
      merchantName: json["merchantName"],
      apiKey: json["apiKey"],
      redirectUrl: json["redirectUrl"],
      enabledPaymentMethod: json["enabledPaymentMethod"] == null
          ? []
          : List<String>.from(json["enabledPaymentMethod"]!.map((x) => x)),
      checkoutUrl: json["checkoutUrl"],
    );
  }
}
