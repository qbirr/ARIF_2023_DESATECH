import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perpustakaan/app/constant/constant.dart';
import 'package:perpustakaan/app/modules/transaction/views/transaction_view.dart';
import 'package:perpustakaan/app/modules/home/views/home_view.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (context) {
      return Scaffold(
        body: Center(
          child: IndexedStack(
            index: controller.tabIndex,
            children: const [
              HomeView(),
              TransactionView(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex,
          selectedItemColor: AppColor.primaryColor,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: [
            _bottomNavBarItem(
              icon: const Icon(Icons.home_filled),
              label: "Beranda",
            ),
            _bottomNavBarItem(
              icon: const Icon(Icons.archive_sharp),
              label: "Transaksi",
            ),
          ],
        ),
      );
    });
  }

  _bottomNavBarItem({required Icon icon, required String label}) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }
}
