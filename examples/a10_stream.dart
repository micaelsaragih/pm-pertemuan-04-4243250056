import 'dart:async';

Stream<int> hitung(int sampai) async* {
  for (var i = 1; i <= sampai; i++) {
    await Future<void>.delayed(const Duration(milliseconds: 30));
    yield i;
  }
}

Future<void> main() async {
  await for (final angka in hitung(3)) {
    print('async*: $angka');
  }
  final controller = StreamController<String>.broadcast();
  final a = controller.stream.listen((event) => print('Pos A: $event'));
  final b = controller.stream.listen((event) => print('Pos B: $event'));
  controller.add('Buku dipinjam');
  controller.add('Buku dikembalikan');
  await controller.close();
  await a.cancel();
  await b.cancel();
}
