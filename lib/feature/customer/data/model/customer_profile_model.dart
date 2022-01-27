import 'dart:convert';

import 'package:gocery/feature/customer/domain/entity/customer_profile_entity.dart';

CustomerProfileModel customerProfileModelFromJson(String str) =>
    CustomerProfileModel.fromJson(json.decode(str));

String customerProfileModelToJson(CustomerProfileModel data) =>
    json.encode(data.toJson());

class CustomerProfileModel extends CustomerProfileEntity {
  CustomerProfileModel({
    String? uid,
    String? name,
    String? email,
    String? phone,
    String? picture,
  });

  CustomerProfileModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    String? picture,
  }) =>
      CustomerProfileModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        picture: picture ?? this.picture,
      );

  factory CustomerProfileModel.fromJson(Map<String, dynamic> json) =>
      CustomerProfileModel(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "phone": phone,
        "picture": picture,
      };
}
