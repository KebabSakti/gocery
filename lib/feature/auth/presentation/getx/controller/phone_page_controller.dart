import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/core/service/storage/storage.dart';
import 'package:gocery/core/utility/mdialog.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/auth/data/model/auth_param.dart';
import 'package:gocery/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:gocery/feature/auth/domain/usecase/login_usecase.dart';
import 'package:gocery/feature/auth/presentation/getx/controller/auth_controller.dart';

class PhonePageController extends GetxController {
  String? phone;

  final _loginUsecase = LoginUsecase(
    secureStorage: Get.find<SecureStorageImpl>(),
    authRepository: Get.find<AuthRepositoryImpl>(),
  );

  void sendCodePressed() async {
    try {
      if (Get.find<AuthController>().timerStarted()) {
        Get.toNamed(
          kOtpPage,
          arguments: Get.find<AuthController>().phoneLoginParam,
        );
      } else {
        if (phone == null) {
          throw Failure('No hp tidak boleh kosong');
        }

        if (phone!.isEmpty) {
          throw Failure('No hp tidak boleh kosong');
        }

        MDialog.loading();

        await _loginUsecase.phoneLogin(
          phone!,
          codeSent: (verificationId, resendToken) {
            MDialog.close();

            Get.find<AuthController>().phoneLoginParam = PhoneLoginParam(
              phoneNumber: phone!,
              verificationId: verificationId,
              resendToken: resendToken,
            );

            Get.toNamed(kOtpPage);
          },
        );
      }
    } on Failure catch (e) {
      MDialog.close();

      MToast.show(e.message);
    }
  }
}
