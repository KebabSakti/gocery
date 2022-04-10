import 'package:gocery/feature/checkout/domain/repository/order_repository.dart';

class CancelOrder {
  final OrderRepository repository;

  CancelOrder({required this.repository});

  Future<void> call({required String orderUid}) async {
    await repository.cancelOrder(orderUid: orderUid);
  }
}
