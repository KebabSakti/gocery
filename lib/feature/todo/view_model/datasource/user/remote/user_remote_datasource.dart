import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/feature/todo/model/user/user_param.dart';
import 'package:gocery/feature/todo/model/user/auth_model.dart';
import 'package:gocery/feature/todo/view_model/entity/user/user_entity.dart';

class UserRemoteDatasource implements UserEntity {
  final NetworkImpl client = Get.find();

  @override
  Future<AuthModel> login(UserLoginParam userLoginParam) async {
    try {
      var response = await client.post('user/login', data: {
        'email': userLoginParam.email,
        'password': userLoginParam.password,
      });

      return compute(authModelFromJson, response.toString());
    } catch (e) {
      debugPrint(e.toString());

      return AuthModel();
    }
  }

  @override
  Future<AuthModel> register(UserRegisterParam userRegisterParam) async {
    // TODO: implement register
    throw UnimplementedError();
  }
}
