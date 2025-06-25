/// faqId : "66ff9ea79980718d253abcac"
/// question : "What is Hire AnyThing"
/// answer : "Hi5re is a platform that allows users to hire anything they need, from equipment and tools to services, making renting easier and more convenient."
/// faq_status : "0"
class FaqModelsList {
  List<FaqModels> faqModelsList;
  FaqModelsList({required this.faqModelsList});
  factory FaqModelsList.fromJson(List<dynamic> parsedJson) {
    List<FaqModels> temp = <FaqModels>[];

    temp = parsedJson.map((e) => FaqModels.fromJson(e)).toList();
    return FaqModelsList(faqModelsList: temp);
  }
}

class FaqModels {
  FaqModels({
      String? faqId, 
      String? question, 
      String? answer, 
      String? faqStatus,}){
    _faqId = faqId;
    _question = question;
    _answer = answer;
    _faqStatus = faqStatus;
}

  FaqModels.fromJson(dynamic json) {
    _faqId = json['faqId'];
    _question = json['question'];
    _answer = json['answer'];
    _faqStatus = json['faq_status'];
  }
  String? _faqId;
  String? _question;
  String? _answer;
  String? _faqStatus;
FaqModels copyWith({  String? faqId,
  String? question,
  String? answer,
  String? faqStatus,
}) => FaqModels(  faqId: faqId ?? _faqId,
  question: question ?? _question,
  answer: answer ?? _answer,
  faqStatus: faqStatus ?? _faqStatus,
);
  String? get faqId => _faqId;
  String? get question => _question;
  String? get answer => _answer;
  String? get faqStatus => _faqStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['faqId'] = _faqId;
    map['question'] = _question;
    map['answer'] = _answer;
    map['faq_status'] = _faqStatus;
    return map;
  }

}