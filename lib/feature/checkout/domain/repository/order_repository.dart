import 'package:gocery/feature/checkout/domain/entity/order_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_param_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';

abstract class OrderRepository {
  Future<ShippingAddressEntity> getLastAddress();

  Future<List<OrderShippingEntity>> getOrderShipping(
      {required OrderShippingParamEntity param});

  Future<void> submitOrder({required OrderEntity param});
}
