void main() {
  Map<String, dynamic> mahasiswa = {
    'M001': {
      'nama': 'Budi Santoso',
      'nilai': [85, 90, 78, 92, 88],
      'absensi': 2
    },
    'M002': {
      'nama': 'Siti Rahayu',
      'nilai': [55, 60, 58, 52, 45],
      'absensi': 4
    },
    'M003': {
      'nama': 'Andi Pratama',
      'nilai': [72, 74, 68, 70, 76],
      'absensi': 2
    },
    'M004': {
      'nama': 'Rina Lestari',
      'nilai': [80, 82, 75, 78, 72],
      'absensi': 1
    },
    'M005': {
      'nama': 'Doni Saputra',
      'nilai': [70, 78, 75, 80, 77],
      'absensi': 3
    }
  };

  print('=== LAPORAN NILAI MAHASISWA ===\n');

  // Menampilkan data mahasiswa
  mahasiswa.forEach((id, data) {
    tampilkanLaporan(data);
  });

  // Statistik kelas
  int tertinggi = 0;
  int terendah = 100;
  int totalNilai = 0;
  int jumlahNilai = 0;

  for (var data in mahasiswa.values) {
    List<int> nilai = data['nilai'];

    for (int angka in nilai) {
      totalNilai += angka;
      jumlahNilai++;

      if (angka > tertinggi) {
        tertinggi = angka;
      }

      if (angka < terendah) {
        terendah = angka;
      }
    }
  }

  double rataKelas = totalNilai / jumlahNilai;

  print('\n=== STATISTIK KELAS ===');
  print('+----------------------+---------+');
  print('| Nilai Tertinggi      | $tertinggi      |');
  print('| Nilai Terendah       | $terendah      |');
  print('| Rata-rata Kelas      | ${rataKelas.toStringAsFixed(1)}    |');
  print('+----------------------+---------+');
}


// Fungsi untuk menampilkan laporan
void tampilkanLaporan(Map<String, dynamic> data) {
  String nama = data['nama'];
  List<int> nilai = data['nilai'];
  int absensi = data['absensi'];

  double rataRata = hitungRataRata(nilai);
  String grade = tentukanGrade(rataRata);
  bool status = cekKelulusan(
    rataRata: rataRata,
    absensi: absensi,
  );

  print('Nama       : $nama');
  print('Nilai      : $nilai');
  print('Rata-rata  : ${rataRata.toStringAsFixed(1)}');
  print('Grade      : $grade');
  print('Absensi    : $absensi kali');
  print('Status     : ${status ? "LULUS" : "TIDAK LULUS"}');
  print('----------------------------------------');
}


// Menghitung rata-rata dengan perulangan
double hitungRataRata(List<int> nilai) {
  int total = 0;

  for (int angka in nilai) {
    total += angka;
  }

  return total / nilai.length;
}


// Menentukan grade
String tentukanGrade(double rataRata) {
  if (rataRata >= 85) {
    return 'A';
  }

  if (rataRata >= 75) {
    return 'B';
  }

  if (rataRata >= 65) {
    return 'C';
  }

  if (rataRata >= 50) {
    return 'D';
  }

  return 'E';
}


// Mengecek kelulusan
bool cekKelulusan({
  required double rataRata,
  required int absensi,
}) {
  if (rataRata >= 60 && absensi <= 3) {
    return true;
  }

  return false;
}