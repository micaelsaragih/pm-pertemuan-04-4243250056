# Praktikum Pertemuan 4 — OOP Library System

## Identitas

- **Nama:** Micael Zecsen Saragih
- **NIM:** 4243250056
- **Kelas:** PSIK24D
- **Universitas:** Universitas Negeri Medan
- **Mata kuliah:** Pemrograman Mobile

## Sumber

Modul Pertemuan 4 bagian B–C (halaman 16–20), materi A.1–A.11, dan slide Pertemuan 4 (OOP & Async Programming).

## Fitur

- Hierarki `Koleksi` dengan `Buku`, `Majalah`, `EBook`, dan `Skripsi`.
- `EBook` menggunakan mixin `BisaDiunduh` dan memiliki masa pinjam 30 hari.
- Field `_dipinjam` dienkapsulasi dalam `lib/model.dart` dengan method publik untuk mengubah status.
- Peminjaman dilakukan dengan `Future` dan `await`, sementara kejadian dicatat melalui `StreamController.broadcast()`.
- Exception `PeminjamanGagal` menangani buku tidak tersedia, batas pinjaman, kode salah, dan skripsi yang hanya boleh dibaca di tempat.
- Denda dihitung Rp1.000/hari setelah jatuh tempo.
- `sealed class Koleksi` dan `switch` pada fungsi `ikon()` mencakup semua subclass.

Ketiga tantangan praktikum selesai diterapkan. Jika `Koleksi` memiliki subclass baru namun fungsi `ikon()` belum memiliki kasusnya, analyzer menandai switch tidak lengkap (*non-exhaustive*).

## Menjalankan

```powershell
dart pub get
dart run
```

Atau `dart run bin/pm_p4_4243250056.dart`.

## Struktur

| Lokasi | Fungsi |
|---|---|
| `bin/pm_p4_4243250056.dart` | Demonstrasi kasus dan output |
| `lib/model.dart` | Hierarki koleksi, anggota, peminjaman, exception |
| `lib/perpustakaan.dart` | Pengelolaan koleksi, peminjaman async, log Stream |
| `examples/` | Praktik contoh A.1, A.3, A.5, A.6, A.9, A.10, A.11 |
| `tool/uji.dart` | Pengujian tanpa paket eksternal |
| `docs/` | Screenshot hasil praktikum |

## Bukti Screenshot

Ambil output nyata dari terminal dan simpan sebagai:

1. `docs/01-library-output.png` — penambahan koleksi, pinjam, jatuh tempo, denda.
2. `docs/02-penolakan-skripsi.png` — kode salah, sedang dipinjam, batas pinjam, dan penolakan skripsi.
3. `docs/03-contoh-dan-pengujian.png` — contoh materi dan hasil `dart analyze` serta pengujian.

Setelah screenshot tersedia, tampilkan dengan Markdown `![Output perpustakaan](docs/01-library-output.png)` dan seterusnya.

## Pemeriksaan

```powershell
dart format .
dart analyze
dart --enable-asserts run tool/uji.dart
dart run examples/a1_a3_oop.dart
dart run examples/a5_a6_enum_generics.dart
dart run examples/a9_future.dart
dart run examples/a10_stream.dart
dart run examples/a11_file.dart
```

Contoh A.1 menguji IPK tidak valid. Contoh A.3 menunjukkan override masa pinjam EBook menjadi 30 hari. Contoh A.9–A.11 memperlihatkan Future, Stream, dan I/O asinkron.

## Refleksi

1. `extends` untuk mewarisi perilaku (contoh `EBook extends Buku`); `implements` untuk memenuhi kontrak, misalnya implementasi `Exception`; `with` untuk menambahkan perilaku yang dapat digunakan ulang, misalnya `BisaDiunduh`.
2. `await` menunda kelanjutan fungsi `pinjam`, tetapi event loop masih dapat menangani pekerjaan async lain; program tidak memblokir seluruh thread hanya karena menunggu Future.
3. `Future` memberikan satu hasil di masa depan, misalnya respons login; `Stream` memberikan serangkaian event, misalnya pembaruan lokasi secara berkala.

## Penggunaan AI

ChatGPT membantu menyiapkan kode, dokumentasi, dan skrip pengujian. Mahasiswa tetap perlu menjalankan dan memahami program serta mengambil screenshot asli sebelum pengumpulan.
