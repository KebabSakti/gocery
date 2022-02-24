// To parse this JSON data, do
//
//     final orderShippingModel = orderShippingModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/checkout/domain/entity/order_shipping_entity.dart';

OrderShippingModel orderShippingModelFromJson(String str) =>
    OrderShippingModel.fromJson(json.decode(str));

String orderShippingModelToJson(OrderShippingModel data) =>
    json.encode(data.toJson());

class OrderShippingModel extends OrderShippingEntity {
  OrderShippingModel({
    String? uid,
    String? name,
    String? address,
    String? phone,
    String? shipping,
    String? type,
    String? latitude,
    String? longitude,
    int? online,
    String? distance,
    String? distanceUnit,
    String? price,
    String? time,
  }) : super(
          uid: uid,
          name: name,
          address: address,
          phone: phone,
          shipping: shipping,
          type: type,
          latitude: latitude,
          longitude: longitude,
          online: online,
          distance: distance,
          distanceUnit: distanceUnit,
          price: price,
          time: time,
        );

  factory OrderShippingModel.fromJson(Map<String, dynamic> json) =>
      OrderShippingModel(
        uid: json["uid"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        shipping: json["shipping"],
        type: json["type"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        online: json["online"],
        distance: json["distance"],
        distanceUnit: json["distance_unit"],
        price: json["price"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "address": address,
        "phone": phone,
        "shipping": shipping,
        "type": type,
        "latitude": latitude,
        "longitude": longitude,
        "online": online,
        "distance": distance,
        "distance_unit": distanceUnit,
        "price": price,
        "time": time,
      };
}
