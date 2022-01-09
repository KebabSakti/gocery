import 'package:dio/dio.dart';
import 'package:gocery/core/utility/utility.dart';
import 'package:gocery/feature/auth/data/model/auth_param.dart';
import 'package:gocery/feature/auth/data/model/auth_model.dart';
import 'package:gocery/feature/auth/data/model/fcm_model.dart';
import 'package:gocery/feature/auth/data/model/point_model.dart';
import 'package:gocery/feature/auth/data/model/user_model.dart';
import 'package:gocery/feature/auth/domain/repository/auth_repository.dart';

class AuthMockDatasource implements AuthRepository {
  @override
  Future<AuthModel> login(int? firebaseToken) async {
    return await _getResult<AuthModel>(_getRandomUser());
  }

  @override
  Future<AuthModel> register(UserRegisterParam userRegisterParam) async {
    return await _getResult<AuthModel>(_getRandomUser());
  }

  @override
  Future<bool> forgotPassword(String email) async {
    return await _getResult<bool>(true);
  }

  Future<T> _getResult<T>(T result) async {
    //simulate network connection delay
    await Future.delayed(Utility.randomDuration(min: 1, max: 5));

    //simulate network exception (There's 30% chance exception will thrown on each request)
    if (Utility.randomNumber() > 7) {
      throw DioError(requestOptions: RequestOptions(path: 'dummy_error'));
    }

    return result;
  }

  AuthModel _getRandomUser() {
    final int id = Utility.randomNumber(min: 1, max: 999999);

    final AuthModel _authModel = AuthModel(
      token: Utility.randomUid(),
      userModel: UserModel(
        id: id,
        name: 'Joel ${Utility.randomNumber(min: 1, max: 999999)}',
        email: 'joel_${Utility.randomNumber(min: 1, max: 999999)}@gmail.com',
        phone: '6281254982664',
        fcm: FcmModel(
          customerId: id,
          id: Utility.randomNumber(min: 1, max: 999999),
          token: Utility.randomUid(),
        ),
        point: PointModel(
          customerId: id,
          id: Utility.randomNumber(min: 1, max: 999999),
          point: Utility.randomNumber(min: 1, max: 100),
        ),
      ),
    );

    return _authModel;
  }
}
