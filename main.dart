import 'dart:io';
import 'dart:mirrors';
import 'kendaraan.dart';

void main() {
  RentalKendaraan rental = RentalKendaraan();

  while (true) {
    tampilkanMenu();
    // Meminta input dari user
    String? input = stdin.readLineSync();

    // Melakukan validasi supaya input yang dimasukkan berupa number
    int inputNumber;
    try {
      inputNumber = int.parse(input!);
    } on Exception {
      print("Input harus berupa Angka! Silahkan coba lagi.");
      continue;
    }

    switch (inputNumber) {
      case 1:
        tambahKendaraan(rental);
        break;
      case 2:
        hapusKendaraan(rental);
        break;
      case 3:
        editKendaraan(rental);
        break;
      case 4:
        rental.tampilkanDaftarKendaraan();
        break;
      case 5:
        print("Keluar dari sistem..");
        return;
      default:
        print("Pilihan tidak valid! Silahkan coba lagi.");
    }
  }
}

// Unit Method: mengubah string ke int untuk memastikan input yang dimasukkan adalah number
int? parseToInt(String variable) {
  try {
    return int.parse(variable);
  } on FormatException {
    print("Input harus berupa angka! Silahkan coba lagi");
    return null;
  }
}

// Unit Method: Membersihkan konsol
void clearConsole() {
  print('\x1B[2J\x1B[0;0H');
}

// Menampilkan Menu
void tampilkanMenu() {
  print("""
  === Menu Rental Kendaraan ===
  1. Tambah Kendaraan
  2. Hapus Kendaraan
  3. Edit Data Kendaraan
  4. Tampilkan Daftar Kendaraan
  5. Keluar
  ========================
  Silahkan Pilih menu (1-5): 
  """);
}

// Menambahkan Mobil
void tambahKendaraan(RentalKendaraan rental) {
  clearConsole();
  print("=== Tambah Kendaraan ===\n"
      "Pilih jenis kendaraan (1: Mobil, 2: Motor):");
  String? inputJenis = stdin.readLineSync();
  int? noJenis = parseToInt(inputJenis!);

  if (noJenis != 1 && noJenis != 2) {
    print("Jenis Kendaraan tidak valid!");
    return;
  }

  print("Masukkan merk kendaraan:");
  String? merek = stdin.readLineSync();

  print("Masukkan model kendaraan: ");
  String? model = stdin.readLineSync();

  print("Masukkan harga kendaraan: ");
  String? inputHarga = stdin.readLineSync();
  int? harga = parseToInt(inputHarga!);

  if (harga == null) {
    clearConsole();
    print("Input harus berupa angka! Silahkan coba lagi");
    return;
  }

  String? jenis = noJenis == 1 ? "Mobil" : "Motor";
  Kendaraan kendaraan = noJenis == 1
      ? Mobil(jenis, merek!, model!, harga)
      : Motor(jenis, merek!, model!, harga);

  clearConsole();
  rental.tambahKendaraan(kendaraan);
  print("$jenis $merek $model dengan harga Rp $harga berhasil ditambahkan.");
}

void hapusKendaraan(RentalKendaraan rental) {
  clearConsole();
  if (!rental.apakahKendaraanTersedia()) {
    return;
  }

  print("=== Hapus Kendaraan ===\n");
  rental.tampilkanDaftarKendaraan();
  print("Masukkan nomor kendaraan yang ingin dihapus: ");
  String? inputKendaraaan = stdin.readLineSync();
  int? noKendaraan = parseToInt(inputKendaraaan!);

  if (noKendaraan! < 1 || noKendaraan! > rental.daftarKendaraan.length) {
    print("Kendaraan tidak ditemukan!");
    return;
  }

  Kendaraan kendaraan = rental.daftarKendaraan[noKendaraan! - 1];
  rental.hapusKendaraan(kendaraan);
  clearConsole();
  print(
      "${kendaraan.jenis} ${kendaraan.merek} ${kendaraan.model} berhasil dihapus.");
}

// Fungsi untuk mengedit data mobil
void editKendaraan(RentalKendaraan rental) {
  clearConsole();
  if (!rental.apakahKendaraanTersedia()) {
    return;
  }

  print("\n=== Edit Data Kendaraan ===");
  rental.tampilkanDaftarKendaraan();

  print("Masukkan nomor mobil yang ingin dihapus: ");
  String? inputKendaraan = stdin.readLineSync();
  int? noKendaraan = parseToInt(inputKendaraan!);

  if (noKendaraan! < 1 || noKendaraan! > rental.daftarKendaraan.length) {
    print("Kendaraan tidak ditemukan!");
    return;
  }

  Kendaraan kendaraan = rental.daftarKendaraan[noKendaraan!];
  print(
      "Masukkan harga baru untuk ${kendaraan.jenis} ${kendaraan.merek} ${kendaraan.model}:");
  String? hargaInput = stdin.readLineSync();
  int? hargaBaru = parseToInt(hargaInput!);

  rental.editKendaraan(kendaraan.merek, kendaraan.model, hargaBaru!);
  clearConsole();
  print(
      "Harga ${kendaraan.jenis} ${kendaraan.merek} ${kendaraan.model} berhasil diubah menjadi Rp$hargaBaru.");
}
