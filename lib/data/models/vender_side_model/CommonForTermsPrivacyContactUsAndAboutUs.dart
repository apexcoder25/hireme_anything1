/// aboutUsId : "66fcd7bd1ded33c778d1d9fe"
/// title : "About Us"
/// description : "A good About page shares your unique story and gives people a glimpse into what it'd be like working with you (as an individual or company). It should be equally fun and meaningful to resonate with the intended audience. You can document your journey of starting a business with visuals to make the page more appealing."
/// about_us_status : "0"

class CommonForTermsPrivacyContactUsAndAboutUs {
  CommonForTermsPrivacyContactUsAndAboutUs({
      String? aboutUsId, 
      String? title, 
      String? description, 
      String? aboutUsStatus,}){
    _aboutUsId = aboutUsId;
    _title = title;
    _description = description;
    _aboutUsStatus = aboutUsStatus;
}

  CommonForTermsPrivacyContactUsAndAboutUs.fromJson(dynamic json) {
    _aboutUsId = json['aboutUsId'];
    _title = json['title'];
    _description = json['description'];
    _aboutUsStatus = json['about_us_status'];
  }
  String? _aboutUsId;
  String? _title;
  String? _description;
  String? _aboutUsStatus;
CommonForTermsPrivacyContactUsAndAboutUs copyWith({  String? aboutUsId,
  String? title,
  String? description,
  String? aboutUsStatus,
}) => CommonForTermsPrivacyContactUsAndAboutUs(  aboutUsId: aboutUsId ?? _aboutUsId,
  title: title ?? _title,
  description: description ?? _description,
  aboutUsStatus: aboutUsStatus ?? _aboutUsStatus,
);
  String? get aboutUsId => _aboutUsId;
  String? get title => _title;
  String? get description => _description;
  String? get aboutUsStatus => _aboutUsStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aboutUsId'] = _aboutUsId;
    map['title'] = _title;
    map['description'] = _description;
    map['about_us_status'] = _aboutUsStatus;
    return map;
  }

}