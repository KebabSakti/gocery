import 'dart:convert';

import 'package:gocery/feature/customer/data/model/customer_fcm_model.dart';
import 'package:gocery/feature/customer/data/model/customer_point_model.dart';
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
    CustomerPointModel? customerPointModel,
    CustomerFcmModel? customerFcmModel,
  }) : super(
          uid: uid,
          username: username,
          customerProfileEntity: customerProfileModel,
          customerPointEntity: customerPointModel,
          customerFcmEntity: customerFcmModel,
        );

  CustomerAccountModel copyWith({
    String? uid,
    String? username,
    CustomerProfileModel? customerProfileModel,
    CustomerPointModel? customerPointModel,
    CustomerFcmModel? customerFcmModel,
  }) =>
      CustomerAccountModel(
        uid: uid ?? this.uid,
        username: username ?? this.username,
        customerProfileModel: customerProfileModel ??
            customerProfileEntity as CustomerProfileModel,
        customerPointModel:
            customerPointModel ?? customerPointEntity as CustomerPointModel,
        customerFcmModel:
            customerFcmModel ?? customerFcmEntity as CustomerFcmModel,
      );

  factory CustomerAccountModel.fromJson(Map<String, dynamic> json) =>
      CustomerAccountModel(
        uid: json["uid"],
        username: json["username"],
        customerProfileModel:
            CustomerProfileModel.fromJson(json["customer_profile_model"]),
        customerPointModel:
            CustomerPointModel.fromJson(json["customer_point_model"]),
        customerFcmModel: json["customer_fcm_model"] != null
            ? CustomerFcmModel.fromJson(json["customer_fcm_model"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "customer_profile_model":
            (customerProfileEntity as CustomerProfileModel).toJson(),
        "customer_point_model":
            (customerPointEntity as CustomerPointModel).toJson(),
        "customer_fcm_model": (customerFcmEntity as CustomerFcmModel).toJson(),
      };
}
