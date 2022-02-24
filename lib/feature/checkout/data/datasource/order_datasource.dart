import 'package:gocery/feature/checkout/data/model/order_model.dart';
import 'package:gocery/feature/checkout/data/model/order_shipping_model.dart';
import 'package:gocery/feature/checkout/data/model/order_shipping_param_model.dart';
import 'package:gocery/feature/checkout/data/model/shipping_address_model.dart';

abstract class OrderDatasource {
  Future<ShippingAddressModel> getLastAddress();

  Future<List<OrderShippingModel>> getOrderShipping(
      {required OrderShippingParamModel param});

  Future<void> submitOrder({required OrderModel param});
}
