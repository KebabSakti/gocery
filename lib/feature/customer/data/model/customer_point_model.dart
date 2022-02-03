// To parse this JSON data, do
//
//     final CustomerPointModel = CustomerPointModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/customer/domain/entity/customer_point_entity.dart';

CustomerPointModel customerPointModelFromJson(String str) =>
    CustomerPointModel.fromJson(json.decode(str));

String customerPointModelToJson(CustomerPointModel data) =>
    json.encode(data.toJson());

class CustomerPointModel extends CustomerPointEntity {
  CustomerPointModel({
    String? customerAccountUid,
    String? uid,
    int? point,
  }) : super(
          customerAccountUid: customerAccountUid,
          uid: uid,
          point: point,
        );

  CustomerPointModel copyWith({
    String? customerAccountUid,
    String? uid,
    int? point,
  }) =>
      CustomerPointModel(
        customerAccountUid: customerAccountUid ?? this.customerAccountUid,
        uid: uid ?? this.uid,
        point: point ?? this.point,
      );

  factory CustomerPointModel.fromJson(Map<String, dynamic> json) =>
      CustomerPointModel(
        customerAccountUid: json["customer_account_uid"],
        uid: json["uid"],
        point: json["point"],
      );

  Map<String, dynamic> toJson() => {
        "customer_account_uid": customerAccountUid,
        "uid": uid,
        "point": point,
      };
}
