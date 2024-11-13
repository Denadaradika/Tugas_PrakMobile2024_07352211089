import 'dart:core';

class ProdukDigital {
  String namaProduk;
  double harga;
  String kategori;

  ProdukDigital(this.namaProduk, this.harga, this.kategori);

  void terapkanDiskon() {
    if (kategori == 'NetworkAutomation' 'Data Management Basic' &&
        harga >= 200000) {
      double hargaSetelahDiskon = harga * 0.85;
      harga = hargaSetelahDiskon < 200000 ? 200000 : hargaSetelahDiskon;
    }
  }
}

abstract class Karyawan {
  String nama;
  int umur;
  String peran;

  Karyawan(this.nama, {required this.umur, required this.peran});

  void bekerja();
}

class KaryawanTetap extends Karyawan {
  KaryawanTetap(super.nama, {required super.umur, required super.peran});

  @override
  void bekerja() {
    print('$nama bekerja secara reguler.');
  }
}

class KaryawanKontrak extends Karyawan {
  KaryawanKontrak(super.nama, {required super.umur, required super.peran});

  @override
  void bekerja() {
    print('$nama bekerja pada proyek tertentu.');
  }
}

mixin Kinerja {
  int produktivitas = 0;
  DateTime? lastUpdate;

  void updateProduktivitas(int nilai) {
    final now = DateTime.now();
    if (lastUpdate == null || now.difference(lastUpdate!).inDays >= 30) {
      produktivitas = (produktivitas + nilai).clamp(0, 100);
      lastUpdate = now;
    } else {
      print("Produktivitas hanya bisa diperbarui setiap 30 hari.");
    }
  }
}

class KaryawanManager extends Karyawan with Kinerja {
  KaryawanManager(super.nama, {required super.umur}) : super(peran: 'Manager') {
    if (produktivitas < 85) {
      produktivitas = 85;
    }
  }

  @override
  void bekerja() {
    print('$nama bekerja sebagai Manager.');
  }
}

enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

class Proyek {
  FaseProyek fase = FaseProyek.Perencanaan;
  int jumlahKaryawan = 0;
  DateTime tanggalMulai;

  Proyek(this.tanggalMulai);

  void tambahKaryawan() {
    jumlahKaryawan++;
  }

  void beralihKeFaseBerikutnya() {
    while (true) {
      switch (fase) {
        case FaseProyek.Perencanaan:
          if (jumlahKaryawan >= 5) {
            fase = FaseProyek.Pengembangan;
            print("Proyek berhasil beralih ke fase Pengembangan.");
          } else {
            print(
                "Proyek belum bisa masuk ke fase Pengembangan. Tambah karyawan untuk melanjutkan.");
            return;
          }
          break;

        case FaseProyek.Pengembangan:
          if (DateTime.now().difference(tanggalMulai).inDays > 45) {
            fase = FaseProyek.Evaluasi;
            print("Proyek berhasil beralih ke fase Evaluasi.");
          } else {
            print(
                "Proyek belum bisa masuk ke fase Evaluasi. Harus menunggu lebih lama.");
            return;
          }
          break;

        case FaseProyek.Evaluasi:
          print("Proyek sudah berada di fase akhir: Evaluasi.");
          return;
      }
    }
  }
}

class Perusahaan {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];
  final int maxKaryawanAktif = 20;

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < maxKaryawanAktif) {
      karyawanAktif.add(karyawan);
    } else {
      print("Batas maksimum karyawan aktif tercapai.");
    }
  }

  void resignKaryawan(Karyawan karyawan) {
    karyawanAktif.remove(karyawan);
    karyawanNonAktif.add(karyawan);
  }
}

void main() {
  var produk1 =
      ProdukDigital("Data Management Basic", 150000, "DataManagement");
  var produk2 =
      ProdukDigital("Network Automation Pro", 250000, "NetworkAutomation");
  produk1.terapkanDiskon();
  print("Harga produk 1 setelah diskon: ${produk1.harga}");
  produk2.terapkanDiskon();
  print("Harga produk 2 setelah diskon: ${produk2.harga}");

  var karyawanTetap = KaryawanTetap("Denada", umur: 20, peran: "Developer");
  var karyawanKontrak = KaryawanKontrak("radika", umur: 25, peran: "Designer");

  karyawanTetap.bekerja();
  karyawanKontrak.bekerja();

  var manager = KaryawanManager("Radika", umur: 29);
  manager.updateProduktivitas(10);
  print("Produktivitas Manager: ${manager.produktivitas}");

  var proyek1 = Proyek(DateTime.now().subtract(const Duration(days: 50)));
  proyek1.tambahKaryawan();
  proyek1.tambahKaryawan();
  proyek1.tambahKaryawan();
  proyek1.tambahKaryawan();
  proyek1.tambahKaryawan();
  proyek1.beralihKeFaseBerikutnya();
  print("Fase proyek1 saat ini: ${proyek1.fase}");

  var perusahaan = Perusahaan();
  perusahaan.tambahKaryawan(karyawanTetap);
  perusahaan.tambahKaryawan(karyawanKontrak);
  perusahaan.tambahKaryawan(manager);
  perusahaan.resignKaryawan(karyawanTetap);
  print("Jumlah karyawan aktif: ${perusahaan.karyawanAktif.length}");
  print("Jumlah karyawan non-aktif: ${perusahaan.karyawanNonAktif.length}");
}
