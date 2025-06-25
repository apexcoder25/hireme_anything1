// To parse this JSON data, do
//
//     final todayShopOrderListModel = todayShopOrderListModelFromJson(jsonString);

import 'dart:convert';

TodayShopOrderListModel todayShopOrderListModelFromJson(String str) => TodayShopOrderListModel.fromJson(json.decode(str));

String todayShopOrderListModelToJson(TodayShopOrderListModel data) => json.encode(data.toJson());

class TodayShopOrderListModel {
  String ?result;
  String ?msg;
  dynamic data;

  TodayShopOrderListModel({
    required this.result,
    required this.msg,
    required this.data,
  });

  factory TodayShopOrderListModel.fromJson(Map<String, dynamic> json) => TodayShopOrderListModel(
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
  int ?noOfOrder;
  int ?orderValue;
  String settlements;
  String ?orderDate;
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
    required this.noOfOrder,
    required this.orderValue,
    required this.settlements,
    required this.orderDate,
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
    noOfOrder: json["no_of_order"]??"",
    orderValue: json["order_value"]??"",
    settlements: json["settlements"]??"",
    orderDate: json["order_date"]??"",
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
    "no_of_order": noOfOrder,
    "order_value": orderValue,
    "settlements": settlements,
    "order_date": orderDate,
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
