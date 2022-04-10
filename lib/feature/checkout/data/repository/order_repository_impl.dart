import 'package:gocery/feature/checkout/data/datasource/order_datasource.dart';
import 'package:gocery/feature/checkout/data/model/order_shipping_param_model.dart';
import 'package:gocery/feature/checkout/domain/entity/order_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_param_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/payment_channel_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_time_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/voucher_entity.dart';
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
  Future<List<ShippingTimeEntity>> getShippingTimes() async {
    return await datasource.getShippingTimes();
  }

  @override
  Future<List<PaymentChannelEntity>> getPaymentChannels() async {
    return await datasource.getPaymentChannels();
  }

  @override
  Future<PaymentChannelEntity> getDefaultPaymentChannel() async {
    return await datasource.getDefaultPaymentChannel();
  }

  @override
  Future<List<VoucherEntity>> getVouchers() async {
    return await datasource.getVouchers();
  }

  @override
  Future<void> submitOrder({required OrderEntity param}) async {
    await datasource.submitOrder(param: param);
  }

  @override
  Future<List<ShippingAddressEntity>> placesPredictions(
      {String keyword = ''}) async {
    return await datasource.placesPredictions(keyword: keyword);
  }

  @override
  Future<void> cancelOrder({required String orderUid}) async {
    await datasource.cancelOrder(orderUid: orderUid);
  }
}
