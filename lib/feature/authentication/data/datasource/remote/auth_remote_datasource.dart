import 'package:flutter/foundation.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/authentication/data/model/authentication_model.dart';

abstract class AuthRemoteDatasource {
  Future<AuthenticationModel> access({required String token});

  Future<void> revoke();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  AuthRemoteDatasourceImpl({required this.client});

  final Network client;

  @override
  Future<AuthenticationModel> access({required String token}) async {
    var _response = await client.post(kAuthAccess, data: {'token': token});

    AuthenticationModel _model =
        await compute(authenticationModelFromJson, _response.toString());

    return _model;
  }

  @override
  Future<void> revoke() async {
    await client.get(kAuthRevoke);
  }
}
