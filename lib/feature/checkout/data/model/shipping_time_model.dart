// To parse this JSON data, do
//
//     final shippingTimeModel = shippingTimeModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/checkout/domain/entity/shipping_time_entity.dart';

ShippingTimeModel shippingTimeModelFromJson(String str) =>
    ShippingTimeModel.fromJson(json.decode(str));

String shippingTimeModelToJson(ShippingTimeModel data) =>
    json.encode(data.toJson());

class ShippingTimeModel extends ShippingTimeEntity {
  ShippingTimeModel({
    String? uid,
    String? time,
    bool? enable,
  }) : super(uid: uid, time: time, enable: enable);

  factory ShippingTimeModel.fromJson(Map<String, dynamic> json) =>
      ShippingTimeModel(
        uid: json["uid"],
        time: json["time"],
        enable: json["enable"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "time": time,
        "enable": enable,
      };
}
