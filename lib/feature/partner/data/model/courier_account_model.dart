// To parse this JSON data, do
//
//     final courierAccountModel = courierAccountModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/partner/data/model/courier_fcm_model.dart';
import 'package:gocery/feature/partner/data/model/courier_profile_model.dart';
import 'package:gocery/feature/partner/data/model/courier_rating_model.dart';
import 'package:gocery/feature/partner/domain/entity/courier_account_entity.dart';

CourierAccountModel courierAccountModelFromJson(String str) =>
    CourierAccountModel.fromJson(json.decode(str));

String courierAccountModelToJson(CourierAccountModel data) =>
    json.encode(data.toJson());

class CourierAccountModel extends CourierAccountEntity {
  CourierAccountModel({
    String? partnerUid,
    String? uid,
    String? username,
    String? owner,
    CourierProfileModel? courierProfileModel,
    CourierFcmModel? courierFcmModel,
    CourierRatingModel? courierRatingModel,
  }) : super(
          partnerUid: partnerUid,
          uid: uid,
          username: username,
          owner: owner,
          courierProfileEntity: courierProfileModel,
          courierFcmEntity: courierFcmModel,
          courierRatingEntity: courierRatingModel,
        );

  factory CourierAccountModel.fromJson(Map<String, dynamic> json) =>
      CourierAccountModel(
        partnerUid: json["partner_uid"],
        uid: json["uid"],
        username: json["username"],
        owner: json["owner"],
        courierProfileModel:
            CourierProfileModel.fromJson(json["courier_profile_model"]),
        courierFcmModel: CourierFcmModel.fromJson(json["courier_fcm_model"]),
        courierRatingModel:
            CourierRatingModel.fromJson(json["courier_rating_model"]),
      );

  Map<String, dynamic> toJson() => {
        "partner_uid": partnerUid,
        "uid": uid,
        "username": username,
        "owner": owner,
        "courier_profile_model":
            (courierProfileEntity as CourierProfileModel).toJson(),
        "courier_fcm_model": (courierProfileEntity as CourierFcmModel).toJson(),
        "courier_rating_model":
            (courierRatingEntity as CourierRatingModel).toJson(),
      };
}
