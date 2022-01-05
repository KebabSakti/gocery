import 'dart:convert';

import 'package:gocery/feature/auth/data/model/fcm_model.dart';
import 'package:gocery/feature/auth/data/model/point_model.dart';
import 'package:gocery/feature/auth/domain/entity/user_entity.dart';

UserModel authModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String authModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends UserEntity {
  UserModel({
    int? id,
    String? name,
    String? email,
    String? phone,
    FcmModel? fcm,
    PointModel? point,
  }) : super(
          id: id,
          name: name,
          email: email,
          phone: phone,
          fcm: fcm,
          point: point,
        );

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    FcmModel? fcm,
    PointModel? point,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        fcm: fcm ?? this.fcm,
        point: point ?? this.point,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        fcm: FcmModel.fromJson(json['fcm']),
        point: PointModel.fromJson(json['point']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "fcm": fcm,
        "point": point,
      };
}
