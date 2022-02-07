import 'package:gocery/feature/product/domain/entity/index_product_param_entity.dart';

class IndexProductParamModel extends IndexProductParamEntity {
  IndexProductParamModel({
    required int page,
    String? sorting,
    String? shipping,
    String? category,
    String? bundle,
    String? name,
  }) : super(
          page: page,
          sorting: sorting,
          shipping: shipping,
          category: category,
          bundle: bundle,
          name: name,
        );

  IndexProductParamModel copyWith({
    required int page,
    String? sorting,
    String? shipping,
    String? category,
    String? bundle,
    String? name,
  }) =>
      IndexProductParamModel(
        page: page,
        sorting: sorting ?? this.sorting,
        shipping: shipping ?? this.shipping,
        category: category ?? this.category,
        bundle: bundle ?? this.bundle,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() => {
        'page': page,
        'sorting': sorting,
        'shipping': shipping,
        'category': category,
        'bundle': bundle,
        'name': name,
      }..removeWhere((key, value) => value == null);
}
