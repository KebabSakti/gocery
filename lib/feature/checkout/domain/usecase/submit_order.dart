import 'package:gocery/feature/checkout/domain/entity/order_entity.dart';
import 'package:gocery/feature/checkout/domain/repository/order_repository.dart';

class SubmitOrder {
  final OrderRepository repository;

  SubmitOrder({required this.repository});

  Future<void> call({required OrderEntity param}) async {
    await repository.submitOrder(param: param);
  }
}
