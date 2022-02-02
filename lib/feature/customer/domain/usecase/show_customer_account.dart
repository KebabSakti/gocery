import 'package:gocery/feature/customer/domain/entity/customer_account_entity.dart';
import 'package:gocery/feature/customer/domain/repository/customer_repository.dart';

class ShowCustomerAccount {
  ShowCustomerAccount({required this.repository});

  final CustomerRepository repository;

  Future<CustomerAccountEntity> call() async {
    return await repository.showCustomerAccount();
  }
}
