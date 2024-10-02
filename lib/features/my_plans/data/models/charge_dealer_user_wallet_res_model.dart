class ChargeDealerUserWalletResModel {
    ChargeDealerUserWalletResModel({
        required this.statusCode,
        required this.message,
    });

    final int? statusCode;
    final String? message;

    factory ChargeDealerUserWalletResModel.fromJson(Map<String, dynamic> json){ 
        return ChargeDealerUserWalletResModel(
            statusCode: json["statusCode"],
            message: json["message"],
        );
    }

}
