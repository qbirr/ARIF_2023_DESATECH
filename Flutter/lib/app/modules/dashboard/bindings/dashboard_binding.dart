import 'package:get/get.dart';
import 'package:perpustakaan/app/modules/home/controllers/home_controller.dart';
import 'package:perpustakaan/app/modules/transaction/controllers/transaction_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.put(HomeController(), permanent: true);
    Get.put(TransactionController(), permanent: true);
  }
}
