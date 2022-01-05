import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocery/feature/auth/presentation/getx/controller/register_page_controller.dart';
import 'package:gocery/feature/auth/presentation/widget/auth_form_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: RegisterPageController(),
        builder: (RegisterPageController c) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Column(
                      children: [
                        Text(
                          'Daftar Baru',
                          style: Get.theme.textTheme.headline4,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: Get.size.width / 1.3,
                          child: Text(
                            'Isi informasi akun anda di bawah',
                            textAlign: TextAlign.center,
                            style: Get.theme.textTheme.headline6,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: c.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AuthFormField(
                            hintText: 'Nama',
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama tidak boleh kosong';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          AuthFormField(
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email tidak boleh kosong';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          AuthFormField(
                            hintText: 'Password',
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password tidak boleh kosong';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          InternationalPhoneNumberInput(
                            countries: const ['ID'],
                            spaceBetweenSelectorAndTextField: 0,
                            textStyle: const TextStyle(fontSize: 18),
                            errorMessage: 'No hp tidak valid',
                            selectorConfig: const SelectorConfig(
                              setSelectorButtonAsPrefixIcon: true,
                              leadingPadding: 14,
                            ),
                            inputDecoration: InputDecoration(
                              hintText: '812-5498-2664',
                              hintStyle: Get.theme.textTheme.bodyText2,
                              contentPadding: const EdgeInsets.all(0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xff8F9BB3),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xff8F9BB3),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xff8F9BB3),
                                ),
                              ),
                            ),
                            onInputChanged: (phone) {},
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: c.formOnSubmit,
                              child: const Text('Daftar'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
