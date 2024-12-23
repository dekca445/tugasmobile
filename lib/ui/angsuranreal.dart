import 'package:flutter/material.dart';

class KelolaAngsuranPage extends StatefulWidget {
  const KelolaAngsuranPage({super.key});

  @override
  State<KelolaAngsuranPage> createState() => _KelolaAngsuranPageState();
}

class _KelolaAngsuranPageState extends State<KelolaAngsuranPage> {
  final List<Map<String, dynamic>> _angsuranList = [];
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  String _selectedStatus = '';

  // Fungsi Tambah Angsuran
  void _tambahAngsuran() {
    try {
      double jumlah = double.parse(_jumlahController.text);

      if (_namaController.text.isNotEmpty &&
          jumlah > 0 &&
          _tanggalController.text.isNotEmpty &&
          _selectedStatus.isNotEmpty) {
        setState(() {
          _angsuranList.add({
            "nama": _namaController.text,
            "jumlah": jumlah,
            "tanggal": _tanggalController.text,
            "status": _selectedStatus,
          });
        });
        _clearFields();
      }
    } catch (e) {
      _showErrorDialog("Jumlah angsuran harus berupa angka valid!");
    }
  }

  // Fungsi Hapus Angsuran
  void _hapusAngsuran(int index) {
    setState(() {
      _angsuranList.removeAt(index);
    });
  }

  // Fungsi Edit Angsuran
  void _editAngsuran(int index) {
    final data = _angsuranList[index];
    _namaController.text = data["nama"];
    _jumlahController.text = data["jumlah"].toString();
    _tanggalController.text = data["tanggal"];
    _selectedStatus = data["status"];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey[900],
          title: const Text("Edit Data Angsuran", style: TextStyle(color: Colors.white)),
          content: _buildInputFields(),
          actions: [
            TextButton(
              onPressed: () {
                _clearFields();
                Navigator.pop(context);
              },
              child: const Text("Batal", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                try {
                  double jumlah = double.parse(_jumlahController.text);
                  setState(() {
                    _angsuranList[index] = {
                      "nama": _namaController.text,
                      "jumlah": jumlah,
                      "tanggal": _tanggalController.text,
                      "status": _selectedStatus,
                    };
                  });
                  _clearFields();
                  Navigator.pop(context);
                } catch (e) {
                  _showErrorDialog("Jumlah angsuran harus berupa angka valid!");
                }
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  // Input Fields Builder
  Widget _buildInputFields() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _namaController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Nama Pelanggan",
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _jumlahController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Jumlah Angsuran",
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _tanggalController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Tanggal Jatuh Tempo",
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _selectedStatus.isEmpty ? null : _selectedStatus,
            items: const [
              DropdownMenuItem(value: "Lunas", child: Text("Lunas")),
              DropdownMenuItem(value: "Belum Lunas", child: Text("Belum Lunas")),
            ],
            onChanged: (value) {
              setState(() {
                _selectedStatus = value!;
              });
            },
            dropdownColor: Colors.blueGrey[800],
            decoration: const InputDecoration(
              labelText: "Status",
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Clear Input Fields
  void _clearFields() {
    _namaController.clear();
    _jumlahController.clear();
    _tanggalController.clear();
    setState(() {
      _selectedStatus = '';
    });
  }

  // Show Error Dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey[900],
        title: const Text("Error", style: TextStyle(color: Colors.white)),
        content: Text(message, style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: const Text("Kelola Angsuran"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Input Angsuran Baru",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            _buildInputFields(),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _tambahAngsuran,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.all(15),
              ),
              child: const Center(
                child: Text("+ Tambah Angsuran", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Daftar Angsuran",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _angsuranList.isEmpty
                  ? const Center(
                      child: Text(
                        "Belum ada data angsuran.",
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _angsuranList.length,
                      itemBuilder: (context, index) {
                        final angsuran = _angsuranList[index];
                        return Card(
                          color: Colors.blueGrey[800],
                          elevation: 3,
                          child: ListTile(
                            leading: const Icon(Icons.attach_money, color: Colors.blueAccent),
                            title: Text(angsuran["nama"], style: TextStyle(color: Colors.white)),
                            subtitle: Text(
                              "Jumlah: ${angsuran["jumlah"]} | Tanggal: ${angsuran["tanggal"]} | Status: ${angsuran["status"]}",
                              style: TextStyle(color: Colors.white70),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _editAngsuran(index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _hapusAngsuran(index),
                                ),
                              ],
                            ),
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