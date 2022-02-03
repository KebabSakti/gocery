import 'dart:convert';

import 'package:gocery/feature/customer/domain/entity/customer_fcm_entity.dart';

CustomerFcmModel customerFcmModelFromJson(String str) =>
    CustomerFcmModel.fromJson(json.decode(str));

String customerFcmModelToJson(CustomerFcmModel data) =>
    json.encode(data.toJson());

class CustomerFcmModel extends CustomerFcmEntity {
  CustomerFcmModel({
    String? customerAccountUid,
    String? uid,
    String? fcmToken,
  }) : super(
          customerAccountUid: customerAccountUid,
          uid: uid,
          fcmToken: fcmToken,
        );

  CustomerFcmModel copyWith({
    String? customerAccountUid,
    String? uid,
    String? fcmToken,
  }) =>
      CustomerFcmModel(
        customerAccountUid: customerAccountUid ?? this.customerAccountUid,
        uid: uid ?? this.uid,
        fcmToken: fcmToken ?? this.fcmToken,
      );

  factory CustomerFcmModel.fromJson(Map<String, dynamic> json) =>
      CustomerFcmModel(
        customerAccountUid: json["customer_account_uid"],
        uid: json["uid"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "customer_account_uid": customerAccountUid,
        "uid": uid,
        "fcm_token": fcmToken,
      };
}
