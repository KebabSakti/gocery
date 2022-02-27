import 'package:gocery/feature/checkout/domain/entity/shipping_time_entity.dart';
import 'package:gocery/feature/checkout/domain/repository/order_repository.dart';

class GetShippingTimes {
  GetShippingTimes({required this.repository});

  final OrderRepository repository;

  Future<List<ShippingTimeEntity>> call() async {
    return await repository.getShippingTimes();
  }
}
