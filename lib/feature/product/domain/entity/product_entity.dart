import 'package:gocery/feature/product/domain/entity/product_statistic_entity.dart';

class ProductEntity {
  ProductEntity({
    this.categoryUid,
    this.uid,
    this.name,
    this.description,
    this.image,
    this.price,
    this.discount,
    this.finalPrice,
    this.unit,
    this.unitCount,
    this.minOrder,
    this.maxOrder,
    this.stok,
    this.point,
    this.shipping,
    this.type,
    this.deeplink,
    this.favourite,
    this.productStatisticModel,
  });

  final String? categoryUid;
  final String? uid;
  final String? name;
  final String? description;
  final String? image;
  final String? price;
  final String? discount;
  final String? finalPrice;
  final String? unit;
  final int? unitCount;
  final int? minOrder;
  final int? maxOrder;
  final int? stok;
  final int? point;
  final String? shipping;
  final String? type;
  final String? deeplink;
  final bool? favourite;
  final ProductStatisticEntity? productStatisticModel;
}
