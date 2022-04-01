// To parse this JSON data, do
//
//     final shippingAddressModel = shippingAddressModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';

ShippingAddressModel shippingAddressModelFromJson(String str) =>
    ShippingAddressModel.fromJson(json.decode(str));

String shippingAddressModelToJson(ShippingAddressModel data) =>
    json.encode(data.toJson());

class ShippingAddressModel extends ShippingAddressEntity {
  ShippingAddressModel({
    String? orderUid,
    String? uid,
    String? placeId,
    String? address,
    String? latitude,
    String? longitude,
    String? note,
    String? name,
    String? phone,
  }) : super(
          orderUid: orderUid,
          uid: uid,
          placeId: placeId,
          address: address,
          latitude: latitude,
          longitude: longitude,
          note: note,
          name: name,
          phone: phone,
        );

  factory ShippingAddressModel.toModel(
          {required ShippingAddressEntity shippingAddressEntity}) =>
      ShippingAddressModel(
        address: shippingAddressEntity.address,
        latitude: shippingAddressEntity.latitude,
        longitude: shippingAddressEntity.longitude,
        name: shippingAddressEntity.name,
        note: shippingAddressEntity.note,
        orderUid: shippingAddressEntity.orderUid,
        phone: shippingAddressEntity.phone,
        placeId: shippingAddressEntity.placeId,
        uid: shippingAddressEntity.uid,
      );

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) =>
      ShippingAddressModel(
        orderUid: json["order_uid"],
        uid: json["uid"],
        placeId: json["place_id"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        note: json["note"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "order_uid": orderUid,
        "uid": uid,
        "place_id": placeId,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "note": note,
        "name": name,
        "phone": phone,
      };
}
