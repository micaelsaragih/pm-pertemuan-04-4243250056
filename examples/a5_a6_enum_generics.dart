enum Status { dipinjam, tersedia, rusak }

T terbesar<T extends num>(List<T> data) {
  if (data.isEmpty) throw ArgumentError('Daftar kosong');
  return data.reduce((a, b) => a > b ? a : b);
}

void main() {
  for (final status in Status.values) {
    print('${status.name}: indeks ${status.index}');
  }
  print('Nilai terbesar (int): ${terbesar([10, 8, 16])}');
  print('Nilai terbesar (double): ${terbesar([2.5, 3.9, 1.1])}');
}
