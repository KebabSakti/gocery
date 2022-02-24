// To parse this JSON data, do
//
//     final courierFcmModel = courierFcmModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/partner/domain/entity/courier_fcm_entity.dart';

CourierFcmModel courierFcmModelFromJson(String str) =>
    CourierFcmModel.fromJson(json.decode(str));

String courierFcmModelToJson(CourierFcmModel data) =>
    json.encode(data.toJson());

class CourierFcmModel extends CourierFcmEntity {
  CourierFcmModel({
    String? courierAccountUid,
    String? uid,
    String? fcmToken,
  });

  factory CourierFcmModel.fromJson(Map<String, dynamic> json) =>
      CourierFcmModel(
        courierAccountUid: json["courier_account_uid"],
        uid: json["uid"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "courier_account_uid": courierAccountUid,
        "uid": uid,
        "fcm_token": fcmToken,
      };
}
