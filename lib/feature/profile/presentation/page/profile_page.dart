import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/config/app_icons.dart';
import 'package:gocery/core/utility/mdialog.dart';
import 'package:gocery/feature/authentication/domain/usecase/authentication_usecase.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authUsecase = AuthenticationUsecase();

    return SafeArea(
      child: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: kLargePadding),
            decoration: const BoxDecoration(
              color: kLightColor,
              border: Border(bottom: BorderSide(color: kLightColor50)),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  maxRadius: 50,
                  backgroundImage: CachedNetworkImageProvider(
                    'http://4.bp.blogspot.com/-C-RFJkQ5Rdo/TqJcZf6LawI/AAAAAAAAAEY/I2GRCN43URY/s1600/Brad-pitt.jpg',
                  ),
                ),
                const SizedBox(height: kMediumPadding),
                Text(
                  'Bradd Pitt',
                  style: Get.theme.textTheme.headline3,
                ),
                const SizedBox(height: kTinyPadding),
                Text(
                  'bradd@gmail.com',
                  style: Get.theme.textTheme.bodyText2,
                ),
              ],
            ),
          ),
          const SizedBox(height: kMediumPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kLightColor50),
                ),
                child: Column(
                  children: [
                    InkWell(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(kMediumPadding),
                        child: _settingItem(
                            icon: AppIcon.bell, name: 'Pengaturan Notifikasi'),
                      ),
                    ),
                    const Divider(height: 1),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(kMediumPadding),
                        child: _settingItem(
                            icon: AppIcon.heart, name: 'Produk Favorit'),
                      ),
                    ),
                    const Divider(height: 1),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(kMediumPadding),
                        child: _settingItem(
                            icon: AppIcon.arrowup, name: 'Berikan Rating'),
                      ),
                    ),
                    const Divider(height: 1),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(kMediumPadding),
                        child: _settingItem(
                            icon: AppIcon.share, name: 'Bagikan Ke Teman'),
                      ),
                    ),
                    const Divider(height: 1),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(kMediumPadding),
                        child: _settingItem(
                            icon: AppIcon.note, name: 'Syarat dan Ketentuan'),
                      ),
                    ),
                    const Divider(height: 1),
                    InkWell(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(kMediumPadding),
                        child: _settingItem(
                            icon: AppIcon.infocircle, name: 'Bantuan'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: kMediumPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () async {
                  MDialog.loading();

                  await _authUsecase.logout();

                  Get.offAllNamed(kIntroPage);
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kLightColor50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(kMediumPadding),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: Container(
                            decoration: BoxDecoration(
                                color: kLightColor50,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Icon(
                              AppIcon.signout,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: kMediumPadding),
                        Text(
                          'Log Out',
                          style: Get.theme.textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: kMediumPadding),
        ],
      ),
    );
  }
}

Widget _settingItem({required IconData icon, required String name}) {
  return Row(
    children: [
      SizedBox(
        width: 32,
        height: 32,
        child: Container(
          decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              borderRadius: BorderRadius.circular(12)),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      const SizedBox(width: 16),
      Text(
        name,
        style: Get.theme.textTheme.bodyText2!.copyWith(
          color: const Color(0xff222B45),
          fontWeight: FontWeight.w600,
        ),
      ),
      const Spacer(),
      const Icon(
        Icons.chevron_right_rounded,
        size: 20,
        color: Colors.grey,
      ),
    ],
  );
}
