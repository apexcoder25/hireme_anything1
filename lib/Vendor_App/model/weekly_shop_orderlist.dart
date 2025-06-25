// To parse this JSON data, do
//
//     final weeklyShopOrderListModel = weeklyShopOrderListModelFromJson(jsonString);

import 'dart:convert';

WeeklyShopOrderListModel weeklyShopOrderListModelFromJson(String str) => WeeklyShopOrderListModel.fromJson(json.decode(str));

String weeklyShopOrderListModelToJson(WeeklyShopOrderListModel data) => json.encode(data.toJson());

class WeeklyShopOrderListModel {
  String? result;
  String ?msg;
  dynamic data;

  WeeklyShopOrderListModel({
    required this.result,
    required this.msg,
    required this.data,
  });

  factory WeeklyShopOrderListModel.fromJson(Map<String, dynamic> json) => WeeklyShopOrderListModel(
    result: json["result"]??"",
    msg: json["msg"]??"",
    data: json["data"]??""
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "msg": msg,
    "data": data,
  };
}

class Datum {
  String? orderId;
  String ?userId;
  String ?cartId;
  int ?orderNo;
  int ?totalAmmount;
  String? orderStatus;
  String ?venderStatus;
  int ?totalSells;
  String ?orderDate;
  int ?noOfOrder;
  int ?orderValue;
  String ? settlements;
  String ?driverAssignStatus;
  String? products;

  Datum({
    required this.orderId,
    required this.userId,
    required this.cartId,
    required this.orderNo,
    required this.totalAmmount,
    required this.orderStatus,
    required this.venderStatus,
    required this.totalSells,
    required this.orderDate,
    required this.noOfOrder,
    required this.orderValue,
    required this.settlements,
    required this.driverAssignStatus,
    required this.products,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    orderId: json["orderId"]??"",
    userId: json["userId"]??"",
    cartId: json["cartId"]??"",
    orderNo: json["order_no"]??"",
    totalAmmount: json["total_ammount"]??"",
    orderStatus: json["order_status"]??"",
    venderStatus: json["vender_status"]??"",
    totalSells: json["total_sells"]??"",
    orderDate: json["order_date"]??"",
    noOfOrder: json["no_of_order"]??"",
    orderValue: json["order_value"]??"",
    settlements: json["settlements"]??"",
    driverAssignStatus: json["driver_assign_status"]??"",
    products: json["products"]??""
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "userId": userId,
    "cartId": cartId,
    "order_no": orderNo,
    "total_ammount": totalAmmount,
    "order_status": orderStatus,
    "vender_status": venderStatus,
    "total_sells": totalSells,
    "order_date": orderDate,
    "no_of_order": noOfOrder,
    "order_value": orderValue,
    "settlements": settlements,
    "driver_assign_status": driverAssignStatus,
    "products": products
  };
}

class Product {
  String? productId;
  String ?productName;
  String ?productImage;
  String ?variants;

  Product({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.variants,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["productId"]??"",
    productName: json["product_name"]??"",
    productImage: json["product_image"]??"",
    variants: json["variants"]??"",
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "product_name": productName,
    "product_image": productImage,
    "variants": variants,
  };
}
