import 'package:gocery/feature/customer/data/model/customer_profile_model.dart';
import 'package:gocery/feature/customer/domain/entity/customer_account_entity.dart';

class CustomerAccountModel extends CustomerAccountEntity {
  CustomerAccountModel({
    String? uid,
    String? username,
    CustomerProfileModel? customerProfileModel,
  }) : super(
          uid: uid,
          username: username,
          customerProfileModel: customerProfileModel,
        );

  CustomerAccountModel copyWith({
    String? uid,
    String? username,
    CustomerProfileModel? customerProfileModel,
  }) =>
      CustomerAccountModel(
        uid: uid ?? this.uid,
        username: username ?? this.username,
        customerProfileModel: customerProfileModel ?? this.customerProfileModel,
      );

  factory CustomerAccountModel.fromJson(Map<String, dynamic> json) =>
      CustomerAccountModel(
        uid: json["uid"],
        username: json["username"],
        customerProfileModel:
            CustomerProfileModel.fromJson(json["customer_profile_model"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "customer_profile_model": customerProfileModel?.toJson(),
      };
}
