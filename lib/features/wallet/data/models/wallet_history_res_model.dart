class WalletHistoryResModel {
  WalletHistoryResModel({
    required this.totalSize,
    required this.page,
    required this.pageSize,
    required this.data,
  });

  final int? totalSize;
  final int? page;
  final int? pageSize;
  final List<Datum> data;

  factory WalletHistoryResModel.fromJson(Map<String, dynamic> json) {
    return WalletHistoryResModel(
      totalSize: json["total_size"],
      page: json["page"],
      pageSize: json["pageSize"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.userId,
    required this.transactionId,
    required this.credit,
    required this.debit,
    required this.adminBonus,
    required this.balance,
    required this.transactionType,
    required this.reference,
    required this.createdAt,
    required this.note,
    required this.updatedAt,
    required this.accountType,
    required this.walletId,
    required this.referrerId,
    required this.isReferrer,
  });

  final int? id;
  final int? userId;
  final int? transactionId;
  final String? credit;
  final String? debit;
  final String? adminBonus;
  final String? balance;
  final String? transactionType;
  final String? reference;
  final DateTime? createdAt;
  final String? note;
  final DateTime? updatedAt;
  final String? accountType;
  final int? walletId;
  final dynamic referrerId;
  final bool? isReferrer;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      userId: json["userId"],
      transactionId: json["transaction_id"],
      credit: json["credit"],
      debit: json["debit"],
      adminBonus: json["admin_bonus"],
      balance: json["balance"],
      transactionType: json["transaction_type"],
      reference: json["reference"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      note: json["note"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      accountType: json["account_type"],
      walletId: json["walletId"],
      referrerId: json["referrerId"],
      isReferrer: json["is_referrer"],
    );
  }
}
