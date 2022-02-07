class ProductStatisticEntity {
  ProductStatisticEntity({
    this.productUid,
    this.uid,
    this.favourite,
    this.view,
    this.sold,
  });

  final String? productUid;
  final String? uid;
  final int? favourite;
  final int? view;
  final int? sold;
}
