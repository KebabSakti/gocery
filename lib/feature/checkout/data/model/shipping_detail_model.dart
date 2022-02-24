// To parse this JSON data, do
//
//     final shippingDetailModel = shippingDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/checkout/domain/entity/shipping_detail_entity.dart';

ShippingDetailModel shippingDetailModelFromJson(String str) =>
    ShippingDetailModel.fromJson(json.decode(str));

String shippingDetailModelToJson(ShippingDetailModel data) =>
    json.encode(data.toJson());

class ShippingDetailModel extends ShippingDetailEntity {
  ShippingDetailModel({
    String? orderUid,
    String? partnerUid,
    String? uid,
    String? shipping,
    String? distance,
    String? distanceUnit,
    String? price,
    String? time,
  }) : super(
          orderUid: orderUid,
          partnerUid: partnerUid,
          uid: uid,
          shipping: shipping,
          distance: distance,
          distanceUnit: distanceUnit,
          price: price,
          time: time,
        );

  factory ShippingDetailModel.fromJson(Map<String, dynamic> json) =>
      ShippingDetailModel(
        orderUid: json["order_uid"],
        partnerUid: json["partner_uid"],
        uid: json["uid"],
        shipping: json["shipping"],
        distance: json["distance"],
        distanceUnit: json["distance_unit"],
        price: json["price"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "order_uid": orderUid,
        "partner_uid": partnerUid,
        "uid": uid,
        "shipping": shipping,
        "distance": distance,
        "distance_unit": distanceUnit,
        "price": price,
        "time": time,
      };
}
