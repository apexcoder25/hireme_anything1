/// userId : "66fce95ef96b51f7afced88f"
/// country_code : "91"
/// mobile_no : "6232495566"
/// role_type : "user"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmZjZTk1ZWY5NmI1MWY3YWZjZWQ4OGYiLCJtb2JpbGVfbm8iOiI2MjMyNDk1NTY2IiwiaWF0IjoxNzI3ODUyNzEzLCJleHAiOjE3Mjc4NTYzMTN9.I7jsGWzCEGZq2RuN1UyqBQ8gYgeYnc60z-vUwhHxKvQ"
/// name : ""
/// email : ""




class UserSideDetailsModel {
  UserSideDetailsModel({
      String? userId, 
      String? countryCode, 
      String? mobileNo, 
      String? roleType, 
      String? token, 
      String? name, 
      String? email,
      String? otp,
  }){
    _userId = userId;
    _countryCode = countryCode;
    _mobileNo = mobileNo;
    _roleType = roleType;
    _token = token;
    _name = name;
    _email = email;
    _otp = otp;
}

  UserSideDetailsModel.fromJson(dynamic json) {
    _userId = json['userId'];
    _countryCode = json['country_code'];
    _mobileNo = json['mobile_no'];
    _roleType = json['role_type'];
    _token = json['token'];
    _name = json['name'];
    _email = json['email'];
    _otp = json['otp'];
  }
  String? _userId;
  String? _countryCode;
  String? _mobileNo;
  String? _roleType;
  String? _token;
  String? _name;
  String? _email;
  String? _otp;
UserSideDetailsModel copyWith({  String? userId,
  String? countryCode,
  String? mobileNo,
  String? roleType,
  String? token,
  String? name,
  String? email,
  String? otp,
}) => UserSideDetailsModel(  userId: userId ?? _userId,
  countryCode: countryCode ?? _countryCode,
  mobileNo: mobileNo ?? _mobileNo,
  roleType: roleType ?? _roleType,
  token: token ?? _token,
  name: name ?? _name,
  email: email ?? _email,
  otp: otp ?? _otp,
);
  String? get userId => _userId;
  String? get countryCode => _countryCode;
  String? get mobileNo => _mobileNo;
  String? get roleType => _roleType;
  String? get token => _token;
  String? get name => _name;
  String? get email => _email;
  String? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['country_code'] = _countryCode;
    map['mobile_no'] = _mobileNo;
    map['role_type'] = _roleType;
    map['token'] = _token;
    map['name'] = _name;
    map['email'] = _email;
    map['otp'] = _otp;
    return map;
  }

}