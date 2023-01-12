import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:perpustakaan/app/routes/app_pages.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 3),
      () => checkLogin(),
    );
    super.onInit();
  }

  checkLogin() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.offAllNamed(Routes.DASHBOARD);
      }
    });
  }
}
