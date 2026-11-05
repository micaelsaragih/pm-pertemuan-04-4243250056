Future<String> ambilNama(String nim) async {
  await Future<void>.delayed(const Duration(milliseconds: 100));
  if (nim.isEmpty) throw Exception('NIM kosong');
  return 'Butet Siregar';
}

Future<void> main() async {
  print('1. Mulai');
  final future = ambilNama('123');
  print('2. Permintaan dikirim; program tidak menunggu');
  final nama = await future;
  print('3. Nama: $nama');
  print('4. $nama - IPK 3.62');
  try {
    await ambilNama('');
  } catch (e) {
    print('5. Gagal: $e');
  }
  final lanjutan = ambilNama('456').then((_) => print('7. IPK via then: 3.62'));
  print('6. Baris ini tercetak sebelum nomor 7');
  await lanjutan;
  final hasil = await Future.wait([ambilNama('A'), ambilNama('B')]);
  print('Future.wait: ${hasil.length} hasil');
}
