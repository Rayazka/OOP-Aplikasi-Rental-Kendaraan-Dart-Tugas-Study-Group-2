class Mobil {
  String merek;
  String model;
  int harga;

  Mobil(this.merek, this.model, this.harga);
}

class RentalMobil {
  List<Mobil> daftarMobil = [];

  void tambahMobil(Mobil mobil) {
    daftarMobil.add(mobil);
  }

  void hapusMobil(Mobil mobil) {
    if (apakahMobilTersedia()) {
      daftarMobil.remove(mobil);
    }
  }

  void editMobil(String merek, String model, int hargaBaru) {
    if (apakahMobilTersedia()) {
      var mobil = daftarMobil.firstWhere(
          (mobil) => mobil.merek == merek && mobil.model == model,
          orElse: () => throw Exception("Mobil tidak ditemukan"));

      mobil.harga = hargaBaru;
    }
  }

  void tampilkanDaftarMobil() {
    clearConsole();
    print("=== Daftar Mobil ===");
    if (apakahMobilTersedia()) {
      for (var i = 0; i < daftarMobil.length; i++) {
        var harga = daftarMobil[i].harga;
        print(
            '${i + 1}. ${daftarMobil[i].merek} ${daftarMobil[i].model}\tRp${harga}');
      }
    }
    print("\n");
  }

  bool apakahMobilTersedia() {
    if (daftarMobil.isNotEmpty) {
      return true;
    }
    clearConsole();
    print("Tidak ada mobil yang tersedia");
    return false;
  }

  void clearConsole() {
    print('\x1B[2J\x1B[0;0H');
  }
}
