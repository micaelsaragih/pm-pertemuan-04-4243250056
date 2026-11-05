import 'dart:async';
import 'model.dart';

class Perpustakaan {
  final String nama;
  final List<Koleksi> _koleksi = [];
  final List<Peminjaman> _aktif = [];
  final StreamController<String> _log = StreamController<String>.broadcast();

  Perpustakaan(this.nama);

  Stream<String> get log => _log.stream;
  List<Koleksi> get koleksiTersedia =>
      List.unmodifiable(_koleksi.where((k) => k.tersedia));
  List<Peminjaman> get pinjamanAktif => List.unmodifiable(_aktif);

  void tambah(Koleksi koleksi) {
    if (_koleksi.any((k) => k.kode == koleksi.kode)) {
      throw ArgumentError('Kode ${koleksi.kode} sudah terdaftar');
    }
    _koleksi.add(koleksi);
    _log.add('Koleksi baru: ${koleksi.judul}');
  }

  Future<Peminjaman> pinjam(Anggota anggota, String kode,
      {DateTime? tanggal}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final cocok = _koleksi.where((k) => k.kode == kode);
    if (cocok.isEmpty) throw PeminjamanGagal('kode $kode tidak ditemukan');
    final koleksi = cocok.first;
    if (koleksi is Skripsi) {
      throw PeminjamanGagal('skripsi hanya boleh dibaca di tempat');
    }
    if (!koleksi.tersedia) {
      throw PeminjamanGagal('"${koleksi.judul}" sedang dipinjam');
    }
    final jumlah = _aktif.where((p) => p.anggota.id == anggota.id).length;
    if (jumlah >= anggota.maksPinjam) {
      throw PeminjamanGagal('${anggota.nama} sudah mencapai batas $jumlah pinjaman');
    }
    koleksi.tandaiDipinjam();
    final pinjaman = Peminjaman(anggota, koleksi, tanggal ?? DateTime.now());
    _aktif.add(pinjaman);
    _log.add('${anggota.nama} meminjam "${koleksi.judul}"');
    return pinjaman;
  }

  int kembalikan(Peminjaman pinjaman, {DateTime? tanggal}) {
    if (!_aktif.contains(pinjaman)) {
      throw PeminjamanGagal('data peminjaman tidak aktif');
    }
    final denda = pinjaman.dendaPada(tanggal ?? DateTime.now());
    pinjaman.koleksi.tandaiDikembalikan();
    _aktif.remove(pinjaman);
    _log.add('${pinjaman.anggota.nama} mengembalikan "${pinjaman.koleksi.judul}"');
    return denda;
  }

  Future<void> tutup() => _log.close();
}
