import 'package:gocery/feature/checkout/domain/entity/payment_channel_entity.dart';
import 'package:gocery/feature/checkout/domain/repository/order_repository.dart';

class GetPaymentChannel {
  GetPaymentChannel({required this.repository});

  final OrderRepository repository;

  Future<List<PaymentChannelEntity>> call() async {
    return await repository.getPaymentChannels();
  }
}
