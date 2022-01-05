import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/feature/auth/presentation/getx/controller/phone_page_controller.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhonePage extends StatelessWidget {
  const PhonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: PhonePageController(),
        builder: (PhonePageController c) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 61),
              child: Column(
                children: [
                  Text(
                    'Masukkan No Hp',
                    style: Get.theme.textTheme.headline4,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: Get.size.width / 1.3,
                    child: Text(
                      'Kami akan mengirimkan kode OTP ke no anda',
                      textAlign: TextAlign.center,
                      style: Get.theme.textTheme.headline6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff8F9BB3),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InternationalPhoneNumberInput(
                      autoFocus: true,
                      countries: const ['ID'],
                      spaceBetweenSelectorAndTextField: 0,
                      textStyle: const TextStyle(fontSize: 18),
                      errorMessage: 'No hp tidak valid',
                      selectorConfig: const SelectorConfig(
                        setSelectorButtonAsPrefixIcon: true,
                      ),
                      inputDecoration: InputDecoration(
                        hintText: '812-5498-2664',
                        hintStyle: Get.theme.textTheme.bodyText2,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      onInputChanged: (phone) {
                        c.phone = phone.phoneNumber;
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: Container(
              color: Get.theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: c.sendCodePressed,
                  child: const Text('Masukkan Kode'),
                ),
              ),
            ),
          );
        });
  }
}
