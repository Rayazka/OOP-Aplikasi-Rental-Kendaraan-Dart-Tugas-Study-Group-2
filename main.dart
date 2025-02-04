import 'dart:io';
import 'mobil.dart';

void main() {
  RentalMobil rental = RentalMobil();

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
        tambahMobil(rental);
        break;
      case 2:
        hapusMobil(rental);
        break;
      case 3:
        editMobil(rental);
        break;
      case 4:
        rental.tampilkanDaftarMobil();
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
  === Menu Rental Mobil ===
  1. Tambah Mobil
  2. Hapus Mobil
  3. Edit Data Mobil
  4. Tampilkan Daftar Mobil
  5. Keluar
  ========================
  Silahkan Pilih menu (1-5): 
  """);
}

// Menambahkan Mobil
void tambahMobil(RentalMobil rental) {
  clearConsole();
  print("=== Tambah Mobil ===\n"
      "Masukkan merek mobil: ");
  String? merek = stdin.readLineSync();

  print("Masukkan model mobil: ");
  String? model = stdin.readLineSync();

  print("Masukkan harga mobil: ");
  String? inputHarga = stdin.readLineSync();
  int? harga = parseToInt(inputHarga!);

  if (harga == null) {
    clearConsole();
    print("Input harus berupa angka! Silahkan coba lagi");
    return;
  }

  Mobil mobil = Mobil(merek!, model!, harga);

  clearConsole();
  rental.tambahMobil(mobil);
  print("Mobil $merek $model dengan harga Rp $harga berhasil ditambahkan.");
}

void hapusMobil(RentalMobil rental) {
  clearConsole();
  if (!rental.apakahMobilTersedia()) {
    return;
  }

  print("=== Hapus Mobil ===\n");
  rental.tampilkanDaftarMobil();
  print("Masukkan nomor mobil yang ingin dihapus: ");
  String? inputMobil = stdin.readLineSync();
  int? noMobil = parseToInt(inputMobil!);

  if (noMobil! < 1 || noMobil! > rental.daftarMobil.length) {
    print("Mobil tidak ditemukan!");
    return;
  }

  Mobil mobil = rental.daftarMobil[noMobil!];
  rental.hapusMobil(mobil);
  clearConsole();
  print("Mobil ${mobil.merek} ${mobil.model} berhasil dihapus.");
}

// Fungsi untuk mengedit data mobil
void editMobil(RentalMobil rental) {
  clearConsole();
  if (!rental.apakahMobilTersedia()) {
    return;
  }

  print("\n=== Edit Data Mobil ===");
  rental.tampilkanDaftarMobil();

  print("Masukkan nomor mobil yang ingin dihapus: ");
  String? inputMobil = stdin.readLineSync();
  int? noMobil = parseToInt(inputMobil!);

  if (noMobil! < 1 || noMobil! > rental.daftarMobil.length) {
    print("Mobil tidak ditemukan!");
    return;
  }

  Mobil mobil = rental.daftarMobil[noMobil!];
  print("Masukkan harga baru untuk mobil ${mobil.merek} ${mobil.model}:");
  String? hargaInput = stdin.readLineSync();
  int? hargaBaru = parseToInt(hargaInput!);

  rental.editMobil(
      mobil.merek, mobil.model, hargaBaru!); // Mengupdate harga mobil
  clearConsole();
  print(
      "Harga mobil  ${mobil.merek} ${mobil.model} berhasil diubah menjadi Rp$hargaBaru.");
}
