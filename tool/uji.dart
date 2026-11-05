import 'package:pm_p4_4243250056/model.dart';
import 'package:pm_p4_4243250056/perpustakaan.dart';

Future<void> main() async {
  final perpus = Perpustakaan('Uji');
  final b = Buku('B1', 'Buku Uji', 'Penulis');
  final e = EBook('E1', 'EBook Uji', 'Penulis', 'https://contoh.id');
  final m = Majalah('M1', 'Majalah Uji', 1);
  final s = Skripsi('S1', 'Skripsi Uji', 'Mahasiswa');
  for (final k in [b, e, m, s]) {
    perpus.tambah(k);
  }
  assert(b.lamaPinjam == 14 && m.lamaPinjam == 7);
  assert(e.lamaPinjam == 30 && s.lamaPinjam == 0);
  assert(ikon(e) == '📱' && ikon(s) == '🎓');
  final a = Anggota('A1', 'Anggota Uji', maksPinjam: 1);
  final p = await perpus.pinjam(a, 'B1', tanggal: DateTime(2026, 10, 1));
  assert(!b.tersedia && p.jatuhTempo == DateTime(2026, 10, 15));
  for (final kode in ['B1', 'M1', 'X99', 'S1']) {
    var ditolak = false;
    try {
      await perpus.pinjam(a, kode);
    } on PeminjamanGagal {
      ditolak = true;
    }
    assert(ditolak, 'Harus menolak $kode');
  }
  assert(perpus.kembalikan(p, tanggal: DateTime(2026, 10, 18)) == 3000);
  assert(b.tersedia && perpus.pinjamanAktif.isEmpty);
  await perpus.tutup();
  print(
      'Pengujian OOP Library System: LULUS (jalankan dengan --enable-asserts)');
}
