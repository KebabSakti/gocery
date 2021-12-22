import 'package:gocery/feature/todo/model/user/user_model.dart';
import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  AuthModel({
    this.userModel,
    this.token,
  });

  final UserModel? userModel;
  final String? token;

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
