import 'package:gocery/feature/auth/data/model/auth_model.dart';
import 'package:gocery/feature/auth/data/model/auth_param.dart';
import 'package:gocery/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final AuthRepository _dataSource;

  @override
  Future<AuthModel> login(int? firebaseToken) async {
    return await _dataSource.login(firebaseToken);
  }

  @override
  Future<AuthModel> register(UserRegisterParam userRegisterParam) async {
    return await _dataSource.register(userRegisterParam);
  }

  @override
  Future<bool> forgotPassword(String email) async {
    return await _dataSource.forgotPassword(email);
  }
}
