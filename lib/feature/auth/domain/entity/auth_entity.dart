import 'package:gocery/feature/auth/data/model/user_model.dart';

abstract class AuthEntity {
  AuthEntity({
    this.userModel,
    this.token,
  });

  final UserModel? userModel;
  final String? token;
}
