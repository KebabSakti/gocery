import 'package:gocery/feature/customer/domain/entity/customer_account_entity.dart';

abstract class CustomerRepository {
  Future<void> updateFcm({required String fcmToken});

  Future<CustomerAccountEntity> showCustomerAccount();
}
