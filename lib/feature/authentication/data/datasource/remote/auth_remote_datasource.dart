import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/authentication/data/model/authentication_model.dart';
import 'package:gocery/feature/authentication/data/model/authentication_register_param.dart';

abstract class AuthRemoteDatasource {
  Future<AuthenticationModel> access({required String token});

  Future<AuthenticationModel> register(
      {required AuthenticationRegisterParam param});

  Future<void> revoke();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final NetworkImpl _client = Get.find();

  @override
  Future<AuthenticationModel> access({required String token}) async {
    var _response =
        await _client.post('customer/auth/access', data: {'token': token});

    AuthenticationModel _model =
        await compute(authenticationModelFromJson, _response.toString());

    return _model;
  }

  @override
  Future<AuthenticationModel> register(
      {required AuthenticationRegisterParam param}) async {
    var _response = await _client.post('customer/auth/register', data: {
      'name': param.name,
      'email': param.email,
      'phone': param.phone,
    });

    AuthenticationModel _model =
        await compute(authenticationModelFromJson, _response.toString());

    return _model;
  }

  @override
  Future<void> revoke() async {
    await _client.get('customer/auth/revoke');
  }
}
