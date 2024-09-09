class LoginUserDetailsResModel {
  LoginUserDetailsResModel({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data? data;

  factory LoginUserDetailsResModel.fromJson(Map<String, dynamic> json) {
    return LoginUserDetailsResModel(
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.nonce,
    required this.currentLoginApp,
    required this.user,
  });

  final String? nonce;
  final String? currentLoginApp;
  final User? user;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      nonce: json["nonce"],
      currentLoginApp: json["current_login_app"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }
}

class User {
  User({
    required this.id,
    required this.signupRegionId,
    required this.deviceId,
    required this.deviceToken,
    required this.deviceType,
    required this.humanRedableUserId,
    required this.isBusiness,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.businessName,
    required this.email,
    required this.emailVerified,
    required this.countryCode,
    required this.stateId,
    required this.phoneNumber,
    required this.otherPhoneNumber,
    required this.otherNames,
    required this.phoneNumberPrefix,
    required this.phoneVerified,
    required this.phoneVerifyToken,
    required this.apiToken,
    required this.apiTokenExpireAt,
    required this.userType,
    required this.defaultPaymentMethod,
    required this.isBlocked,
    required this.rememberToken,
    required this.androidToken,
    required this.iosToken,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.verificationType,
    required this.verificationCode,
    required this.verified,
    required this.countryId,
    required this.loyaltyPoint,
    required this.isPhoneVerified,
    required this.emailVerifiedAt,
    required this.cmFirebaseToken,
    required this.status,
    required this.orderCount,
    required this.loginMedium,
    required this.socialId,
    required this.zoneId,
    required this.transactionPin,
    required this.imageUrl,
    required this.refCode,
    required this.lastLoggedIn,
    required this.deleted,
    required this.driverId,
    required this.shopId,
    required this.systemSource,
    required this.lastActiveAt,
    required this.uniqueId,
    required this.referralId,
    required this.gender,
    required this.occupation,
    required this.twoFactor,
    required this.fcmToken,
    required this.isActive,
    required this.identificationType,
    required this.identificationNumber,
    required this.identificationImage,
    required this.identificationImages,
    required this.isKycVerified,
    required this.loginHitCount,
    required this.isTempBlocked,
    required this.voucher,
    required this.appSource,
    required this.tempBlockTime,
    required this.walletId,
    required this.middleName,
    required this.roleId,
    required this.isPasswordTemporary,
  });

  final int? id;
  final dynamic signupRegionId;
  final dynamic deviceId;
  final dynamic deviceToken;
  final dynamic deviceType;
  final dynamic humanRedableUserId;
  final bool? isBusiness;
  final dynamic name;
  final String? firstName;
  final String? lastName;
  final dynamic businessName;
  final String? email;
  final bool? emailVerified;
  final dynamic countryCode;
  final dynamic stateId;
  final String? phoneNumber;
  final dynamic otherPhoneNumber;
  final dynamic otherNames;
  final dynamic phoneNumberPrefix;
  final bool? phoneVerified;
  final dynamic phoneVerifyToken;
  final dynamic apiToken;
  final dynamic apiTokenExpireAt;
  final String? userType;
  final dynamic defaultPaymentMethod;
  final bool? isBlocked;
  final dynamic rememberToken;
  final dynamic androidToken;
  final dynamic iosToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic verificationType;
  final dynamic verificationCode;
  final bool? verified;
  final dynamic countryId;
  final dynamic loyaltyPoint;
  final bool? isPhoneVerified;
  final dynamic emailVerifiedAt;
  final dynamic cmFirebaseToken;
  final bool? status;
  final int? orderCount;
  final dynamic loginMedium;
  final dynamic socialId;
  final dynamic zoneId;
  final dynamic transactionPin;
  final dynamic imageUrl;
  final dynamic refCode;
  final DateTime? lastLoggedIn;
  final bool? deleted;
  final dynamic driverId;
  final dynamic shopId;
  final String? systemSource;
  final DateTime? lastActiveAt;
  final dynamic uniqueId;
  final dynamic referralId;
  final dynamic gender;
  final dynamic occupation;
  final bool? twoFactor;
  final dynamic fcmToken;
  final bool? isActive;
  final String? identificationType;
  final dynamic identificationNumber;
  final dynamic identificationImage;
  final dynamic identificationImages;
  final dynamic isKycVerified;
  final int? loginHitCount;
  final bool? isTempBlocked;
  final String? voucher;
  final dynamic appSource;
  final dynamic tempBlockTime;
  final dynamic walletId;
  final dynamic middleName;
  final int? roleId;
  final bool? isPasswordTemporary;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      signupRegionId: json["signup_region_id"],
      deviceId: json["device_id"],
      deviceToken: json["device_token"],
      deviceType: json["device_type"],
      humanRedableUserId: json["human_redable_user_id"],
      isBusiness: json["is_business"],
      name: json["name"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      businessName: json["business_name"],
      email: json["email"],
      emailVerified: json["email_verified"],
      countryCode: json["country_code"],
      stateId: json["state_id"],
      phoneNumber: json["phone_number"],
      otherPhoneNumber: json["other_phone_number"],
      otherNames: json["other_names"],
      phoneNumberPrefix: json["phone_number_prefix"],
      phoneVerified: json["phone_verified"],
      phoneVerifyToken: json["phone_verify_token"],
      apiToken: json["api_token"],
      apiTokenExpireAt: json["api_token_expire_at"],
      userType: json["user_type"],
      defaultPaymentMethod: json["default_payment_method"],
      isBlocked: json["is_blocked"],
      rememberToken: json["remember_token"],
      androidToken: json["android_token"],
      iosToken: json["ios_token"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      verificationType: json["verification_type"],
      verificationCode: json["verification_code"],
      verified: json["verified"],
      countryId: json["country_id"],
      loyaltyPoint: json["loyalty_point"],
      isPhoneVerified: json["is_phone_verified"],
      emailVerifiedAt: json["email_verified_at"],
      cmFirebaseToken: json["cm_firebase_token"],
      status: json["status"],
      orderCount: json["order_count"],
      loginMedium: json["login_medium"],
      socialId: json["social_id"],
      zoneId: json["zone_id"],
      transactionPin: json["transaction_pin"],
      imageUrl: json["image_url"],
      refCode: json["ref_code"],
      lastLoggedIn: DateTime.tryParse(json["last_logged_in"] ?? ""),
      deleted: json["deleted"],
      driverId: json["driverId"],
      shopId: json["shopId"],
      systemSource: json["system_source"],
      lastActiveAt: DateTime.tryParse(json["last_active_at"] ?? ""),
      uniqueId: json["unique_id"],
      referralId: json["referral_id"],
      gender: json["gender"],
      occupation: json["occupation"],
      twoFactor: json["two_factor"],
      fcmToken: json["fcm_token"],
      isActive: json["is_active"],
      identificationType: json["identification_type"],
      identificationNumber: json["identification_number"],
      identificationImage: json["identification_image"],
      identificationImages: json["identification_images"],
      isKycVerified: json["is_kyc_verified"],
      loginHitCount: json["login_hit_count"],
      isTempBlocked: json["is_temp_blocked"],
      voucher: json["voucher"],
      appSource: json["app_source"],
      tempBlockTime: json["temp_block_time"],
      walletId: json["wallet_id"],
      middleName: json["middle_name"],
      roleId: json["roleId"],
      isPasswordTemporary: json["is_password_temporary"],
    );
  }
}
