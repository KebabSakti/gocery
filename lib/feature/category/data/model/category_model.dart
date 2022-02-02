import 'package:gocery/feature/category/domain/entity/category_entity.dart';
import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel extends CategoryEntity {
  CategoryModel({
    String? uid,
    String? name,
    String? description,
    String? image,
    String? color,
    int? orderNumber,
  }) : super(
            uid: uid,
            name: name,
            description: description,
            image: image,
            color: color,
            orderNumber: orderNumber);

  CategoryModel copyWith({
    String? uid,
    String? name,
    String? description,
    String? image,
    String? color,
    int? orderNumber,
  }) =>
      CategoryModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        color: color ?? this.color,
        orderNumber: orderNumber ?? this.orderNumber,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        uid: json["uid"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        color: json["color"],
        orderNumber: json["order_number"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "description": description,
        "image": image,
        "color": color,
        "order_number": orderNumber,
      };
}
