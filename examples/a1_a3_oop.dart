class Mahasiswa {
  final String nim;
  final String nama;
  double _ipk;
  static const kampus = 'UNIMED';

  Mahasiswa(this.nim, this.nama, {double ipk = 0}) : _ipk = ipk;
  Mahasiswa.baru(String nim, String nama) : this(nim, nama);
  factory Mahasiswa.dariMap(Map<String, Object?> data) => Mahasiswa(
        data['nim'] as String,
        data['nama'] as String,
        ipk: (data['ipk'] as num?)?.toDouble() ?? 0,
      );

  double get ipk => _ipk;
  set ipk(double nilai) {
    if (nilai < 0 || nilai > 4) throw RangeError('IPK harus 0–4');
    _ipk = nilai;
  }
}

abstract class Koleksi {
  int get lamaPinjam;
}

class Buku extends Koleksi {
  @override
  int get lamaPinjam => 14;
}

class EBook extends Buku {
  @override
  int get lamaPinjam => 30;
}

void main() {
  final mahasiswa = Mahasiswa.baru('4243250056', 'Micael');
  mahasiswa.ipk = 3.75;
  print('${mahasiswa.nama} — IPK ${mahasiswa.ipk}');
  try {
    mahasiswa.ipk = 5;
  } on RangeError catch (e) {
    print('Validasi IPK: $e');
  }
  print('Buku ${Buku().lamaPinjam} hari; EBook ${EBook().lamaPinjam} hari');
  print(Mahasiswa.dariMap({'nim': '01', 'nama': 'Butet', 'ipk': 3.6}).nama);
}
