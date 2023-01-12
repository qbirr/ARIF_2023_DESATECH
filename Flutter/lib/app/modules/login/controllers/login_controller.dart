import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  login() async {
    try {
      isLoading.value = true;
      EasyLoading.show();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailC.text, password: passwordC.text);
      EasyLoading.dismiss();
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      EasyLoading.dismiss();
      if (e.code == 'user-not-found') {
        EasyLoading.showError('Email tidak valid!');
      } else if (e.code == 'wrong-password') {
        isLoading.value = false;
        EasyLoading.dismiss();
        EasyLoading.showError('Password tidak valid!');
      } else {
        isLoading.value = false;
        EasyLoading.dismiss();
        EasyLoading.showError(e.message.toString());
      }
    }
  }
}
