// class ServiceImage {
//   final String path;
//   final DateTime uploadTime;
//   bool isUploaded;
//   String? uploadUrl;
//   String? thumbnail;

//   ServiceImage({
//     required this.path,
//     required this.uploadTime,
//     this.isUploaded = false,
//     this.uploadUrl,
//     this.thumbnail,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'path': path,
//       'uploadTime': uploadTime.toIso8601String(),
//       'isUploaded': isUploaded,
//       'uploadUrl': uploadUrl,
//       'thumbnail': thumbnail,
//     };
//   }

//   factory ServiceImage.fromJson(Map<String, dynamic> json) {
//     return ServiceImage(
//       path: json['path'],
//       uploadTime: DateTime.parse(json['uploadTime']),
//       isUploaded: json['isUploaded'],
//       uploadUrl: json['uploadUrl'],
//       thumbnail: json['thumbnail'],
//     );
//   }
// }
