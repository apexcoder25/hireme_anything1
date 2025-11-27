class CompanyInfoModel {
  final String? id;
  final String? vendorId;
  final String companyName;
  final String tradingName;
  final String companyRegNo;
  final String address;
  final String postcode;
  final String contactName;
  final String phone;
  final String email;
  final String? createdAt;
  final String? updatedAt;

  CompanyInfoModel({
    this.id,
    this.vendorId,
    required this.companyName,
    required this.tradingName,
    required this.companyRegNo,
    required this.address,
    required this.postcode,
    required this.contactName,
    required this.phone,
    required this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory CompanyInfoModel.fromJson(Map<String, dynamic> json) {
    return CompanyInfoModel(
      id: json['_id'] as String?,
      vendorId: json['vendorId'] as String?,
      companyName: json['companyName'] as String? ?? '',
      tradingName: json['tradingName'] as String? ?? '',
      companyRegNo: json['companyRegNo'] as String? ?? '',
      address: json['address'] as String? ?? '',
      postcode: json['postcode'] as String? ?? '',
      contactName: json['contactName'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'tradingName': tradingName,
      'companyRegNo': companyRegNo,
      'address': address,
      'postcode': postcode,
      'contactName': contactName,
      'phone': phone,
      'email': email,
    };
  }

  CompanyInfoModel copyWith({
    String? id,
    String? vendorId,
    String? companyName,
    String? tradingName,
    String? companyRegNo,
    String? address,
    String? postcode,
    String? contactName,
    String? phone,
    String? email,
    String? createdAt,
    String? updatedAt,
  }) {
    return CompanyInfoModel(
      id: id ?? this.id,
      vendorId: vendorId ?? this.vendorId,
      companyName: companyName ?? this.companyName,
      tradingName: tradingName ?? this.tradingName,
      companyRegNo: companyRegNo ?? this.companyRegNo,
      address: address ?? this.address,
      postcode: postcode ?? this.postcode,
      contactName: contactName ?? this.contactName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
