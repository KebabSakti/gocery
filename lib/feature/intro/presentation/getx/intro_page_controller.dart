import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';

class IntroPageController extends GetxController {
  Future _init() async {
    await Future.delayed(const Duration(seconds: 1));

    await _cacheAsset();

    Get.offAllNamed(kLandingPage);
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
    ]);
  }

  @override
  void onInit() async {
    await _init();

    super.onInit();
  }
}
