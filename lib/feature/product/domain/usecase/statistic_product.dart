import 'package:gocery/feature/product/domain/entity/product_statistic_param_entity.dart';
import 'package:gocery/feature/product/domain/repository/product_repository.dart';

class StatisticProduct {
  StatisticProduct({required this.repository});

  final ProductRepository repository;

  Future call({required ProductStatisticParamEntity param}) async {
    await repository.statisticProduct(param: param);
  }
}
