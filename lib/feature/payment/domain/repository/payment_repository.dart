import 'package:gocery/feature/payment/domain/entity/payment_detail_entity.dart';

abstract class PaymentRepository {
  Future<PaymentDetailEntity> ewallet();

  Future<PaymentDetailEntity> virtualAccount();

  Future<PaymentDetailEntity> retail();

  Future<PaymentDetailEntity> qr();
}
