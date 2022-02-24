// To parse this JSON data, do
//
//     final partnerModel = partnerModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/partner/domain/entity/partner_entity.dart';

PartnerModel partnerModelFromJson(String str) =>
    PartnerModel.fromJson(json.decode(str));

String partnerModelToJson(PartnerModel data) => json.encode(data.toJson());

class PartnerModel extends PartnerEntity {
  PartnerModel({
    String? uid,
    String? name,
    String? address,
    String? phone,
    String? shipping,
    String? type,
    String? latitude,
    String? longitude,
    int? online,
    int? exclusive,
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
          exclusive: exclusive,
        );

  factory PartnerModel.fromJson(Map<String, dynamic> json) => PartnerModel(
        uid: json["uid"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        shipping: json["shipping"],
        type: json["type"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        online: json["online"],
        exclusive: json["exclusive"],
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
        "exclusive": exclusive,
      };
}
