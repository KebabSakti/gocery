import 'package:gocery/feature/checkout/domain/entity/order_shipping_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_param_entity.dart';
import 'package:gocery/feature/checkout/domain/repository/order_repository.dart';

class GetOrderShipping {
  GetOrderShipping({required this.repository});

  final OrderRepository repository;

  Future<List<OrderShippingEntity>> call(
      {required OrderShippingParamEntity param}) async {
    return await repository.getOrderShipping(param: param);
  }
}
