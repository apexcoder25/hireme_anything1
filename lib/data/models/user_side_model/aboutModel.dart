class AboutModel {
  String? sId;
  String? aboutus;
  String? marketPlace;
  String? problem;
  String? solution;
  String? image;
  int? iV;

  AboutModel(
      {this.sId,
      this.aboutus,
      this.marketPlace,
      this.problem,
      this.solution,
      this.image,
      this.iV});

  AboutModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    aboutus = json['aboutus'];
    marketPlace = json['marketPlace'];
    problem = json['problem'];
    solution = json['solution'];
    image = json['image'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['aboutus'] = this.aboutus;
    data['marketPlace'] = this.marketPlace;
    data['problem'] = this.problem;
    data['solution'] = this.solution;
    data['image'] = this.image;
    data['__v'] = this.iV;
    return data;
  }
}
