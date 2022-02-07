class IndexProductParamEntity {
  IndexProductParamEntity({
    required this.page,
    this.sorting,
    this.shipping,
    this.category,
    this.bundle,
    this.name,
  });

  final int page;
  final String? sorting;
  final String? shipping;
  final String? category;
  final String? bundle;
  final String? name;
}
