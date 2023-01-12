import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:perpustakaan/app/constant/constant.dart';
import 'package:perpustakaan/app/data/models/book_model.dart';
import 'package:perpustakaan/app/modules/home/views/add_book.dart';
import 'package:perpustakaan/app/modules/home/views/edit_book.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: const Text('Data Buku'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    middleText: 'Yakin akan keluar?',
                    title: 'Logout',
                    actions: [
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        child: const Text('Batal'),
                      ),
                      ElevatedButton(
                        onPressed: () => controller.logout(),
                        child: const Text('Logout'),
                      ),
                    ],
                  );
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<List<Book>>(
            stream: controller.streamBooks(),
            builder: (context, snapshotBooks) {
              if (snapshotBooks.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshotBooks.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshotBooks.data!.length,
                  itemBuilder: (context, index) {
                    Book buku = snapshotBooks.data![index];
                    var judul = snapshotBooks.data![index].judul;
                    var dipinjam = snapshotBooks.data![index].dipinjam;
                    var jumlah = snapshotBooks.data![index].jumlah;
                    var penerbit = snapshotBooks.data![index].penerbit;
                    var pengarang = snapshotBooks.data![index].pengarang;
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => EditBookView(), arguments: buku);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  offset: const Offset(1, 1),
                                  color: Colors.black.withOpacity(0.1),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Judul Buku: $judul"),
                                const SizedBox(height: 6),
                                Text("Penerbit : $penerbit"),
                                const SizedBox(height: 6),
                                Text("Pengarang : $pengarang"),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Dipinjam : $dipinjam",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Stok Buku : $jumlah",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('Belum ada buku'),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'books',
          onPressed: () {
            Get.to(() => AddBookView());
          },
          child: const Icon(Icons.add),
        ));
  }
}
