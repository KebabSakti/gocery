import 'package:gocery/feature/product/domain/entity/product_statistic_entity.dart';

class ProductStatisticModel extends ProductStatisticEntity {
  ProductStatisticModel({
    int? favourite,
    int? view,
    int? sold,
  });

  ProductStatisticModel copyWith({
    int? favourite,
    int? view,
    int? sold,
  }) =>
      ProductStatisticModel(
        favourite: favourite ?? this.favourite,
        view: view ?? this.view,
        sold: sold ?? this.sold,
      );

  factory ProductStatisticModel.fromJson(Map<String, dynamic> json) =>
      ProductStatisticModel(
        favourite: json["favourite"],
        view: json["view"],
        sold: json["sold"],
      );

  Map<String, dynamic> toJson() => {
        "favourite": favourite,
        "view": view,
        "sold": sold,
      };
}
