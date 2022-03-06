import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/feature/authentication/domain/usecase/authentication_usecase.dart';

class IntroPageController extends GetxController {
  final _authenticationUsecase = AuthenticationUsecase();

  void _authState() async {
    try {
      await _authenticationUsecase.validateUser();

      Get.offAllNamed(kAppPage);
    } catch (_) {
      Get.offAllNamed(kLoginPage);
    }
  }

  Future _cacheAsset() async {
    Future.wait([
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, kGoceryLogo),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, kGoceryLogoTop),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, kGoceryLogoSide),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, kFacebookLogo),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, kGoogleLogo),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, kCoinIcon),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, kOrderComplete),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, kEmptyCart),
        null,
      ),
      precachePicture(
        ExactAssetPicture(
            SvgPicture.svgStringDecoderBuilder, kScrollTopButtonIcon),
        null,
      ),
    ]);
  }

  Future _init() async {
    await _cacheAsset();

    _authState();
  }

  @override
  void onInit() async {
    await _init();

    super.onInit();
  }
}
