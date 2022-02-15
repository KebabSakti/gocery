import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gocery/feature/customer/data/datasource/remote/customer_remote_datasource.dart';
import 'package:gocery/feature/customer/domain/entity/customer_account_entity.dart';
import 'package:gocery/feature/customer/domain/repository/customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  CustomerRepositoryImpl({required this.remoteDatasource});

  final CustomerRemoteDatasource remoteDatasource;

  @override
  Future<CustomerAccountEntity> showCustomerAccount() async {
    return await remoteDatasource.showCustomerAccount();
  }

  @override
  Future<void> updateFcm() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (fcmToken != null) {
      await remoteDatasource.updateFcm(fcmToken: fcmToken);
    }
  }
}
