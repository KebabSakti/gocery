import 'dart:convert';

import 'package:gocery/feature/auth/data/model/user_model.dart';
import 'package:gocery/feature/auth/domain/entity/auth_entity.dart';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel extends AuthEntity {
  AuthModel({
    UserModel? userModel,
    String? token,
  }) : super(
          userModel: userModel,
          token: token,
        );

  AuthModel copyWith({
    UserModel? userModel,
    String? token,
  }) =>
      AuthModel(
        userModel: userModel ?? this.userModel,
        token: token ?? this.token,
      );

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        userModel: UserModel.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": userModel?.toJson(),
        "token": token,
      };
}
