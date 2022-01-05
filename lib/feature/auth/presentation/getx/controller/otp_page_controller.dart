import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gocery/core/service/error/failure.dart';
import 'package:gocery/core/service/storage/storage.dart';
import 'package:gocery/core/utility/mdialog.dart';
import 'package:gocery/core/utility/mtoast.dart';
import 'package:gocery/feature/auth/data/model/auth_model.dart';
import 'package:gocery/feature/auth/data/model/auth_param.dart';
import 'package:gocery/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:gocery/feature/auth/domain/usecase/login_usecase.dart';
import 'package:gocery/feature/auth/presentation/getx/controller/auth_controller.dart';

class OtpPageController extends GetxController {
  String? otpCode;

  final _loginUsecase = LoginUsecase(
    secureStorage: Get.find<SecureStorageImpl>(),
    authRepository: Get.find<AuthRepositoryImpl>(),
  );

  void sendPressed() async {
    try {
      if (otpCode == null) {
        throw Failure('Masukkan kode OTP yang dikirim ke no anda');
      }

      if (otpCode!.length < 6) {
        throw Failure('Kode OTP memerlukan 6 digit angka');
      }

      MDialog.loading();

      PhoneAuthCredential _phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId:
            Get.find<AuthController>().phoneLoginParam!.verificationId!,
        smsCode: otpCode!,
      );

      UserCredential _firebaseUserCredential =
          await _loginUsecase.signInWithCredential(_phoneAuthCredential);

      AuthModel _authModel = await _loginUsecase
          .grantAccessToken(_firebaseUserCredential.credential?.token);

      await _loginUsecase.saveUserToSecureLocalStorage(_authModel);
    } on Failure catch (e) {
      MDialog.close();

      MToast.show(e.message);
    }
  }

  void resendPressed() async {
    try {
      MDialog.loading();

      await _loginUsecase.phoneLogin(
        Get.find<AuthController>().phoneLoginParam!.phoneNumber!,
        resendToken: Get.find<AuthController>().phoneLoginParam!.resendToken,
        codeSent: (verificationId, resendToken) async {
          MDialog.close();

          Get.find<AuthController>().phoneLoginParam = PhoneLoginParam(
            phoneNumber:
                Get.find<AuthController>().phoneLoginParam!.phoneNumber,
            verificationId: verificationId,
            resendToken: resendToken,
          );

          MToast.show('Kode OTP berhasil terkirim ke no anda');
        },
      );
    } on Failure catch (e) {
      MDialog.close();

      MToast.show(e.message);
    }
  }

  @override
  void onInit() {
    Get.find<AuthController>().startOtpTimer(60);

    super.onInit();
  }
}
