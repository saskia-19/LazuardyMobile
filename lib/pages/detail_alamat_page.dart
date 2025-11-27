import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:flutter_application_1/pages/dashboard_siswa_page.dart';

class DetailAlamatPage extends StatefulWidget {
  final String namaSiswa;

  const DetailAlamatPage({super.key, required this.namaSiswa});

  @override
  State<DetailAlamatPage> createState() => _DetailAlamatPageState();
}

class _DetailAlamatPageState extends State<DetailAlamatPage> {
  final _formKey = GlobalKey<FormState>();
  final _alamatLengkapController = TextEditingController();

  String? _selectedProvinsi;
  String? _selectedKota;
  String? _selectedKecamatan;
  String? _selectedDesa;

  List<dynamic> _provinsiList = [];
  List<dynamic> _kotaList = [];
  List<dynamic> _kecamatanList = [];
  List<dynamic> _desaList = [];

  bool _isLoading = false;

  static const Color primaryColor = Color(0xFF3B9CA7);
  static const Color textColor = Color(0xFF1F2937);
  static const Color lightTextColor = Color(0xFF6B7280);

  @override
  void initState() {
    super.initState();
    _fetchProvinsi();
  }

  // --- Fetch Data API ---
  Future<void> _fetchProvinsi() async {
    setState(() => _isLoading = true);
    final url = Uri.parse(
      "https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json",
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        _provinsiList = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchKota(String provId) async {
    setState(() {
      _isLoading = true;
      _kotaList = [];
      _kecamatanList = [];
      _desaList = [];
    });
    final url = Uri.parse(
      "https://www.emsifa.com/api-wilayah-indonesia/api/regencies/$provId.json",
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        _kotaList = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchKecamatan(String kotaId) async {
    setState(() {
      _isLoading = true;
      _kecamatanList = [];
      _desaList = [];
    });
    final url = Uri.parse(
      "https://www.emsifa.com/api-wilayah-indonesia/api/districts/$kotaId.json",
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        _kecamatanList = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchDesa(String kecId) async {
    setState(() {
      _isLoading = true;
      _desaList = [];
    });
    final url = Uri.parse(
      "https://www.emsifa.com/api-wilayah-indonesia/api/villages/$kecId.json",
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        _desaList = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  // --- IZIN LOKASI ---
  Future<void> _mintaIzinLokasi() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 60,
                  color: primaryColor,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Bimbel Lazuardi Membutuhkan Akses Lokasi Anda",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Untuk menjaga keamanan dan kenyamanan Anda, Bimbel Private Lazuardi memerlukan izin akses lokasi. Dengan izin ini, layanan dapat disesuaikan seperti menampilkan tutor terdekat sesuai kebutuhan Anda.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: lightTextColor, fontSize: 14),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        "Tolak",
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _ambilLokasi();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        "Izinkan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- AMBIL LOKASI DENGAN LOADING ---
  Future<void> _ambilLokasi() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(color: primaryColor),
              SizedBox(height: 20),
              Text(
                "Mengambil Lokasi Anda",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Layanan lokasi belum diaktifkan")),
      );
      return;
    }

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Izin lokasi ditolak")));
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      setState(() {
        _alamatLengkapController.text =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}";
      });
    }

    Navigator.pop(context); // Tutup dialog "Mengambil Lokasi"
  }

  // --- Submit Form ---
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardSiswaPage(namaSiswa: widget.namaSiswa),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryColor))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/logo_lazuardi_noText.png',
                            height: 80,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Bimbel Lazuardy',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Detail Alamat',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildCustomDropdown(
                      label: "Provinsi",
                      value: _selectedProvinsi,
                      items: _provinsiList,
                      onChanged: (val) {
                        final selected = _provinsiList.firstWhere(
                          (e) => e["name"] == val,
                        );
                        setState(() => _selectedProvinsi = val);
                        _fetchKota(selected["id"].toString());
                      },
                    ),
                    _buildCustomDropdown(
                      label: "Kota/Kabupaten",
                      value: _selectedKota,
                      items: _kotaList,
                      isEnabled: _selectedProvinsi != null,
                      onChanged: (val) {
                        final selected = _kotaList.firstWhere(
                          (e) => e["name"] == val,
                        );
                        setState(() => _selectedKota = val);
                        _fetchKecamatan(selected["id"].toString());
                      },
                    ),
                    _buildCustomDropdown(
                      label: "Kecamatan",
                      value: _selectedKecamatan,
                      items: _kecamatanList,
                      isEnabled: _selectedKota != null,
                      onChanged: (val) {
                        final selected = _kecamatanList.firstWhere(
                          (e) => e["name"] == val,
                        );
                        setState(() => _selectedKecamatan = val);
                        _fetchDesa(selected["id"].toString());
                      },
                    ),
                    _buildCustomDropdown(
                      label: "Desa/Kelurahan",
                      value: _selectedDesa,
                      items: _desaList,
                      isEnabled: _selectedKecamatan != null,
                      onChanged: (val) => setState(() => _selectedDesa = val),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Nama Jalan, Gedung, Nomor Rumah",
                          style: TextStyle(fontSize: 14, color: lightTextColor),
                        ),
                        TextButton(
                          onPressed: _mintaIzinLokasi,
                          child: const Text(
                            "Isi Otomatis",
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: _alamatLengkapController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Alamat tidak boleh kosong" : null,
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Selanjutnya",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildCustomDropdown({
    required String label,
    required String? value,
    required List items,
    required Function(String?) onChanged,
    bool isEnabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: lightTextColor),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          onChanged: isEnabled ? onChanged : null,
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: items
              .map<DropdownMenuItem<String>>(
                (e) => DropdownMenuItem<String>(
                  value: e["name"],
                  child: Text(e["name"]),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
