// To parse this JSON data, do
//
//     final fcmTokenModel = fcmTokenModelFromJson(jsonString);

import 'dart:convert';

FcmTokenModel fcmTokenModelFromJson(String str) =>
    FcmTokenModel.fromJson(json.decode(str));

String fcmTokenModelToJson(FcmTokenModel data) => json.encode(data.toJson());

class FcmTokenModel {
  FcmTokenModel({
    this.uid,
    this.token,
  });

  final String? uid;
  final String? token;

  FcmTokenModel copyWith({
    String? uid,
    String? token,
  }) =>
      FcmTokenModel(
        uid: uid ?? this.uid,
        token: token ?? this.token,
      );

  factory FcmTokenModel.fromJson(Map<String, dynamic> json) => FcmTokenModel(
        uid: json["uid"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "token": token,
      };
}
