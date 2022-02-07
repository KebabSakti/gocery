import 'package:gocery/feature/product/domain/entity/product_statistic_entity.dart';

class ProductStatisticModel extends ProductStatisticEntity {
  ProductStatisticModel({
    String? productUid,
    String? uid,
    int? favourite,
    int? view,
    int? sold,
  }) : super(
          productUid: productUid,
          uid: uid,
          favourite: favourite,
          view: view,
          sold: sold,
        );

  ProductStatisticModel copyWith({
    String? productUid,
    String? uid,
    int? favourite,
    int? view,
    int? sold,
  }) =>
      ProductStatisticModel(
        productUid: productUid ?? this.productUid,
        uid: uid ?? this.uid,
        favourite: favourite ?? this.favourite,
        view: view ?? this.view,
        sold: sold ?? this.sold,
      );

  factory ProductStatisticModel.fromJson(Map<String, dynamic> json) =>
      ProductStatisticModel(
        productUid: json['product_uid'],
        uid: json['uid'],
        favourite: json["favourite"],
        view: json["view"],
        sold: json["sold"],
      );

  Map<String, dynamic> toJson() => {
        'product_uid': productUid,
        'uid': uid,
        "favourite": favourite,
        "view": view,
        "sold": sold,
      };
}
