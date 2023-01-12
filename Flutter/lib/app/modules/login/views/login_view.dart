import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perpustakaan/app/constant/constant.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final loginKey = GlobalKey<FormState>();
  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: loginKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Get.height * 0.1),
                  SizedBox(
                    width: Get.width * 0.5,
                    child: Image.asset(AppImage.logo),
                  ),
                  const Text(
                    'Aplikasi Manajemen Perpustakaan',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Silahkan Login',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: controller.emailC,
                    validator: (value) {
                      if (true) {
                        if (value!.isEmpty) {
                          return 'Email Tidak Boleh Kosong!';
                        }
                      }
                      return null;
                    },
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Email'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                    () => TextFormField(
                      controller: controller.passwordC,
                      validator: (value) {
                        if (true) {
                          if (value!.isEmpty) {
                            return 'Password Tidak Boleh Kosong!';
                          }
                        }
                        return null;
                      },
                      autocorrect: false,
                      obscureText: controller.isHidden.value,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: const Text('Password'),
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller.isHidden.toggle();
                              },
                              icon: controller.isHidden.isTrue
                                  ? const Icon(Icons.remove_red_eye)
                                  : const Icon(Icons.remove_red_eye_outlined))),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 56,
                    width: Get.width,
                    child: ElevatedButton(
                        onPressed: () {
                          if (loginKey.currentState!.validate()) {
                            if (controller.isLoading.isFalse) {
                              controller.login();
                            }
                          }
                        },
                        child: Text(controller.isLoading.isFalse
                            ? 'Login'
                            : 'Loading')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
