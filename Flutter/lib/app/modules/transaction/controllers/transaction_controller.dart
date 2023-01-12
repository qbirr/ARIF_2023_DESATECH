import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:perpustakaan/app/data/models/transaksi_model.dart';

class TransactionController extends GetxController {
  CollectionReference collectionTransaksi =
      FirebaseFirestore.instance.collection('transaksi');
  CollectionReference collectionBuku =
      FirebaseFirestore.instance.collection('books');
  String tanggalTransaksi = DateTime.now().toIso8601String();
  String? selectedBukuId;
  int? selectedBukuJumlah;
  String? selectedBukuJudul;
  String? selectedBukuPenerbit;
  String? selectedBukuPengarang;
  RxBool isLoading = false.obs;

  void clear() {
    tanggal.clear();
    peminjam.clear();
    nisn.clear();
    quantity.clear();
  }

  TextEditingController tanggal = TextEditingController();
  TextEditingController peminjam = TextEditingController();
  TextEditingController nisn = TextEditingController();
  TextEditingController quantity = TextEditingController();

  Stream<List<Transaksi>> streamBukuDipinjam() {
    return collectionTransaksi
        .where('tipe', isEqualTo: 'Dipinjam')
        .orderBy('tanggal', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Transaksi.fromSnapshot(doc)).toList());
  }

  Stream<List<Transaksi>> streamBukuDikembalikan() {
    return collectionTransaksi
        .where('tipe', isEqualTo: 'Kembali')
        .orderBy('tanggal', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Transaksi.fromSnapshot(doc)).toList());
  }

  Future pinjamBuku() async {
    BukuTransaksi bukuTransaksi = BukuTransaksi(
      idBuku: selectedBukuId,
      judul: selectedBukuJudul,
      penerbit: selectedBukuPenerbit,
      pengarang: selectedBukuPengarang,
      quantity: int.parse(quantity.text),
    );
    Transaksi transaksi = Transaksi(
      buku: bukuTransaksi,
      nisn: nisn.text,
      peminjam: peminjam.text,
      tanggal: tanggalTransaksi,
      tipe: 'Dipinjam',
    );
    if (selectedBukuJumlah! <= 0) {
      EasyLoading.showError('Stok buku tidak tersedia!');
    } else if (int.parse(quantity.text) > selectedBukuJumlah!) {
      EasyLoading.showError(
          'Jumlah yang dipinjam lebih banyak dari stok yang tersedia!');
    } else {
      try {
        isLoading.value = true;
        EasyLoading.show();
        await collectionTransaksi.add(transaksi.toMap()).then((value) =>
            collectionTransaksi.doc(value.id).update({'id': value.id}));
        var cekBuku = await collectionBuku.doc(selectedBukuId).get();
        Map<String, dynamic> dataBuku = cekBuku.data() as Map<String, dynamic>;
        await collectionBuku.doc(selectedBukuId).update({
          'dipinjam': dataBuku['dipinjam'] + int.parse(quantity.text),
          'jumlah': dataBuku['jumlah'] - int.parse(quantity.text),
        });
        EasyLoading.dismiss();
        Get.back();
        EasyLoading.showSuccess('Berhasil Meminjamkan Buku!');
      } catch (e) {
        print(e);
        EasyLoading.showError(e.toString());
        isLoading.value = false;
      }
    }
  }

  kembalikanBuku(Transaksi transaksi) async {
    try {
      isLoading.value = true;
      EasyLoading.show();
      await collectionTransaksi.doc(transaksi.id).update({
        'tipe': 'Kembali',
        'kembali': DateTime.now().toIso8601String(),
      });
      var bukusaatini = await collectionBuku.doc(transaksi.buku!.idBuku).get();
      Map<String, dynamic> dataBuku =
          bukusaatini.data() as Map<String, dynamic>;
      await collectionBuku.doc(transaksi.buku!.idBuku).update({
        'dipinjam': dataBuku['dipinjam'] - transaksi.buku!.quantity,
        'jumlah': dataBuku['jumlah'] + transaksi.buku!.quantity,
      });
      EasyLoading.dismiss();
      Get.back();
      Get.back();
      EasyLoading.showSuccess('Buku Berhasil Dikembalikan!');
    } catch (e) {
      EasyLoading.showError(e.toString());
      print(e);
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
