// To parse this JSON data, do
//
//     final paymentChannelModel = paymentChannelModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/checkout/domain/entity/payment_channel_entity.dart';

PaymentChannelModel paymentChannelModelFromJson(String str) =>
    PaymentChannelModel.fromJson(json.decode(str));

String paymentChannelModelToJson(PaymentChannelModel data) =>
    json.encode(data.toJson());

class PaymentChannelModel extends PaymentChannelEntity {
  PaymentChannelModel({
    String? uid,
    String? channelCode,
    String? name,
    String? channelCategory,
    String? picture,
    String? fee,
    String? feeType,
    int? min,
    int? max,
  }) : super(
          uid: uid,
          channelCode: channelCode,
          name: name,
          channelCategory: channelCategory,
          picture: picture,
          fee: fee,
          feeType: feeType,
          min: min,
          max: max,
        );

  factory PaymentChannelModel.toModel(
          {required PaymentChannelEntity paymentChannelEntity}) =>
      PaymentChannelModel(
        channelCategory: paymentChannelEntity.channelCategory,
        channelCode: paymentChannelEntity.channelCode,
        fee: paymentChannelEntity.fee,
        feeType: paymentChannelEntity.feeType,
        max: paymentChannelEntity.max,
        min: paymentChannelEntity.min,
        name: paymentChannelEntity.name,
        picture: paymentChannelEntity.picture,
        uid: paymentChannelEntity.uid,
      );

  factory PaymentChannelModel.fromJson(Map<String, dynamic> json) =>
      PaymentChannelModel(
        uid: json["uid"],
        channelCode: json["channel_code"],
        name: json["name"],
        channelCategory: json["channel_category"],
        picture: json["picture"],
        fee: json["fee"],
        feeType: json["fee_type"],
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "channel_code": channelCode,
        "name": name,
        "channel_category": channelCategory,
        "picture": picture,
        "fee": fee,
        "fee_type": feeType,
        "min": min,
        "max": max,
      };
}
