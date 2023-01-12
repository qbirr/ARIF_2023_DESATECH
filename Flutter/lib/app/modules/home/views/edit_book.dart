import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perpustakaan/app/constant/constant.dart';
import 'package:perpustakaan/app/data/models/book_model.dart';
import 'package:perpustakaan/app/modules/home/controllers/home_controller.dart';

class EditBookView extends GetView<HomeController> {
  final editBookKey = GlobalKey<FormState>();
  final Book buku = Get.arguments;
  EditBookView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.clear();
    controller.judulC.text = buku.judul!;
    controller.penerbitC.text = buku.penerbit!;
    controller.pengarangC.text = buku.pengarang!;
    controller.jumlahC.text = buku.jumlah.toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text('Detail Buku'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: editBookKey,
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
                        if (editBookKey.currentState!.validate()) {
                          if (controller.isLoading.isFalse) {
                            controller.editBook(buku.idBuku!);
                          }
                        }
                      },
                      child: Text(
                          controller.isLoading.isFalse ? 'Ubah' : 'Loading')),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 56,
                  width: Get.width,
                  child: ElevatedButton(
                      onPressed: () {
                        if (editBookKey.currentState!.validate()) {
                          if (controller.isLoading.isFalse) {
                            Get.defaultDialog(
                              middleText: 'Yakin Menghapus Buku Ini?',
                              title: 'Hapus Buku',
                              actions: [
                                ElevatedButton(
                                  onPressed: () => Get.back(),
                                  child: const Text('Batal'),
                                ),
                                ElevatedButton(
                                  onPressed: () =>
                                      controller.deleteBook(buku.idBuku!),
                                  child: const Text('Hapus'),
                                ),
                              ],
                            );
                            // controller.deleteBook(buku.idBuku!);
                          }
                        }
                      },
                      child: Text(
                          controller.isLoading.isFalse ? 'Hapus' : 'Loading')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
