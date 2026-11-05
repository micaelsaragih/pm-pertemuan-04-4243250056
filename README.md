# Praktikum Pertemuan 4 — OOP Library System

## Identitas Mahasiswa

| Atribut | Keterangan |
|---|---|
| **Nama** | Micael Zecsen Saragih |
| **NIM** | 4243250056 |
| **Kelas** | PSIK24D |
| **Universitas** | Universitas Negeri Medan |
| **Mata Kuliah** | Pemrograman Mobile |

## Sumber Materi

Modul Pertemuan 4 bagian B–C (halaman 16–20), materi A.1–A.11, dan slide Pertemuan 4 (OOP & Async Programming).

## Deskripsi

Program Dart console yang mensimulasikan sistem perpustakaan digital. Sistem mengelola koleksi buku, majalah, e-book, dan skripsi dengan fitur peminjaman asinkron, penanganan exception, notifikasi melalui Stream, dan perhitungan denda keterlambatan.

## Fitur Utama

### Penerapan OOP

- **Hierarki sealed class**: `Koleksi` sebagai sealed class dengan turunan `Buku`, `Majalah`, `EBook`, dan `Skripsi`.
- **Enkapsulasi**: Field `_dipinjam` dan `_riwayat` dikelola secara privat dalam `lib/model.dart` dengan method publik untuk mengubah status.
- **Polimorfisme**: Semua koleksi diproses melalui antarmuka `Koleksi` yang sama; setiap subclass mengimplementasikan perilaku berbeda untuk `masaPinjam`, `jenis`, dan `ikon()`.
- **Mixin**: `EBook` menggunakan mixin `BisaDiunduh` yang menambahkan kemampuan unduh tanpa mengubah hierarki kelas.
- **Exception kustom**: `PeminjamanGagal` menangani kasus tidak tersedia, batas pinjaman, kode salah, dan skripsi hanya baca di tempat.

### Penerapan Async Programming

- Peminjaman dilakukan dengan `Future` dan `async/await`, mensimulasikan proses verifikasi yang tidak sinkron.
- Kejadian peminjaman dan pengembalian dicatat secara real-time melalui `StreamController.broadcast()`.
- Denda dihitung Rp1.000/hari setelah jatuh tempo.

### Tiga Tantangan Praktikum

1. **Sealed class exhaustive switch**: Menggunakan `sealed class Koleksi` bersama fungsi `ikon()` dengan ekspresi `switch`. Jika ada subclass baru yang belum dicakup, Dart analyzer langsung menandai switch sebagai non-exhaustive — compile-time safety tanpa perlu runtime check.

2. **Mixin BisaDiunduh**: `EBook` menggabungkan kemampuan unduh lewat `with BisaDiunduh`. Mixin ini menambahkan method `unduh()` dan field `ukuranMB` tanpa mempengaruhi hierarki `Buku → EBook`. Masa pinjam `EBook` di-override menjadi 30 hari.

3. **Exception bertingkat dalam async**: Method `pinjam()` di `Perpustakaan` menggunakan `async/await` sekaligus try-catch untuk menangani beberapa kondisi gagal (kode salah, sedang dipinjam, batas pinjam terlampaui, skripsi hanya baca di tempat) dalam satu alur kontrol yang bersih.

## Cara Menjalankan

```powershell
dart pub get
dart run
```

Atau secara eksplisit:

```powershell
dart run bin/pm_p4_4243250056.dart
```

Menjalankan contoh-contoh materi:

```powershell
dart run examples/a1_a3_oop.dart
dart run examples/a5_a6_enum_generics.dart
dart run examples/a9_future.dart
dart run examples/a10_stream.dart
dart run examples/a11_file.dart
```

## Pemeriksaan

```powershell
dart format .
dart analyze
dart --enable-asserts run tool/uji.dart
```

## Struktur Project

| Lokasi | Fungsi |
|---|---|
| `bin/pm_p4_4243250056.dart` | Demonstrasi kasus lengkap dan output |
| `lib/model.dart` | Hierarki koleksi, anggota, peminjaman, exception |
| `lib/perpustakaan.dart` | Pengelolaan koleksi, peminjaman async, log Stream |
| `examples/a1_a3_oop.dart` | Contoh OOP dasar — A.1 dan A.3 |
| `examples/a5_a6_enum_generics.dart` | Contoh enum dan generics — A.5 dan A.6 |
| `examples/a9_future.dart` | Contoh Future async — A.9 |
| `examples/a10_stream.dart` | Contoh Stream — A.10 |
| `examples/a11_file.dart` | Contoh File I/O — A.11 |
| `tool/uji.dart` | Pengujian tanpa paket eksternal |
| `docs/` | Screenshot hasil praktikum |

## Bukti Screenshot

### Screenshot 1 — Output Sistem Perpustakaan

![Output Sistem Perpustakaan](docs/01-library-output.png)

Menampilkan proses penambahan koleksi, peminjaman berhasil, jatuh tempo, dan perhitungan denda.

### Screenshot 2 — Penanganan Kesalahan Peminjaman

![Penolakan Peminjaman](docs/02-penolakan-skripsi.png)

Menampilkan kode salah, buku sedang dipinjam, batas pinjam terlampaui, dan penolakan skripsi (hanya boleh dibaca di tempat).

### Screenshot 3 — Contoh Materi dan Pengujian

![Hasil Pengujian](docs/03-contoh-dan-pengujian.png)

Menampilkan hasil `dart analyze` bersih, contoh-contoh materi A.1–A.11, dan hasil skrip pengujian `tool/uji.dart`.

## Pengujian

Skrip `tool/uji.dart` memverifikasi:

- Peminjaman berhasil dan pengembalian koleksi.
- Exception `PeminjamanGagal` untuk tiap kasus gagal.
- Perhitungan denda keterlambatan.
- Fungsionalitas mixin `BisaDiunduh` pada `EBook`.
- Exhaustiveness sealed class melalui fungsi `ikon()`.

Hasil pengujian: **LULUS** (tidak ada error, semua assertion terpenuhi).

## Refleksi

1. **extends vs implements vs with**: `extends` untuk mewarisi perilaku (contoh `EBook extends Buku`); `implements` untuk memenuhi kontrak seperti implementasi `Exception`; `with` untuk menambahkan perilaku yang dapat digunakan ulang seperti `BisaDiunduh`.
2. **await dan event loop**: `await` menunda kelanjutan fungsi `pinjam`, tetapi event loop masih dapat menangani pekerjaan async lain — program tidak memblokir seluruh thread.
3. **Future vs Stream**: `Future` memberikan satu hasil di masa depan (misalnya respons login); `Stream` memberikan serangkaian event (misalnya pembaruan log peminjaman).

## Pernyataan Penggunaan AI

ChatGPT digunakan untuk membantu merancang kode, dokumentasi, dan skrip pengujian. Mahasiswa bertanggung jawab membaca kode, menjalankan pengujian, mengumpulkan screenshot asli, dan memastikan hasil sesuai instruksi dosen.
