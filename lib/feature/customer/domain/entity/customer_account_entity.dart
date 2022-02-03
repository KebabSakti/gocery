import 'package:gocery/feature/customer/domain/entity/customer_fcm_entity.dart';
import 'package:gocery/feature/customer/domain/entity/customer_point_entity.dart';
import 'package:gocery/feature/customer/domain/entity/customer_profile_entity.dart';

abstract class CustomerAccountEntity {
  CustomerAccountEntity({
    this.uid,
    this.username,
    this.customerProfileEntity,
    this.customerPointEntity,
    this.customerFcmEntity,
  });

  final String? uid;
  final String? username;
  final CustomerProfileEntity? customerProfileEntity;
  final CustomerPointEntity? customerPointEntity;
  final CustomerFcmEntity? customerFcmEntity;
}
