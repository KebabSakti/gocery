import 'dart:convert';

UserModel authModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String authModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.age,
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  final int? age;
  final String? id;
  final String? name;
  final String? email;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  UserModel copyWith({
    int? age,
    String? id,
    String? name,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      UserModel(
        age: age ?? this.age,
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        age: json["age"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "age": age,
        "_id": id,
        "name": name,
        "email": email,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
