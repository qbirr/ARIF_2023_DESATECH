import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpustakaan/app/constant/constant.dart';
import 'package:perpustakaan/app/modules/home/controllers/home_controller.dart';

class AddBookView extends GetView<HomeController> {
  final addBookKey = GlobalKey<FormState>();

  AddBookView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.clear();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text('Tambah Buku'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: addBookKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: controller.judulC,
                  validator: (value) {
                    if (true) {
                      if (value!.isEmpty) {
                        return 'Judul Tidak Boleh Kosong!';
                      }
                    }
                    return null;
                  },
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Judul'),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.penerbitC,
                  validator: (value) {
                    if (true) {
                      if (value!.isEmpty) {
                        return 'Penerbit Tidak Boleh Kosong!';
                      }
                    }
                    return null;
                  },
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Penerbit'),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.pengarangC,
                  validator: (value) {
                    if (true) {
                      if (value!.isEmpty) {
                        return 'Pengarang Tidak Boleh Kosong!';
                      }
                    }
                    return null;
                  },
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Pengarang'),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.jumlahC,
                  validator: (value) {
                    if (true) {
                      if (value!.isEmpty) {
                        return 'Jumlah Buku Tidak Boleh Kosong!';
                      }
                    }
                    return null;
                  },
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Jumlah Buku'),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 56,
                  width: Get.width,
                  child: ElevatedButton(
                      onPressed: () {
                        if (addBookKey.currentState!.validate()) {
                          if (controller.isLoading.isFalse) {
                            controller.addBook();
                          }
                        }
                      },
                      child: Text(
                          controller.isLoading.isFalse ? 'Tambah' : 'Loading')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
