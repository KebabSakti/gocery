import 'package:gocery/feature/checkout/data/model/order_shipping_model.dart';
import 'package:gocery/feature/checkout/data/model/order_shipping_param_model.dart';
import 'package:gocery/feature/checkout/data/model/payment_channel_model.dart';
import 'package:gocery/feature/checkout/data/model/shipping_address_model.dart';
import 'package:gocery/feature/checkout/data/model/shipping_time_model.dart';
import 'package:gocery/feature/checkout/data/model/voucher_model.dart';
import 'package:gocery/feature/checkout/domain/entity/order_entity.dart';

abstract class OrderDatasource {
  Future<ShippingAddressModel> getLastAddress();

  Future<List<OrderShippingModel>> getOrderShipping(
      {required OrderShippingParamModel param});

  Future<List<ShippingTimeModel>> getShippingTimes();

  Future<List<PaymentChannelModel>> getPaymentChannels();

  Future<PaymentChannelModel> getDefaultPaymentChannel();

  Future<List<VoucherModel>> getVouchers();

  Future<void> submitOrder({required OrderEntity param});

  Future<List<ShippingAddressModel>> placesPredictions({String keyword = ''});
}
