// To parse this JSON data, do
//
//     final paymentDetailModel = paymentDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/payment/domain/entity/payment_detail_entity.dart';

PaymentDetailModel paymentDetailModelFromJson(String str) =>
    PaymentDetailModel.fromJson(json.decode(str));

String paymentDetailModelToJson(PaymentDetailModel data) =>
    json.encode(data.toJson());

class PaymentDetailModel extends PaymentDetailEntity {
  PaymentDetailModel({
    String? orderUid,
    String? channelCode,
    String? referenceId,
    String? externalId,
    String? extra,
    String? status,
    String? note,
  }) : super(
          orderUid: orderUid,
          channelCode: channelCode,
          referenceId: referenceId,
          externalId: externalId,
          extra: extra,
          status: status,
          note: note,
        );

  PaymentDetailModel toModel({required PaymentDetailEntity entity}) =>
      PaymentDetailModel(
        channelCode: entity.channelCode,
        externalId: entity.externalId,
        extra: entity.extra,
        note: entity.note,
        orderUid: entity.orderUid,
        referenceId: entity.referenceId,
        status: entity.status,
      );

  factory PaymentDetailModel.fromJson(Map<String, dynamic> json) =>
      PaymentDetailModel(
        orderUid: json["order_uid"],
        channelCode: json["channel_code"],
        referenceId: json["reference_id"],
        externalId: json["external_id"],
        extra: json["extra"],
        status: json["status"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "order_uid": orderUid,
        "channel_code": channelCode,
        "reference_id": referenceId,
        "external_id": externalId,
        "extra": extra,
        "status": status,
        "note": note,
      };
}
