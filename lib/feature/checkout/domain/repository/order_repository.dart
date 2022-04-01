import 'package:gocery/feature/checkout/domain/entity/order_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/order_shipping_param_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/payment_channel_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_address_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/shipping_time_entity.dart';
import 'package:gocery/feature/checkout/domain/entity/voucher_entity.dart';

abstract class OrderRepository {
  Future<ShippingAddressEntity> getLastAddress();

  Future<List<OrderShippingEntity>> getOrderShipping(
      {required OrderShippingParamEntity param});

  Future<List<ShippingTimeEntity>> getShippingTimes();

  Future<List<PaymentChannelEntity>> getPaymentChannels();

  Future<PaymentChannelEntity> getDefaultPaymentChannel();

  Future<List<VoucherEntity>> getVouchers();

  Future<void> submitOrder({required OrderEntity param});

  Future<List<ShippingAddressEntity>> placesPredictions({String keyword = ''});
}
