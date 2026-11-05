import 'dart:io';

Future<void> main() async {
  // File sementara berada di direktori sistem, bukan file tugas pengguna.
  final dir = await Directory.systemTemp.createTemp('pm_p4_');
  try {
    final berkas = File('${dir.path}/catatan.txt');
    await berkas.writeAsString('Praktikum Dart: Future dan File I/O');
    print('Isi berkas: ${await berkas.readAsString()}');
  } finally {
    await dir.delete(recursive: true);
  }
}
