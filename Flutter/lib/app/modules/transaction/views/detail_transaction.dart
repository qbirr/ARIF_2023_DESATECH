import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:perpustakaan/app/data/models/transaksi_model.dart';
import 'package:perpustakaan/app/modules/transaction/controllers/transaction_controller.dart';

class DetailTransaction extends GetView<TransactionController> {
  const DetailTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final Transaksi transaksi = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Transaksi"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.numbers,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "NISN : ${transaksi.nisn!}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                WidgetStatus(
                    status: transaksi.tipe == 'Kembali'
                        ? 'Dikembalikan'
                        : 'Dipinjam'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Nama : ${transaksi.peminjam!}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Tanggal Dipinjam : ${DateFormat.yMMMMd('id_ID').format(DateTime.parse(transaksi.tanggal!))}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            transaksi.tipe == 'Kembali'
                ? Column(
                    children: [
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Tanggal Dikembalikan : ${DateFormat.yMMMMd('id_ID').format(DateTime.parse(transaksi.kembali!))}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Text(
              'Judul Buku : ${transaksi.buku!.judul}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              "Penerbit : ${transaksi.buku!.penerbit}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              'Pengarang : ${transaksi.buku!.pengarang}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              'Jumlah Dipinjam : ${transaksi.buku!.quantity} Buku',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            transaksi.tipe == 'Dipinjam'
                ? SizedBox(
                    width: Get.width,
                    height: 56,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.defaultDialog(
                              title: 'Kembalikan Buku',
                              middleText: 'Kembalikan Buku Yang Dipinjam?',
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text('Batal')),
                                ElevatedButton(
                                    onPressed: () {
                                      controller.kembalikanBuku(transaksi);
                                    },
                                    child: const Text('Ya'))
                              ]);
                        },
                        child: const Text('Kembalikan')),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

class WidgetStatus extends StatelessWidget {
  String status;
  WidgetStatus({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.blueAccent),
      child: Text(
        status,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
