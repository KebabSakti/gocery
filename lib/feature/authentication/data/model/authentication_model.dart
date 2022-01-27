import 'dart:convert';

import 'package:gocery/feature/authentication/domain/entity/authentication_entity.dart';
import 'package:gocery/feature/customer/data/model/customer_account_model.dart';

AuthenticationModel authenticationModelFromJson(String str) =>
    AuthenticationModel.fromJson(json.decode(str));

String authenticationModelToJson(AuthenticationModel data) =>
    json.encode(data.toJson());

class AuthenticationModel extends AuthenticationEntity {
  AuthenticationModel({
    // CustomerAccountModel? customerAccountModel,
    String? token,
  }) : super(
          // customerAccountModel: customerAccountModel,
          token: token,
        );

  AuthenticationModel copyWith({
    CustomerAccountModel? customerAccountModel,
    String? token,
  }) =>
      AuthenticationModel(
        // customerAccountModel: customerAccountModel ?? this.customerAccountModel,
        token: token ?? this.token,
      );

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) =>
      AuthenticationModel(
        // customerAccountModel:
        //     CustomerAccountModel.fromJson(json["customer_account_model"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        // "customer_account_model": customerAccountModel?.toJson(),
        "token": token,
      };
}
