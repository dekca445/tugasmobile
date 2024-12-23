import 'package:flutter/material.dart';
import 'package:pinjamuang/services/firestore.dart';
import 'package:pinjamuang/services/userData.dart';

class DetailAnggotaScreen extends StatefulWidget {
  @override
  _DetailAnggotaScreenState createState() => _DetailAnggotaScreenState();
}

class _DetailAnggotaScreenState extends State<DetailAnggotaScreen> {
  // Controller untuk TextField
  FirebaseService firebaseService = new FirebaseService();
  TextEditingController nama = TextEditingController();
  TextEditingController umur = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController handphone = TextEditingController();

  // Daftar anggota
  List<Map<String, String>> anggotaList = [];

  // Fungsi untuk menambahkan anggota baru
  void tambahAnggota() {
    if (nama.text.isNotEmpty &&
        umur.text.isNotEmpty &&
        email.text.isNotEmpty &&
        alamat.text.isNotEmpty &&
        handphone.text.isNotEmpty) {
      setState(() {
        anggotaList.add({
          'nama': nama.text,
          'umur': umur.text,
          'email': email.text,
          'alamat': alamat.text,
          'handphone': handphone.text,
        });

        // Bersihkan input setelah menyimpan
        nama.clear();
        umur.clear();
        email.clear();
        alamat.clear();
        handphone.clear();
      });
    } else {
      // Tampilkan pesan jika input kosong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harap isi semua data!'),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  // Fungsi untuk melihat detail anggota dengan warna biru
  void lihatDetailAnggota(Map<String, String> anggota) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(
              0, 119, 119, 1.0), // Menambahkan warna biru pada latar belakang
          title: Text(
            'Detail Anggota',
            style: TextStyle(
                color: Colors.white), // Mengubah warna teks judul menjadi putih
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama: ${anggota['nama']}',
                  style: TextStyle(color: Colors.white)),
              Text('Umur: ${anggota['umur']}',
                  style: TextStyle(color: Colors.white)),
              Text('email: ${anggota['email']}',
                  style: TextStyle(color: Colors.white)),
              Text('Alamat: ${anggota['alamat']}',
                  style: TextStyle(color: Colors.white)),
              Text('Handphone: ${anggota['handphone']}',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Tutup',
                style: TextStyle(
                    color: Colors
                        .white), // Mengubah warna teks tombol menjadi putih
              ),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk mengubah data anggota dengan warna biru
  void ubahAnggota(int index) {
    final anggota = anggotaList[index];

    // Variabel controller lokal yang hanya digunakan di dalam dialog edit
    TextEditingController editnama =
        TextEditingController(text: anggota['nama']);
    TextEditingController editumur =
        TextEditingController(text: anggota['umur']);
    TextEditingController editemail =
        TextEditingController(text: anggota['email']);
    TextEditingController editalamat =
        TextEditingController(text: anggota['alamat']);
    TextEditingController edithandphone =
        TextEditingController(text: anggota['handphone']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(
              0, 119, 119, 1.0), // Menambahkan warna biru pada latar belakang
          title: Text(
            'Ubah Data Anggota',
            style: TextStyle(
                color: Colors.white), // Mengubah warna teks judul menjadi putih
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editnama,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  labelStyle: TextStyle(
                      color:
                          Colors.white), // Mengubah warna label menjadi putih
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.white), // Mengubah warna border ketika fokus
                  ),
                ),
                style: TextStyle(
                    color: Colors
                        .white), // Mengubah warna teks input menjadi putih
              ),
              SizedBox(height: 8),
              TextField(
                controller: editumur,
                decoration: InputDecoration(
                  labelText: 'Umur',
                  labelStyle: TextStyle(
                      color:
                          Colors.white), // Mengubah warna label menjadi putih
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.white), // Mengubah warna border ketika fokus
                  ),
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: Colors
                        .white), // Mengubah warna teks input menjadi putih
              ),
              SizedBox(height: 8),
              TextField(
                controller: editemail,
                decoration: InputDecoration(
                  labelText: 'email',
                  labelStyle: TextStyle(
                      color:
                          Colors.white), // Mengubah warna label menjadi putih
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.white), // Mengubah warna border ketika fokus
                  ),
                ),
                style: TextStyle(
                    color: Colors
                        .white), // Mengubah warna teks input menjadi putih
              ),
              SizedBox(height: 8),
              TextField(
                controller: editalamat,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  labelStyle: TextStyle(
                      color:
                          Colors.white), // Mengubah warna label menjadi putih
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.white), // Mengubah warna border ketika fokus
                  ),
                ),
                style: TextStyle(
                    color: Colors
                        .white), // Mengubah warna teks input menjadi putih
              ),
              SizedBox(height: 8),
              TextField(
                controller: edithandphone,
                decoration: InputDecoration(
                  labelText: 'No HP',
                  labelStyle: TextStyle(
                      color:
                          Colors.white), // Mengubah warna label menjadi putih
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Colors.white), // Mengubah warna border ketika fokus
                  ),
                ),
                keyboardType: TextInputType.phone,
                style: TextStyle(
                    color: Colors
                        .white), // Mengubah warna teks input menjadi putih
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Batal',
                style: TextStyle(
                    color: Colors
                        .white), // Mengubah warna teks tombol menjadi putih
              ),
            ),
            ElevatedButton(
              onPressed: () {
                UserData userData = UserData(
                    nama.text,
                    int.parse(umur.text),
                    email.text,
                    alamat.text,
                    int.parse(handphone.text),
                    null, 
                    null);
                firebaseService.tambah(userData);
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.white, // Menambahkan warna biru pada tombol simpan
              ),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menghapus data anggota
  void hapusAnggota(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus anggota ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  anggotaList.removeAt(index);
                  //bersihkan input setelah penghapusan
                  nama.clear();
                  umur.clear();
                  email.clear();
                  alamat.clear();
                  handphone.clear();
                });
                Navigator.of(context).pop();
              },
              child: Text('Hapus'),
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
        title: Text('Detail Anggota'),
        backgroundColor: const Color.fromRGBO(0, 119, 119, 1.0),
      ),
      body: Container(
        color: const Color.fromRGBO(
            40, 55, 77, 1.0), // Menambahkan warna biru pada body
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Data Anggota
            TextField(
              controller: nama,
              decoration: InputDecoration(
                labelText: 'Nama',
                labelStyle:
                    TextStyle(color: Colors.white), // Mengubah warna teks label
                border: OutlineInputBorder(),
              ),
              style:
                  TextStyle(color: Colors.white), // Mengubah warna teks input
            ),
            SizedBox(height: 8),
            TextField(
              controller: umur,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Umur',
                labelStyle:
                    TextStyle(color: Colors.white), // Mengubah warna teks label
                border: OutlineInputBorder(),
              ),
              style:
                  TextStyle(color: Colors.white), // Mengubah warna teks input
            ),
            SizedBox(height: 8),
            TextField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'email',
                labelStyle:
                    TextStyle(color: Colors.white), // Mengubah warna teks label
                border: OutlineInputBorder(),
              ),
              style:
                  TextStyle(color: Colors.white), // Mengubah warna teks input
            ),
            SizedBox(height: 8),
            TextField(
              controller: alamat,
              decoration: InputDecoration(
                labelText: 'Alamat',
                labelStyle:
                    TextStyle(color: Colors.white), // Mengubah warna teks label
                border: OutlineInputBorder(),
              ),
              style:
                  TextStyle(color: Colors.white), // Mengubah warna teks input
            ),
            SizedBox(height: 8),
            TextField(
              controller: handphone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'No HP',
                labelStyle:
                    TextStyle(color: Colors.white), // Mengubah warna teks label
                border: OutlineInputBorder(),
              ),
              style:
                  TextStyle(color: Colors.white), // Mengubah warna teks input
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: tambahAnggota,
              child: Text('Simpan'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.blue, // Menambahkan warna biru pada tombol simpan
              ),
            ),
            SizedBox(height: 16),

            // List Data Anggota
            Expanded(
              child: ListView.builder(
                itemCount: anggotaList.length,
                itemBuilder: (context, index) {
                  final anggota = anggotaList[index];
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(anggota['nama'] ?? ''),
                      subtitle: Text('Umur: ${anggota['umur'] ?? ''}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit,
                                color: const Color.fromRGBO(0, 119, 119, 1.0)),
                            onPressed: () => ubahAnggota(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete,
                                color: const Color.fromRGBO(0, 119, 119, 1.0)),
                            onPressed: () => hapusAnggota(index),
                          ),
                        ],
                      ),
                      onTap: () => lihatDetailAnggota(anggota),
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
