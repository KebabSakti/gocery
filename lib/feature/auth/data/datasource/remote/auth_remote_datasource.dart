import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/auth/data/model/auth_model.dart';
import 'package:gocery/feature/auth/data/model/auth_param.dart';
import 'package:gocery/feature/auth/domain/repository/auth_repository.dart';

class AuthRemoteDatasource implements AuthRepository {
  final NetworkImpl _client = Get.find();

  @override
  Future<AuthModel> login(int? firebaseToken) async {
    var _response = await _client
        .post('user/login', data: {'token': firebaseToken.toString()});

    AuthModel _authModel =
        await compute(authModelFromJson, _response.toString());

    return _authModel;
  }

  @override
  Future<AuthModel> register(UserRegisterParam userRegisterParam) async {
    var _response = await _client.post('user/register', data: {
      'name': userRegisterParam.name,
      'email': userRegisterParam.email,
      'password': userRegisterParam.password,
    });

    AuthModel _authModel =
        await compute(authModelFromJson, _response.toString());

    return _authModel;
  }

  @override
  Future<bool> forgotPassword(String email) async {
    await _client.post('user/forgot', data: {'email': email});

    return true;
  }
}
