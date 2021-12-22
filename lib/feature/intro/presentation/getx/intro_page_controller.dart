import 'package:get/get.dart';
import 'package:gocery/feature/todo/model/user/user_param.dart';
import 'package:gocery/feature/todo/view_model/datasource/user/remote/user_remote_datasource.dart';
import 'package:gocery/feature/todo/view_model/repository/user/user_repository.dart';

class IntroPageController extends GetxController {
  final UserRepository _user = UserRepository(UserRemoteDatasource());

  Future init() async {
    await _user.login(UserLoginParam(
      email: 'my.meww@gmail.com',
      password: '12345678',
    ));
  }

  @override
  void onInit() async {
    await init();

    super.onInit();
  }
}
