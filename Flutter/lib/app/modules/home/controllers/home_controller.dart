import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:perpustakaan/app/data/models/book_model.dart';

class HomeController extends GetxController {
  CollectionReference books = FirebaseFirestore.instance.collection('books');
  RxBool isLoading = false.obs;
  TextEditingController judulC = TextEditingController();
  TextEditingController penerbitC = TextEditingController();
  TextEditingController pengarangC = TextEditingController();
  TextEditingController jumlahC = TextEditingController();

  void clear() {
    judulC.clear();
    penerbitC.clear();
    pengarangC.clear();
    jumlahC.clear();
  }

  Stream<List<Book>> streamBooks() {
    return books.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Book.fromSnapshot(doc)).toList());
  }

  Future editBook(String id) async {
    try {
      EasyLoading.show();
      isLoading.value = true;
      await books.doc(id).update({
        'judul': judulC.text,
        'penerbit': penerbitC.text,
        'pengarang': pengarangC.text,
        'jumlah': int.parse(jumlahC.text),
      });
      clear();
      Get.back();
      EasyLoading.showSuccess('Berhasil Mengubah Data Buku');

      isLoading.value = false;
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      isLoading.value = false;
      EasyLoading.showError(e.toString());

      print(e);
    }
  }

  Future deleteBook(String id) async {
    try {
      EasyLoading.show();
      isLoading.value = true;
      await books.doc(id).delete();
      clear();
      Get.back();
      Get.back();
      EasyLoading.showSuccess('Buku Berhasil Dihapus');
      isLoading.value = false;
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      isLoading.value = false;
      EasyLoading.showError(e.toString());
      print(e);
    }
  }

  Future addBook() async {
    try {
      EasyLoading.show();
      isLoading.value = true;
      await books.add({
        'judul': judulC.text,
        'penerbit': penerbitC.text,
        'pengarang': pengarangC.text,
        'jumlah': int.parse(jumlahC.text),
        'dipinjam': 0,
      });
      clear();
      EasyLoading.showSuccess('Berhasil Menambahkan Buku');

      isLoading.value = false;
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      isLoading.value = false;
      EasyLoading.showError(e.toString());

      print(e);
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
