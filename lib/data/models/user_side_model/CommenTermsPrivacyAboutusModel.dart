/// termsId : "66fcd8d01ded33c778d1da00"
/// title : "Terms Condition"
/// description : "Terms and conditions are a legal agreement between a service provider and a user that outlines the rules and expectations for using a service or product. They are also known as terms of service, terms of use, end-user license agreement, general conditions, or legal notes"
/// terms_condition_status : "0"

class CommenTermsPrivacyAboutusModel {
  CommenTermsPrivacyAboutusModel({
      String? termsId, 
      String? title, 
      String? description, 
      String? termsConditionStatus,}){
    _termsId = termsId;
    _title = title;
    _description = description;
    _termsConditionStatus = termsConditionStatus;
}

  CommenTermsPrivacyAboutusModel.fromJson(dynamic json) {
    _termsId = json['termsId'];
    _title = json['title'];
    _description = json['description'];
    _termsConditionStatus = json['terms_condition_status'];
  }
  String? _termsId;
  String? _title;
  String? _description;
  String? _termsConditionStatus;
CommenTermsPrivacyAboutusModel copyWith({  String? termsId,
  String? title,
  String? description,
  String? termsConditionStatus,
}) => CommenTermsPrivacyAboutusModel(  termsId: termsId ?? _termsId,
  title: title ?? _title,
  description: description ?? _description,
  termsConditionStatus: termsConditionStatus ?? _termsConditionStatus,
);
  String? get termsId => _termsId;
  String? get title => _title;
  String? get description => _description;
  String? get termsConditionStatus => _termsConditionStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['termsId'] = _termsId;
    map['title'] = _title;
    map['description'] = _description;
    map['terms_condition_status'] = _termsConditionStatus;
    return map;
  }

}