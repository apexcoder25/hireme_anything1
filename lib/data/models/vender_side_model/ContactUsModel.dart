/// contactUsId : "67051ea0b69c0947a2f3ee48"
/// name : "admin"
/// phone_no : "0123456789"
/// whatsapp_no : "0123456789"
/// email : "admin@gmail.com"
/// contact_us_status : "0"

class ContactUsModel {
  ContactUsModel({
      String? contactUsId, 
      String? name, 
      String? phoneNo, 
      String? whatsappNo, 
      String? email, 
      String? contactUsStatus,}){
    _contactUsId = contactUsId;
    _name = name;
    _phoneNo = phoneNo;
    _whatsappNo = whatsappNo;
    _email = email;
    _contactUsStatus = contactUsStatus;
}

  ContactUsModel.fromJson(dynamic json) {
    _contactUsId = json['contactUsId'];
    _name = json['name'];
    _phoneNo = json['phone_no'];
    _whatsappNo = json['whatsapp_no'];
    _email = json['email'];
    _contactUsStatus = json['contact_us_status'];
  }
  String? _contactUsId;
  String? _name;
  String? _phoneNo;
  String? _whatsappNo;
  String? _email;
  String? _contactUsStatus;
ContactUsModel copyWith({  String? contactUsId,
  String? name,
  String? phoneNo,
  String? whatsappNo,
  String? email,
  String? contactUsStatus,
}) => ContactUsModel(  contactUsId: contactUsId ?? _contactUsId,
  name: name ?? _name,
  phoneNo: phoneNo ?? _phoneNo,
  whatsappNo: whatsappNo ?? _whatsappNo,
  email: email ?? _email,
  contactUsStatus: contactUsStatus ?? _contactUsStatus,
);
  String? get contactUsId => _contactUsId;
  String? get name => _name;
  String? get phoneNo => _phoneNo;
  String? get whatsappNo => _whatsappNo;
  String? get email => _email;
  String? get contactUsStatus => _contactUsStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['contactUsId'] = _contactUsId;
    map['name'] = _name;
    map['phone_no'] = _phoneNo;
    map['whatsapp_no'] = _whatsappNo;
    map['email'] = _email;
    map['contact_us_status'] = _contactUsStatus;
    return map;
  }

}