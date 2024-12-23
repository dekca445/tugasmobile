import 'package:flutter/material.dart';
// import 'package:testing1/angsuran.dart';
// import 'package:testing1/pinjam.dart';
// import 'package:testing1/service/auth_service.dart';
// import 'package:testing1/setting.dart'; // Import halaman Setting
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinjamuang/services/auth_service.dart';
import 'package:pinjamuang/ui/angsuranreal.dart';
import 'package:pinjamuang/ui/pinjam.dart';
import 'package:pinjamuang/ui/setting.dart';
import 'package:pinjamuang/ui/tes.dart';
// import 'package:testing1/tes.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String name = "Pelanggan"; // Nama default jika belum diubah
  String email = ""; // Email dari Firebase Auth

  @override
  void initState() {
    super.initState();
    // Ambil email dari Firebase Auth saat login
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email = user.email ?? "Email@Dummy.com"; // Menampilkan email dari Firebase
    }
  }

  // Fungsi untuk memperbarui nama setelah diubah di halaman Settings
  void updateName(String newName) {
    setState(() {
      name = newName; // Update nama di Dashboard
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> nama = ['Anggota', 'Pinjam', 'Angsuran'];
    final List<IconData> icons = [
      Icons.person_add, // Ikon untuk Anggota
      Icons.monetization_on, // Ikon untuk Pinjam
      Icons.payment, // Ikon untuk Angsuran
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Simpan Pinjam'),
        backgroundColor: Color.fromRGBO(0, 119, 119, 1.0),
        centerTitle: true,
        elevation: 4,
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromRGBO(40, 55, 77, 1.0),
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(name, style: TextStyle(color: Colors.white)), // Menampilkan nama
                accountEmail: Text(email, style: TextStyle(color: Colors.white70)), // Menampilkan email
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jpg'), // Gambar profil
                ),
                decoration: BoxDecoration(color: Color.fromRGBO(0, 119, 119, 1.0)),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  ).then((newName) {
                    // Jika ada perubahan nama dari halaman Settings
                    if (newName != null) {
                      updateName(newName); // Update nama di Dashboard
                    }
                  });
                },
              ),
              Divider(color: Colors.white70),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () async {
                  await AuthService().signout(context: context); // Logout
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Color.fromRGBO(40, 55, 77, 1.0),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.dashboard,
                size: 80,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Selamat Datang $name!", // Menampilkan nama pengguna
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Kategori
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                nama.length,
                (index) => Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigasi ke halaman sesuai kategori
                        if (nama[index] == 'Anggota') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailAnggotaScreen()),
                          );
                        } else if (nama[index] == 'Pinjam') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailPinjamScreen()),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => KelolaAngsuranPage()),
                          );
                        }
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(icons[index], color: Colors.white, size: 35),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      nama[index],
                      style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Pinjaman Section
            Text(
              'Pinjaman',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white70),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    color: Color.fromRGBO(40, 55, 77, 1.0),
                    child: ListTile(
                      leading: Icon(Icons.money, color: Colors.white70),
                      title: Text("Pinjaman", style: TextStyle(color: Colors.white70)),
                      subtitle: Text('Ini tempat jumlah pinjaman', style: TextStyle(color: Colors.white70)),
                      trailing: Icon(Icons.arrow_forward, color: Colors.white70),
                      onTap: () {
                        // Tindakan saat card di-tap (misalnya menampilkan detail lebih lanjut)
                      },
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
