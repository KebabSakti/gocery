class OrderItemEntity {
  OrderItemEntity({
    this.orderUid,
    this.productUid,
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
    this.itemQtyTotal,
    this.itemPriceTotal,
    this.note,
  });

  final String? orderUid;
  final String? productUid;
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
  final int? itemQtyTotal;
  final String? itemPriceTotal;
  final String? note;

  OrderItemEntity copyWith({
    String? orderUid,
    String? productUid,
    String? uid,
    String? name,
    String? description,
    String? image,
    String? price,
    String? discount,
    String? finalPrice,
    String? unit,
    int? unitCount,
    int? minOrder,
    int? maxOrder,
    int? stok,
    int? itemQtyTotal,
    String? itemPriceTotal,
    String? note,
  }) =>
      OrderItemEntity(
        orderUid: orderUid ?? this.orderUid,
        productUid: productUid ?? this.productUid,
        uid: uid ?? this.uid,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        finalPrice: finalPrice ?? this.finalPrice,
        unit: unit ?? this.unit,
        unitCount: unitCount ?? this.unitCount,
        minOrder: minOrder ?? this.minOrder,
        maxOrder: maxOrder ?? this.maxOrder,
        stok: stok ?? this.stok,
        itemQtyTotal: itemQtyTotal ?? this.itemQtyTotal,
        itemPriceTotal: itemPriceTotal ?? this.itemPriceTotal,
        note: note ?? this.note,
      );
}
