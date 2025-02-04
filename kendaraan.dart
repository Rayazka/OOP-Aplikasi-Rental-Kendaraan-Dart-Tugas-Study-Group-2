abstract class Kendaraan {
  String jenis;
  String merek;
  String model;
  int harga;

  Kendaraan(this.jenis, this.merek, this.model, this.harga);

  String detailKendaraan();
}

class Mobil extends Kendaraan {
  Mobil(String jenis, String merek, String model, int harga)
      : super(jenis, merek, model, harga);

  @override
  String detailKendaraan() {
    return '$jenis $merek $model\tRp${harga}';
  }
}

class Motor extends Kendaraan {
  Motor(String jenis, String merek, String model, int harga)
      : super(jenis, merek, model, harga);

  @override
  String detailKendaraan() {
    return '$jenis $merek $model\tRp${harga}';
  }
}

class RentalKendaraan {
  List<Kendaraan> daftarKendaraan = [];

  void tambahKendaraan(Kendaraan kendaraan) {
    daftarKendaraan.add(kendaraan);
  }

  void hapusKendaraan(Kendaraan kendaraan) {
    if (apakahKendaraanTersedia()) {
      daftarKendaraan.remove(kendaraan);
    }
  }

  void editKendaraan(String merek, String model, int hargaBaru) {
    if (apakahKendaraanTersedia()) {
      var kendaraan = daftarKendaraan.firstWhere(
          (kendaraan) => kendaraan.merek == merek && kendaraan.model == model,
          orElse: () => throw Exception("Kendaraan tidak ditemukan"));

      kendaraan.harga = hargaBaru;
    }
  }

  void tampilkanDaftarKendaraan() {
    clearConsole();
    print("=== Daftar Kendaraan ===");
    if (apakahKendaraanTersedia()) {
      for (var i = 0; i < daftarKendaraan.length; i++) {
        var harga = daftarKendaraan[i].harga;
        print('${i + 1}. ${daftarKendaraan[i].detailKendaraan()}');
      }
    }
    print("\n");
  }

  bool apakahKendaraanTersedia() {
    if (daftarKendaraan.isNotEmpty) {
      return true;
    }
    clearConsole();
    print("Tidak ada kendaraan yang tersedia");
    return false;
  }

  void clearConsole() {
    print('\x1B[2J\x1B[0;0H');
  }
}
