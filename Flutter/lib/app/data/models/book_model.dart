import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String? idBuku;
  int? dipinjam;
  String? judul;
  int? jumlah;
  String? penerbit;
  String? pengarang;

  Book(
      {this.idBuku,
      this.dipinjam,
      this.judul,
      this.jumlah,
      this.penerbit,
      this.pengarang});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      idBuku: json['idBuku'],
      dipinjam: json['dipinjam'],
      judul: json['judul'],
      jumlah: json['jumlah'],
      penerbit: json['penerbit'],
      pengarang: json['pengarang'],
    );
  }

  factory Book.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map<String, dynamic>;
    return Book(
      idBuku: snapshot.id,
      dipinjam: data['dipinjam'],
      judul: data['judul'],
      jumlah: data['jumlah'],
      penerbit: data['penerbit'],
      pengarang: data['pengarang'],
    );
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      idBuku: map['idBuku'],
      dipinjam: map['dipinjam'],
      judul: map['judul'],
      jumlah: map['jumlah'],
      penerbit: map['penerbit'],
      pengarang: map['pengarang'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idBuku'] = idBuku;
    data['dipinjam'] = dipinjam;
    data['judul'] = judul;
    data['jumlah'] = jumlah;
    data['penerbit'] = penerbit;
    data['pengarang'] = pengarang;
    return data;
  }
}
