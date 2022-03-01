import 'package:gocery/feature/checkout/domain/entity/voucher_entity.dart';
import 'package:gocery/feature/checkout/domain/repository/order_repository.dart';

class GetVouchers {
  GetVouchers({required this.repository});

  final OrderRepository repository;

  Future<List<VoucherEntity>> call() async {
    return await repository.getVouchers();
  }
}
