import 'package:gocery/core/model/fcm_token_model.dart';
import 'package:gocery/core/model/point_model.dart';
import 'package:gocery/feature/customer/data/model/customer_profile_model.dart';

abstract class CustomerAccountEntity {
  CustomerAccountEntity({
    this.uid,
    this.username,
    this.customerProfileModel,
    this.pointModel,
    this.fcmTokenModel,
  });

  final String? uid;
  final String? username;
  final CustomerProfileModel? customerProfileModel;
  final PointModel? pointModel;
  final FcmTokenModel? fcmTokenModel;
}
