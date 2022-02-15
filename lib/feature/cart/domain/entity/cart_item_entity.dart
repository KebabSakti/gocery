import 'package:gocery/feature/product/domain/entity/product_entity.dart';

class CartItemEntity {
  CartItemEntity({
    this.customerAccountUid,
    this.productUid,
    this.uid,
    this.itemQtyTotal,
    this.itemPriceTotal,
    this.note,
    this.productModel,
  });

  final String? customerAccountUid;
  final String? productUid;
  final String? uid;
  final int? itemQtyTotal;
  final String? itemPriceTotal;
  final String? note;
  final ProductEntity? productModel;

  CartItemEntity copyWith({
    String? customerAccountUid,
    String? productUid,
    String? uid,
    int? itemQtyTotal,
    String? itemPriceTotal,
    String? note,
    ProductEntity? productModel,
  }) =>
      CartItemEntity(
        customerAccountUid: customerAccountUid ?? this.customerAccountUid,
        productUid: productUid ?? this.productUid,
        uid: uid ?? this.uid,
        itemQtyTotal: itemQtyTotal ?? this.itemQtyTotal,
        itemPriceTotal: itemPriceTotal ?? this.itemPriceTotal,
        note: note ?? this.note,
        productModel: productModel ?? this.productModel,
      );
}
