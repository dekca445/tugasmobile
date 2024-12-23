import 'package:flutter/material.dart';

class DetailPinjamScreen extends StatefulWidget {
  const DetailPinjamScreen({super.key});

  @override
  _DetailPinjamScreenState createState() => _DetailPinjamScreenState();
}

class _DetailPinjamScreenState extends State<DetailPinjamScreen> {
  // Controller untuk TextField
  TextEditingController namaController = TextEditingController();
  TextEditingController barangController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController tanggalPinjamController = TextEditingController();
  TextEditingController tanggalKembaliController = TextEditingController();

  // Daftar pinjaman
  List<Map<String, String>> pinjamList = [
    {
      'nama': 'Apipah',
      'barang': 'Laptop',
      'jumlah': '1',
      'tanggalPinjam': '2024-12-01',
      'tanggalKembali': '2024-12-15',
    },
    {
      'nama': 'Budi',
      'barang': 'Proyektor',
      'jumlah': '2',
      'tanggalPinjam': '2024-12-05',
      'tanggalKembali': '2024-12-20',
    },
  ];

  // Fungsi untuk menambahkan pinjaman baru
  void tambahPinjam() {
    if (namaController.text.isNotEmpty &&
        barangController.text.isNotEmpty &&
        jumlahController.text.isNotEmpty &&
        tanggalPinjamController.text.isNotEmpty &&
        tanggalKembaliController.text.isNotEmpty) {
      setState(() {
        pinjamList.add({
          'nama': namaController.text,
          'barang': barangController.text,
          'jumlah': jumlahController.text,
          'tanggalPinjam': tanggalPinjamController.text,
          'tanggalKembali': tanggalKembaliController.text,
        });

        // Bersihkan input setelah menyimpan
        namaController.clear();
        barangController.clear();
        jumlahController.clear();
        tanggalPinjamController.clear();
        tanggalKembaliController.clear();
      });
    } else {
      // Tampilkan pesan jika input kosong
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi semua data!'),
          backgroundColor: Color.fromARGB(255, 5, 212, 249),
        ),
      );
    }
  }

  // Fungsi untuk navigasi ke detail pinjam
  void lihatDetailPinjam(Map<String, String> pinjam) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Detail Pinjam'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama: ${pinjam['nama']}'),
              Text('Barang: ${pinjam['barang']}'),
              Text('Jumlah: ${pinjam['jumlah']}'),
              Text('Tanggal Pinjam: ${pinjam['tanggalPinjam']}'),
              Text('Tanggal Kembali: ${pinjam['tanggalKembali']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pinjam'),
        backgroundColor: const Color.fromARGB(255, 9, 158, 251),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Data Pinjaman
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Peminjam',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: barangController,
              decoration: const InputDecoration(
                labelText: 'Barang yang Dipinjam',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah Barang',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: tanggalPinjamController,
              decoration: const InputDecoration(
                labelText: 'Tanggal Pinjam',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: tanggalKembaliController,
              decoration: const InputDecoration(
                labelText: 'Tanggal Kembali',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: tambahPinjam,
              child: const Text('Simpan'),
            ),
            const SizedBox(height: 16),

            // List Data Pinjam
            Expanded(
              child: ListView.builder(
                itemCount: pinjamList.length,
                itemBuilder: (context, index) {
                  final pinjam = pinjamList[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(pinjam['nama'] ?? ''),
                      subtitle: Text('Barang: ${pinjam['barang'] ?? ''}'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () => lihatDetailPinjam(pinjam),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
