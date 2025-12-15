class ProfileModel {
  String id;
  String name;
  String email;
  String mobileNo;
  String countryCode;
  String companyName;
  String streetName;
  String cityName;
  String countryName;
  String pincode;
  String gender;
  String description;
  String vendorImage;
  List<Map<String, String>> legalDocuments;
  List<String> vehicleImages;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.countryCode,
    required this.companyName,
    required this.streetName,
    required this.cityName,
    required this.countryName,
    required this.pincode,
    required this.gender,
    required this.description,
    required this.vendorImage,
    required this.legalDocuments,
    required this.vehicleImages,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json["_id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "Unknown",
      email: json["email"]?.toString() ?? "No Email",
      mobileNo: json["mobile_no"]?.toString() ?? "",
      countryCode: json["country_code"]?.toString() ?? "",
      companyName: json["company_name"]?.toString() ?? "No Company",
      streetName: json["street_name"]?.toString() ?? "No Street",
      cityName: json["city_name"]?.toString() ?? "No City",
      countryName: json["country_name"]?.toString() ?? "No Country",
      pincode: json["pincode"]?.toString() ?? "",
      gender: json["gender"]?.toString() ?? "Not Specified",
      description: json["description"]?.toString() ?? "",
      vendorImage: json["vendor_image"]?.toString() ?? "",
      legalDocuments: (json["legal_documents"] as List<dynamic>?)
              ?.map((doc) => {
                    'url': doc['url']?.toString() ?? '',
                    'fileName': doc['fileName']?.toString() ?? '',
                    'uploadedName': doc['uploadedName']?.toString() ?? '',
                  })
              .toList() ??
          [],
      vehicleImages: (json["vehicle_image"] as List<dynamic>?)
              ?.map((url) => url.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "mobile_no": mobileNo,
      "country_code": countryCode,
      "company_name": companyName,
      "street_name": streetName,
      "city_name": cityName,
      "country_name": countryName,
      "pincode": pincode,
      "gender": gender,
      "description": description,
      "vendor_image": vendorImage,
      "legal_documents": legalDocuments,
      "vehicle_image": vehicleImages,
    };
  }
}