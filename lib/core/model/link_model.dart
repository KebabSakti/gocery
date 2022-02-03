import 'dart:convert';
import 'package:gocery/core/entity/link_entity.dart';

LinkModel linkModelFromJson(String str) => LinkModel.fromJson(json.decode(str));

String linkModelToJson(LinkModel data) => json.encode(data.toJson());

class LinkModel extends LinkEntity {
  LinkModel({
    String? first,
    String? last,
    String? prev,
    String? next,
  }) : super(
          first: first,
          last: last,
          prev: prev,
          next: next,
        );

  LinkModel copyWith({
    String? first,
    String? last,
    String? prev,
    String? next,
  }) =>
      LinkModel(
        first: first ?? this.first,
        last: last ?? this.last,
        prev: prev ?? this.prev,
        next: next ?? this.next,
      );

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}
