class VerifyPaymentAndUpdateWalletResModel {
  VerifyPaymentAndUpdateWalletResModel({
    required this.balance,
  });

  final Balance? balance;

  factory VerifyPaymentAndUpdateWalletResModel.fromJson(
      Map<String, dynamic> json) {
    return VerifyPaymentAndUpdateWalletResModel(
      balance:
          json["balance"] == null ? null : Balance.fromJson(json["balance"]),
    );
  }
}

class Balance {
  Balance({
    required this.id,
    required this.userId,
    required this.externalId,
    required this.totalBalance,
    required this.totalBookBalance,
    required this.transactionType,
    required this.transactionPin,
    required this.transactionId,
    required this.reference,
    required this.isAdminWalletBalance,
    required this.isAdvertiserWalletBalance,
    required this.isMnmShopWalletBalance,
    required this.isMnmAgentWalletBalance,
    required this.isMnmCustomerWalletBalance,
    required this.isAtmophereStorefrontWalletBalance,
    required this.isAgentWalletBalance,
    required this.isMnmLogisticsWalletBalance,
    required this.isAgencyWalletBalance,
    required this.isDealerWalletBalance,
    required this.createdAt,
    required this.updatedAt,
    required this.accountType,
  });

  final int? id;
  final int? userId;
  final dynamic externalId;
  final String? totalBalance;
  final String? totalBookBalance;
  final String? transactionType;
  final dynamic transactionPin;
  final int? transactionId;
  final String? reference;
  final String? isAdminWalletBalance;
  final String? isAdvertiserWalletBalance;
  final String? isMnmShopWalletBalance;
  final String? isMnmAgentWalletBalance;
  final String? isMnmCustomerWalletBalance;
  final String? isAtmophereStorefrontWalletBalance;
  final String? isAgentWalletBalance;
  final String? isMnmLogisticsWalletBalance;
  final String? isAgencyWalletBalance;
  final String? isDealerWalletBalance;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic accountType;

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      id: json["id"],
      userId: json["userId"],
      externalId: json["externalId"],
      totalBalance: json["total_balance"],
      totalBookBalance: json["total_book_balance"],
      transactionType: json["transaction_type"],
      transactionPin: json["transaction_pin"],
      transactionId: json["transaction_id"],
      reference: json["reference"],
      isAdminWalletBalance: json["is_admin_wallet_balance"],
      isAdvertiserWalletBalance: json["is_advertiser_wallet_balance"],
      isMnmShopWalletBalance: json["is_mnm_shop_wallet_balance"],
      isMnmAgentWalletBalance: json["is_mnm_agent_wallet_balance"],
      isMnmCustomerWalletBalance: json["is_mnm_customer_wallet_balance"],
      isAtmophereStorefrontWalletBalance:
          json["is_atmophere_storefront_wallet_balance"],
      isAgentWalletBalance: json["is_agent_wallet_balance"],
      isMnmLogisticsWalletBalance: json["is_mnm_logistics_wallet_balance"],
      isAgencyWalletBalance: json["is_agency_wallet_balance"],
      isDealerWalletBalance: json["is_dealer_wallet_balance"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      accountType: json["accountType"],
    );
  }
}
