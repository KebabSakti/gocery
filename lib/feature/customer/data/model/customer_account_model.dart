import 'dart:convert';

import 'package:gocery/core/model/fcm_token_model.dart';
import 'package:gocery/core/model/point_model.dart';
import 'package:gocery/feature/customer/data/model/customer_profile_model.dart';
import 'package:gocery/feature/customer/domain/entity/customer_account_entity.dart';

CustomerAccountModel customerAccountModelFromJson(String str) =>
    CustomerAccountModel.fromJson(json.decode(str));

String customerAccountModelToJson(CustomerAccountModel data) =>
    json.encode(data.toJson());

class CustomerAccountModel extends CustomerAccountEntity {
  CustomerAccountModel({
    String? uid,
    String? username,
    CustomerProfileModel? customerProfileModel,
    PointModel? pointModel,
    FcmTokenModel? fcmTokenModel,
  }) : super(
          uid: uid,
          username: username,
          customerProfileModel: customerProfileModel,
          pointModel: pointModel,
          fcmTokenModel: fcmTokenModel,
        );

  CustomerAccountModel copyWith({
    String? uid,
    String? username,
    CustomerProfileModel? customerProfileModel,
    PointModel? pointModel,
    FcmTokenModel? fcmTokenModel,
  }) =>
      CustomerAccountModel(
        uid: uid ?? this.uid,
        username: username ?? this.username,
        customerProfileModel: customerProfileModel ?? this.customerProfileModel,
        pointModel: pointModel ?? this.pointModel,
        fcmTokenModel: fcmTokenModel ?? this.fcmTokenModel,
      );

  factory CustomerAccountModel.fromJson(Map<String, dynamic> json) =>
      CustomerAccountModel(
        uid: json["uid"],
        username: json["username"],
        customerProfileModel: json["customer_profile_model"] == null
            ? null
            : CustomerProfileModel.fromJson(json["customer_profile_model"]),
        pointModel: json["point_model"] == null
            ? null
            : PointModel.fromJson(json["point_model"]),
        fcmTokenModel: json["fcm_token_model"] == null
            ? null
            : FcmTokenModel.fromJson(json["fcm_token_model"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "customer_profile_model": customerProfileModel?.toJson(),
        "point_model": pointModel?.toJson(),
        "fcm_token_model": fcmTokenModel?.toJson(),
      };
}
