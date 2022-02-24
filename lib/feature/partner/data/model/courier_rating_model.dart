// To parse this JSON data, do
//
//     final courierRatingModel = courierRatingModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/partner/domain/entity/courier_rating_entity.dart';

CourierRatingModel courierRatingModelFromJson(String str) =>
    CourierRatingModel.fromJson(json.decode(str));

String courierRatingModelToJson(CourierRatingModel data) =>
    json.encode(data.toJson());

class CourierRatingModel extends CourierRatingEntity {
  CourierRatingModel({
    String? courierAccountUid,
    String? uid,
    int? one,
    int? two,
    int? three,
    int? four,
    int? five,
    int? ratingCount,
    String? ratingValue,
  }) : super(
          courierAccountUid: courierAccountUid,
          uid: uid,
          one: one,
          two: two,
          three: three,
          four: four,
          five: five,
          ratingCount: ratingCount,
          ratingValue: ratingValue,
        );

  factory CourierRatingModel.fromJson(Map<String, dynamic> json) =>
      CourierRatingModel(
        courierAccountUid: json["courier_account_uid"],
        uid: json["uid"],
        one: json["one"],
        two: json["two"],
        three: json["three"],
        four: json["four"],
        five: json["five"],
        ratingCount: json["rating_count"],
        ratingValue: json["rating_value"],
      );

  Map<String, dynamic> toJson() => {
        "courier_account_uid": courierAccountUid,
        "uid": uid,
        "one": one,
        "two": two,
        "three": three,
        "four": four,
        "five": five,
        "rating_count": ratingCount,
        "rating_value": ratingValue,
      };
}
