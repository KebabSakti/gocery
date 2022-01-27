import 'package:gocery/feature/customer/data/model/customer_profile_model.dart';

abstract class CustomerAccountEntity {
  CustomerAccountEntity({
    this.uid,
    this.username,
    this.customerProfileModel,
  });

  final String? uid;
  final String? username;
  final CustomerProfileModel? customerProfileModel;
}
