// Seluruh subtipe sealed wajib dideklarasikan dalam library yang sama.
sealed class Koleksi {
  final String kode;
  final String judul;
  bool _dipinjam = false;

  Koleksi(this.kode, this.judul);

  int get lamaPinjam;
  bool get tersedia => !_dipinjam;
  String info() => '[$kode] $judul';

  // Field privat tidak dapat diakses dari library perpustakaan.dart.
  void tandaiDipinjam() => _dipinjam = true;
  void tandaiDikembalikan() => _dipinjam = false;
}

mixin BisaDiunduh {
  String get url;
  String unduh() => 'Mengunduh dari $url ...';
}

class Buku extends Koleksi {
  final String penulis;
  Buku(super.kode, super.judul, this.penulis);
  @override
  int get lamaPinjam => 14;
  @override
  String info() => '${super.info()} oleh $penulis';
}

class Majalah extends Koleksi {
  final int edisi;
  Majalah(super.kode, super.judul, this.edisi);
  @override
  int get lamaPinjam => 7;
  @override
  String info() => '${super.info()} edisi $edisi';
}

class EBook extends Buku with BisaDiunduh {
  @override
  final String url;
  EBook(super.kode, super.judul, super.penulis, this.url);
  @override
  int get lamaPinjam => 30;
}

class Skripsi extends Koleksi {
  final String penulis;
  Skripsi(super.kode, super.judul, this.penulis);
  @override
  int get lamaPinjam => 0;
  @override
  String info() => '${super.info()} (baca di tempat) oleh $penulis';
}

// Exhaustive switch: compiler mengingatkan jika ada subtipe baru.
String ikon(Koleksi koleksi) => switch (koleksi) {
      EBook() => '📱',
      Buku() => '📕',
      Majalah() => '📰',
      Skripsi() => '🎓',
    };

class Anggota {
  final String id;
  final String nama;
  final int maksPinjam;
  Anggota(this.id, this.nama, {this.maksPinjam = 2}) {
    if (maksPinjam < 1) throw ArgumentError('Batas pinjam minimal 1');
  }
}

class Peminjaman {
  final Anggota anggota;
  final Koleksi koleksi;
  final DateTime tanggal;
  Peminjaman(this.anggota, this.koleksi, this.tanggal);

  DateTime get jatuhTempo => tanggal.add(Duration(days: koleksi.lamaPinjam));

  int dendaPada(DateTime kembali) {
    final telat = kembali.difference(jatuhTempo).inDays;
    return telat > 0 ? telat * 1000 : 0;
  }
}

class PeminjamanGagal implements Exception {
  final String alasan;
  PeminjamanGagal(this.alasan);
  @override
  String toString() => 'Peminjaman gagal: $alasan';
}
