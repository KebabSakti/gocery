import 'package:gocery/feature/checkout/data/datasource/order_datasource.dart';
import 'package:gocery/feature/checkout/data/model/order_shipping_param_model.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_param_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_entity.dart';
import 'package:gocery/feature/checkout/domain/repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({required this.datasource});

  final OrderDatasource datasource;

  @override
  Future<ShippingAddressEntity> getLastAddress() async {
    return await datasource.getLastAddress();
  }

  @override
  Future<List<OrderShippingEntity>> getOrderShipping(
      {required OrderShippingParamEntity param}) async {
    return await datasource.getOrderShipping(
        param: OrderShippingParamModel.toEntity(param: param));
  }

  @override
  Future<void> submitOrder({required OrderEntity param}) async {
    // await datasource.submitOrder(param: param);
  }
}