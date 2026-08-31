import 'package:flutter/material.dart';

void main() {
  runApp(const PerpustakaanApp());
}

// =====================================================
// DATA BUKU
// =====================================================

final List<Map<String, dynamic>> daftarBuku = [
  {
    'judul': 'Laskar Pelangi',
    'pengarang': 'Andrea Hirata',
    'tahunTerbit': 2005,
    'rating': 4.7,
    'tersedia': true,
    'genre': 'Fiksi',
  },
  {
    'judul': 'Bumi',
    'pengarang': 'Tere Liye',
    'tahunTerbit': 2014,
    'rating': 4.6,
    'tersedia': true,
    'genre': 'Fantasi',
  },
  {
    'judul': 'Harry Potter dan Batu Bertuah',
    'pengarang': 'J.K. Rowling',
    'tahunTerbit': 1997,
    'rating': 4.8,
    'tersedia': false,
    'genre': 'Fantasi',
  },
  {
    'judul': 'Atomic Habits',
    'pengarang': 'James Clear',
    'tahunTerbit': 2018,
    'rating': 4.5,
    'tersedia': true,
    'genre': 'Psikologi',
  },
  {
    'judul': 'Sapiens',
    'pengarang': 'Yuval Noah Harari',
    'tahunTerbit': 2011,
    'rating': 4.2,
    'tersedia': true,
    'genre': 'Sejarah',
  },
  {
    'judul': 'The Hobbit',
    'pengarang': 'J.R.R. Tolkien',
    'tahunTerbit': 1937,
    'rating': 4.3,
    'tersedia': false,
    'genre': 'Fantasi',
  },
];


// =====================================================
// FUNGSI KATEGORI RATING
// =====================================================

String kategoriRating(double rating) {
  if (rating >= 4.5) {
    return 'Sangat Baik';
  } else if (rating >= 3.5) {
    return 'Baik';
  } else {
    return 'Cukup';
  }
}


// =====================================================
// APLIKASI
// =====================================================

class PerpustakaanApp extends StatelessWidget {
  const PerpustakaanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Koleksi Buku',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}


// =====================================================
// HALAMAN UTAMA
// =====================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String pencarian = '';

  @override
  Widget build(BuildContext context) {

    // Set digunakan untuk mengambil genre unik tanpa duplikat.
    Set<String> genreUnik = daftarBuku
        .map((buku) => buku['genre'] as String)
        .toSet();

    // .where() digunakan untuk memfilter buku berdasarkan judul.
    List<Map<String, dynamic>> bukuFilter =
        daftarBuku.where((buku) {
      String judul = buku['judul'].toString().toLowerCase();

      return judul.contains(pencarian.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Column(
        children: [

          // ---------------- HEADER ----------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              24, 50, 24, 25,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff4f7df3),
                  Color(0xff2460c9),
                ],
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white24,
                  child: Icon(
                    Icons.menu_book,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Koleksi Buku',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Temukan dan jelajahi buku favoritmu!',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ---------------- ISI ----------------
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [

                // Pencarian
                TextField(
                  onChanged: (value) {
                    setState(() {
                      pencarian = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari judul buku...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Genre unik
                const Text(
                  'Genre Buku',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: genreUnik.map((genre) {
                    return Chip(
                      label: Text(genre),
                      avatar: const Icon(
                        Icons.book,
                        size: 17,
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Daftar Buku',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // ListView.builder untuk daftar buku
                ...List.generate(
                  bukuFilter.length,
                  (index) {
                    return bukuCard(
                      context,
                      bukuFilter[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // ===================================================
  // CARD BUKU
  // ===================================================

  Widget bukuCard(
    BuildContext context,
    Map<String, dynamic> buku,
  ) {
    double rating = buku['rating'];

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),

        leading: Container(
          width: 60,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              colors: [
                Color(0xff5b8def),
                Color(0xff294fa8),
              ],
            ),
          ),
          child: const Icon(
            Icons.menu_book,
            color: Colors.white,
            size: 32,
          ),
        ),

        title: Text(
          buku['judul'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),

            Text(buku['pengarang']),

            const SizedBox(height: 6),

            Row(
              children: [
                Text('${buku['tahunTerbit']}'),
                const Text('  •  '),

                const Icon(
                  Icons.star,
                  size: 16,
                  color: Colors.orange,
                ),

                Text(' $rating'),

                const Text('  •  '),

                Text(
                  kategoriRating(rating),
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 7),

            // Ternary untuk badge status buku
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: buku['tersedia']
                    ? Colors.green[50]
                    : Colors.red[50],
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Text(
                buku['tersedia']
                    ? 'Tersedia'
                    : 'Dipinjam',
                style: TextStyle(
                  color: buku['tersedia']
                      ? Colors.green[700]
                      : Colors.red[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),

        trailing: const Icon(
          Icons.chevron_right,
        ),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailPage(buku: buku),
            ),
          );
        },
      ),
    );
  }
}


// =====================================================
// HALAMAN DETAIL
// =====================================================

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> buku;

  const DetailPage({
    super.key,
    required this.buku,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  // Nullable String
  String? catatanPeminjam;

  @override
  Widget build(BuildContext context) {
    final buku = widget.buku;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: const Color(0xff2460c9),
        foregroundColor: Colors.white,
        title: const Text(
          'Detail Buku',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          // Informasi utama buku
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [

                  Container(
                    width: 150,
                    height: 190,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff4f7df3),
                          Color(0xff193f91),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.menu_book,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    buku['judul'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    buku['pengarang'],
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.blue,
                    ),
                  ),

                  const Divider(height: 30),

                  info(
                    Icons.calendar_month,
                    'Tahun Terbit',
                    '${buku['tahunTerbit']}',
                  ),

                  info(
                    Icons.star,
                    'Rating',
                    '${buku['rating']} '
                        '(${kategoriRating(buku['rating'])})',
                  ),

                  info(
                    Icons.category,
                    'Genre',
                    buku['genre'],
                  ),

                  info(
                    Icons.check_circle,
                    'Status',
                    buku['tersedia']
                        ? 'Tersedia'
                        : 'Dipinjam',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Deskripsi
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Buku ${buku['judul']} karya '
                    '${buku['pengarang']} merupakan salah '
                    'satu koleksi yang tersedia dalam '
                    'perpustakaan mini.',
                    style: const TextStyle(
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Catatan peminjam
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  const Text(
                    'Catatan Peminjam',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Operator ?? untuk nilai nullable
                  Text(
                    catatanPeminjam ??
                        '(Tidak ada catatan)',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Kembali ke Daftar Buku'),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xff2460c9),
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ],
      ),
    );
  }


  // Widget kecil untuk informasi detail buku
  Widget info(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 15),
          Text(
            '$label : ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}