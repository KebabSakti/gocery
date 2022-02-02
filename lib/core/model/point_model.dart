// To parse this JSON data, do
//
//     final pointModel = pointModelFromJson(jsonString);

import 'dart:convert';

PointModel pointModelFromJson(String str) =>
    PointModel.fromJson(json.decode(str));

String pointModelToJson(PointModel data) => json.encode(data.toJson());

class PointModel {
  PointModel({
    this.uid,
    this.point,
  });

  final String? uid;
  final int? point;

  PointModel copyWith({
    String? uid,
    int? point,
  }) =>
      PointModel(
        uid: uid ?? this.uid,
        point: point ?? this.point,
      );

  factory PointModel.fromJson(Map<String, dynamic> json) => PointModel(
        uid: json["uid"],
        point: json["point"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "point": point,
      };
}
