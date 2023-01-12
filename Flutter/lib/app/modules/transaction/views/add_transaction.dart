import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:perpustakaan/app/constant/constant.dart';
import 'package:perpustakaan/app/data/models/book_model.dart';
import 'package:perpustakaan/app/modules/home/controllers/home_controller.dart';
import 'package:perpustakaan/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddTransaction extends GetView<TransactionController> {
  AddTransaction({super.key});
  final formAddTransaction = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    controller.isLoading.value = false;
    controller.clear();
    controller.tanggal.text =
        DateFormat.yMMMMEEEEd('id_ID').format(DateTime.now());
    controller.tanggalTransaksi = DateTime.now().toIso8601String();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        title: const Text('Tambah Transaksi'),
        centerTitle: true,
      ),
      body: Form(
        key: formAddTransaction,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                readOnly: true,
                controller: controller.tanggal,
                validator: (value) {
                  if (true) {
                    if (value!.isEmpty) {
                      return 'Tanggal Tidak Boleh Kosong!';
                    }
                  }
                  return null;
                },
                autocorrect: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Tanggal'),
                ),
                onTap: () => Get.dialog(
                  Dialog(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      width: Get.width * 0.8,
                      height: Get.width,
                      child: SfDateRangePicker(
                        selectionColor: AppColor.primaryColor,
                        todayHighlightColor: AppColor.primaryColor,
                        cancelText: 'Batal',
                        confirmText: 'Pilih',
                        showActionButtons: true,
                        onCancel: () => Get.back(),
                        onSubmit: (p0) {
                          if (p0 == null) {
                            EasyLoading.showError('Pilih Tanggal');
                          } else {
                            Get.back();
                            controller.tanggal.text =
                                DateFormat.yMMMMEEEEd('id_ID')
                                    .format(DateTime.parse(p0.toString()));
                            controller.tanggalTransaksi = p0.toString();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.peminjam,
                validator: (value) {
                  if (true) {
                    if (value!.isEmpty) {
                      return 'Peminjam Tidak Boleh Kosong!';
                    }
                  }
                  return null;
                },
                autocorrect: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Peminjam'),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.nisn,
                validator: (value) {
                  if (true) {
                    if (value!.isEmpty) {
                      return 'Nisn Tidak Boleh Kosong!';
                    }
                  }
                  return null;
                },
                autocorrect: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Nisn'),
                ),
              ),
              const SizedBox(height: 16),
              StreamBuilder<List<Book>>(
                stream: Get.find<HomeController>().streamBooks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.isNotEmpty) {
                    List<DropdownMenuItem> items = [];
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      Book snap = snapshot.data![i];
                      items.add(
                        DropdownMenuItem(
                          value: snap.idBuku,
                          child: Text(
                            '${snap.judul}\nTersedia : ${snap.jumlah}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }
                    return DropdownButtonFormField2(
                      decoration: const InputDecoration(
                        label: Text('Pilih Buku'),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelStyle:
                            TextStyle(color: AppColor.primaryColor),
                        focusColor: AppColor.primaryColor,
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.primaryColor,
                          ),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      isExpanded: true,
                      hint: const Text('Pilih Buku'),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 56,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      value: controller.selectedBukuId,
                      items: items,
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih Buku!.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        controller.selectedBukuId = value;
                        controller.selectedBukuJudul = snapshot.data!
                            .firstWhere((element) => element.idBuku == value)
                            .judul;
                        controller.selectedBukuPenerbit = snapshot.data!
                            .firstWhere((element) => element.idBuku == value)
                            .penerbit;
                        controller.selectedBukuPengarang = snapshot.data!
                            .firstWhere((element) => element.idBuku == value)
                            .pengarang;
                        controller.selectedBukuJumlah = snapshot.data!
                            .firstWhere((element) => element.idBuku == value)
                            .jumlah;
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.quantity,
                validator: (value) {
                  if (true) {
                    if (value!.isEmpty) {
                      return 'Jumlah Tidak Boleh Kosong!';
                    }
                  }
                  return null;
                },
                autocorrect: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Jumlah'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 56,
                width: Get.width,
                child: ElevatedButton(
                    onPressed: () {
                      if (formAddTransaction.currentState!.validate()) {
                        if (controller.isLoading.isFalse) {
                          controller.pinjamBuku();
                        }
                      }
                    },
                    child: Text(controller.isLoading.isFalse
                        ? 'Buat Transaksi'
                        : 'Loading')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
