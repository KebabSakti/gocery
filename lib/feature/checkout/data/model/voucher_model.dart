// To parse this JSON data, do
//
//     final voucherModel = voucherModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/checkout/domain/entity/voucher_entity.dart';

VoucherModel voucherModelFromJson(String str) =>
    VoucherModel.fromJson(json.decode(str));

String voucherModelToJson(VoucherModel data) => json.encode(data.toJson());

class VoucherModel extends VoucherEntity {
  VoucherModel({
    String? uid,
    String? title,
    String? description,
    String? image,
    int? max,
    String? amount,
    String? minOrder,
    String? startAt,
    String? expiredAt,
  }) : super(
          uid: uid,
          title: title,
          description: description,
          image: image,
          max: max,
          amount: amount,
          minOrder: minOrder,
          startAt: startAt,
          expiredAt: expiredAt,
        );

  factory VoucherModel.fromJson(Map<String, dynamic> json) => VoucherModel(
        uid: json["uid"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        max: json["max"],
        amount: json["amount"],
        minOrder: json["min_order"],
        startAt: json["start_at"],
        expiredAt: json["expired_at"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "title": title,
        "description": description,
        "image": image,
        "max": max,
        "amount": amount,
        "min_order": minOrder,
        "start_at": startAt,
        "expired_at": expiredAt,
      };
}
