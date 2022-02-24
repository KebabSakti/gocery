import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';
import 'package:gocery/feature/checkout/domain/repository/order_repository.dart';

class GetLastAddress {
  GetLastAddress({required this.repository});

  final OrderRepository repository;

  Future<ShippingAddressEntity> call() async {
    return await repository.getLastAddress();
  }
}
