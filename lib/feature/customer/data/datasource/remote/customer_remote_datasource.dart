import 'package:flutter/foundation.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/customer/data/model/customer_account_model.dart';

abstract class CustomerRemoteDatasource {
  Future<void> updateFcm({required String fcmToken});

  Future<CustomerAccountModel> showCustomerAccount();
}

class CustomerRemoteDatasourceImpl implements CustomerRemoteDatasource {
  CustomerRemoteDatasourceImpl({required this.client});

  final Network client;

  @override
  Future<CustomerAccountModel> showCustomerAccount() async {
    var _response = await client.get(kShowCustomerAccount);

    CustomerAccountModel _model =
        await compute(customerAccountModelFromJson, _response.toString());

    return _model;
  }

  @override
  Future<void> updateFcm({required String fcmToken}) async {
    await client.post(kUpdateFcm, data: {"fcm_token": fcmToken});
  }
}
