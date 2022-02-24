// To parse this JSON data, do
//
//     final orderStatusModel = orderStatusModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/checkout/domain/entity/order_status_entity.dart';

OrderStatusModel orderStatusModelFromJson(String str) =>
    OrderStatusModel.fromJson(json.decode(str));

String orderStatusModelToJson(OrderStatusModel data) =>
    json.encode(data.toJson());

class OrderStatusModel extends OrderStatusEntity {
  OrderStatusModel({
    String? orderUid,
    String? uid,
    String? status,
    String? description,
    String? note,
  }) : super(
          orderUid: orderUid,
          uid: uid,
          status: status,
          description: description,
          note: note,
        );

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) =>
      OrderStatusModel(
        orderUid: json["order_uid"],
        uid: json["uid"],
        status: json["status"],
        description: json["description"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "order_uid": orderUid,
        "uid": uid,
        "status": status,
        "description": description,
        "note": note,
      };
}
