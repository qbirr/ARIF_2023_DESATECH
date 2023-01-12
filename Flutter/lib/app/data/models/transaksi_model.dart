import 'package:cloud_firestore/cloud_firestore.dart';

class Transaksi {
  String? id;
  String? tanggal;
  String? kembali;
  String? tipe;
  BukuTransaksi? buku;
  String? peminjam;
  String? nisn;

  Transaksi({
    this.id,
    this.tanggal,
    this.kembali,
    this.tipe,
    this.buku,
    this.peminjam,
    this.nisn,
  });

  Transaksi.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    tanggal = map['tanggal'];
    kembali = map['kembali'];
    tipe = map['tipe'];
    buku = map['buku'];
    peminjam = map['peminjam'];
    nisn = map['nisn'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tanggal': tanggal,
      'kembali': kembali,
      'tipe': tipe,
      'buku': buku!.toMap(),
      'peminjam': peminjam,
      'nisn': nisn,
    };
  }

  factory Transaksi.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    return Transaksi(
      id: data['id'],
      peminjam: data['peminjam'] ?? '',
      tipe: data['tipe'],
      tanggal: data['tanggal'],
      kembali: data['kembali'],
      nisn: data['nisn'],
      buku: BukuTransaksi.fromMap(data['buku']),
    );
  }
}

class BukuTransaksi {
  String? idBuku;
  String? judul;
  String? penerbit;
  String? pengarang;
  int? quantity;

  BukuTransaksi({
    this.idBuku,
    this.judul,
    this.penerbit,
    this.pengarang,
    this.quantity,
  });
  BukuTransaksi.fromMap(Map<String, dynamic> map) {
    idBuku = map['idBuku'];
    judul = map['judul'];
    penerbit = map['penerbit'];
    pengarang = map['pengarang'];
    quantity = map['quantity'];
  }

  Map<String, dynamic> toMap() {
    return {
      'idBuku': idBuku,
      'judul': judul,
      'penerbit': penerbit,
      'pengarang': pengarang,
      'quantity': quantity,
    };
  }
}
