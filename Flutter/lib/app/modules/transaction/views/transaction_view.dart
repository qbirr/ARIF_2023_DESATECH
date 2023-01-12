import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:perpustakaan/app/data/models/transaksi_model.dart';
import 'package:perpustakaan/app/modules/transaction/views/add_transaction.dart';
import 'package:perpustakaan/app/modules/transaction/views/detail_transaction.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transaksi'),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            labelColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  'Dipinjam',
                ),
              ),
              Tab(
                child: Text(
                  'Dikembalikan',
                ),
              ),
            ],
          ),
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
        body: TabBarView(
          children: [
            StreamBuilder<List<Transaksi>>(
              stream: controller.streamBukuDipinjam(),
              builder: (context, snapshotTransaksi) {
                if (snapshotTransaksi.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshotTransaksi.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshotTransaksi.data!.length,
                    itemBuilder: (context, index) {
                      Transaksi transaksi = snapshotTransaksi.data![index];
                      var peminjam = snapshotTransaksi.data![index].peminjam;
                      var nisn = snapshotTransaksi.data![index].nisn;
                      var tanggal = DateFormat.yMMMMd('id_ID').format(
                          DateTime.parse(snapshotTransaksi.data![index].tanggal
                              .toString()));
                      var status = snapshotTransaksi.data![index].tipe;
                      var buku = snapshotTransaksi.data![index].buku!.judul;
                      var qty = snapshotTransaksi.data![index].buku!.quantity;
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const DetailTransaction(),
                                  arguments: transaksi);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 16, right: 16, top: 16),
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(tanggal),
                                      Text('Jumlah Buku : $qty'),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text("Peminjam : $peminjam"),
                                  const SizedBox(height: 6),
                                  Text("Nisn : $nisn"),
                                  const SizedBox(height: 6),
                                  Text('Nama Buku : $buku')
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  print(snapshotTransaksi);
                  return const Center(
                    child: Text('Belum ada buku yang dipinjam'),
                  );
                }
              },
            ),
            StreamBuilder<List<Transaksi>>(
              stream: controller.streamBukuDikembalikan(),
              builder: (context, snapshotTransaksi) {
                if (snapshotTransaksi.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshotTransaksi.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshotTransaksi.data!.length,
                    itemBuilder: (context, index) {
                      Transaksi transaksi = snapshotTransaksi.data![index];
                      var peminjam = snapshotTransaksi.data![index].peminjam;
                      var nisn = snapshotTransaksi.data![index].nisn;
                      var tanggal = DateFormat.yMMMMd('id_ID').format(
                          DateTime.parse(snapshotTransaksi.data![index].kembali
                              .toString()));
                      var status = snapshotTransaksi.data![index].tipe;
                      var buku = snapshotTransaksi.data![index].buku!.judul;
                      var qty = snapshotTransaksi.data![index].buku!.quantity;
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const DetailTransaction(),
                                  arguments: transaksi);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 16, right: 16, top: 16),
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(tanggal),
                                      Text('Jumlah Buku : $qty'),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text("Peminjam : $peminjam"),
                                  const SizedBox(height: 6),
                                  Text("Nisn : $nisn"),
                                  const SizedBox(height: 6),
                                  Text('Nama Buku : $buku')
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
                    child: Text('Belum ada buku yang dikembalikan'),
                  );
                }
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'transaction',
          onPressed: () {
            Get.to(() => AddTransaction());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
