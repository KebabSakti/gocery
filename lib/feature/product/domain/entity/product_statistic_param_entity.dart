class ProductStatisticParamEntity {
  ProductStatisticParamEntity({
    this.productUid,
    this.target,
  });

  final String? productUid;
  final String? target;

  ProductStatisticParamEntity copyWith({
    String? productUid,
    String? target,
  }) =>
      ProductStatisticParamEntity(
        productUid: productUid,
        target: target,
      );
}
