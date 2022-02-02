// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

import 'package:gocery/feature/banner/domain/entity/banner_entity.dart';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel extends BannerEntity {
  BannerModel({
    String? uid,
    String? image,
    String? bundleUid,
  }) : super(
          uid: uid,
          image: image,
          bundleUid: bundleUid,
        );

  BannerModel copyWith({
    String? uid,
    String? image,
    String? bundleUid,
  }) =>
      BannerModel(
        uid: uid ?? this.uid,
        image: image ?? this.image,
        bundleUid: bundleUid ?? this.bundleUid,
      );

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        uid: json["uid"],
        image: json["image"],
        bundleUid: json["bundle_uid"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "image": image,
        "bundle_uid": bundleUid,
      };
}
