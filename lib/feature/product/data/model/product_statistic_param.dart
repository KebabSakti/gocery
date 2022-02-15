import 'dart:convert';

import 'package:gocery/feature/product/domain/entity/product_statistic_param_entity.dart';

String productStatisticParamToJson(ProductStatisticParam data) =>
    json.encode(data.toJson());

class ProductStatisticParam extends ProductStatisticParamEntity {
  ProductStatisticParam({
    String? productUid,
    String? target,
  }) : super(
          productUid: productUid,
          target: target,
        );

  Map<String, dynamic>? toJson() => {
        'product_uid': productUid,
        'target': target,
      };
}
