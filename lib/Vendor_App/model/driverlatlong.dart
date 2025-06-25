// class DriverLiveLatLongModel {
//   String? result;
//   String? message;
//   Data? data;

//   DriverLiveLatLongModel({this.result, this.message, this.data});

//   DriverLiveLatLongModel.fromJson(Map<String, dynamic> json) {
//     result = json['result'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['result'] = this.result;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   String? driverId;
//   String? driverName;
//   Location? location;

//   Data({this.driverId, this.driverName, this.location});

//   Data.fromJson(Map<String, dynamic> json) {
//     driverId = json['driverId'];
//     driverName = json['driver_name'];
//     location =
//         json['location'] != null ? Location.fromJson(json['location']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['driverId'] = this.driverId;
//     data['driver_name'] = this.driverName;
//     if (this.location != null) {
//       data['location'] = this.location!.toJson();
//     }
//     return data;
//   }
// }

// class Location {
//   List<String>? coordinates;

//   Location({this.coordinates});

//   Location.fromJson(Map<String, dynamic> json) {
//     coordinates = json['coordinates'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['coordinates'] = this.coordinates;
//     return data;
//   }
// }
