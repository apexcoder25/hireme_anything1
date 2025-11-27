class AccountDetailsModel {
  final String id;
  final String vendorId;
  final String bankName;
  final String accountNumber;
  final String ifscCode;
  final String ibanNumber;
  final String bankAccountHolderName;
  final String swiftCode;
  final String paypalId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  AccountDetailsModel({
    required this.id,
    required this.vendorId,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.ibanNumber,
    required this.bankAccountHolderName,
    required this.swiftCode,
    this.paypalId = '',
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory AccountDetailsModel.fromJson(Map<String, dynamic> json) {
    return AccountDetailsModel(
      id: json['_id'] ?? '',
      vendorId: json['vendorId'] ?? '',
      bankName: json['bankName'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      ifscCode: json['ifscCode'] ?? '',
      ibanNumber: json['ibanNumber'] ?? '',
      bankAccountHolderName: json['bankAccountHolderName'] ?? '',
      swiftCode: json['swiftCode'] ?? '',
      paypalId: json['paypalId'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountNumber': accountNumber,
      'bankName': bankName,
      'ifscCode': ifscCode,
      'ibanNumber': ibanNumber,
      'bankAccountHolderName': bankAccountHolderName,
      'swiftCode': swiftCode,
      'paypalId': paypalId,
    };
  }
}