import 'package:pm_p4_4243250056/model.dart';
import 'package:pm_p4_4243250056/perpustakaan.dart';

Future<void> main() async {
  print('Praktikum OOP Library System — Micael Zecsen Saragih (4243250056)');
  final perpustakaan = Perpustakaan('Perpustakaan FMIPA');
  final subscription = perpustakaan.log.listen((pesan) => print('[LOG] $pesan'));
  perpustakaan
    ..tambah(Buku('B01', 'Dasar-Dasar Dart', 'A. Siregar'))
    ..tambah(Majalah('M01', 'Majalah Teknologi', 112))
    ..tambah(EBook('E01', 'Flutter in Action', 'Eric Windmill',
        'https://contoh.id/e01'))
    ..tambah(Skripsi('S01', 'IoT untuk Keamanan Motor', 'Micael'));

  final butet = Anggota('A01', 'Butet', maksPinjam: 1);
  final ucok = Anggota('A02', 'Ucok');
  final pinjaman = await perpustakaan.pinjam(
      butet, 'B01', tanggal: DateTime(2026, 10, 1));
  print('Jatuh tempo: ${pinjaman.jatuhTempo}');

  for (final (anggota, kode) in [
    (ucok, 'B01'),
    (butet, 'M01'),
    (ucok, 'X99'),
    (ucok, 'S01'),
  ]) {
    try {
      await perpustakaan.pinjam(anggota, kode);
    } on PeminjamanGagal catch (e) {
      print(e);
    }
  }

  final denda = perpustakaan.kembalikan(
      pinjaman, tanggal: DateTime(2026, 10, 18));
  print('Denda: Rp$denda');
  for (final koleksi in perpustakaan.koleksiTersedia) {
    print('${ikon(koleksi)} ${koleksi.info()}');
    if (koleksi is EBook) print(koleksi.unduh());
  }
  await perpustakaan.tutup();
  await subscription.cancel();
}
