class UserProfileModel {
  final String id;
  final String countryCode;
  final String mobileNo;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String roleType;
  final String userStatus;
  final String userActiveStatus;
  final double walletAmount;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfileModel({
    required this.id,
    required this.countryCode,
    required this.mobileNo,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.roleType,
    required this.userStatus,
    required this.userActiveStatus,
    required this.walletAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an instance from JSON
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json["_id"] ?? "",
      countryCode: json["country_code"] ?? "",
      mobileNo: json["mobile_no"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      roleType: json["role_type"] ?? "",
      userStatus: json["user_status"] ?? "",
      userActiveStatus: json["user_active_status"] ?? "",
      walletAmount: (json["wallet_ammount"] ?? 0).toDouble(),
      createdAt: DateTime.parse(json["createdAt"] ?? ""),
      updatedAt: DateTime.parse(json["updatedAt"] ?? ""),
    );
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "country_code": countryCode,
      "mobile_no": mobileNo,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "role_type": roleType,
      "user_status": userStatus,
      "user_active_status": userActiveStatus,
      "wallet_ammount": walletAmount,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}
