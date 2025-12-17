import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_constants.dart';
import 'package:flutter_application_1/core/enums/data_enum.dart';
import 'package:flutter_application_1/pages/dashboard/main_dashboard_tutor_page.dart';
import 'package:flutter_application_1/pages/dashboard/tutor_navigation/profile_page.dart';
import 'package:flutter_application_1/widgets/dashboard/section_card_widget.dart';
import 'package:flutter_application_1/widgets/dashboard/topbar_widget.dart';
import 'package:flutter_application_1/widgets/form_field_widget.dart';
import 'package:flutter_application_1/models/register_tutor_data_model.dart';
import 'package:flutter_application_1/services/auth/register_tutor_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class EditProfileTutorPage extends StatefulWidget {
  const EditProfileTutorPage({super.key});

  @override
  State<EditProfileTutorPage> createState() => _EditProfileTutorPageState();
}

class _EditProfileTutorPageState extends State<EditProfileTutorPage> {
  final _namaController = TextEditingController();
  String? _selectedJenisKelamin;
  String? _selectedAgama;
  final _whatsappController = TextEditingController();
  String? _selectedBank;
  final _nomorRekeningController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _alamatLengkapController = TextEditingController();

  static const Color lightTextColor = Color(0xFF6B7280);

  String? _selectedProvinsi;
  String? _selectedKota;
  String? _selectedKecamatan;
  String? _selectedDesa;

  double? _latitude;
  double? _longitude;

  List<dynamic> _provinsiList = [];
  List<dynamic> _kotaList = [];
  List<dynamic> _kecamatanList = [];
  List<dynamic> _desaList = [];

  bool _isLoading = false;

  void _submitForm() {}

  final List<String> _listGender = GenderEnum.values
      .map((e) => e.tampil)
      .toList();
  final List<String> _listAgama = AgamaEnum.values
      .map((e) => e.tampil)
      .toList();
  final List<String> _listBank = BankEnum.values.map((e) => e.tampil).toList();

  Widget _buildFormContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TopbarWidget(
            content: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => MainDashboardTutorPage(index: 3))
                        );
                      });
                    },
                    icon: const Icon(Icons.chevron_left, color: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Edit profile',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.all(16),
            child: Form(
              child: Column(
                children: [
                  SectionWidget(
                    content: [
                      Text(
                        'Detail Pribadi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      LabeledFormWrapper(
                        label: 'Nama Lengkap',
                        child: CustomTextFormField(
                          controller: _namaController,
                          labelText: 'Nama lengkap',
                        ),
                      ),

                      LabeledFormWrapper(
                        label: "Jenis Kelamin",
                        child: CustomDropdownFormField(
                          hint: 'Pilih jenis kelamin',
                          value: _selectedJenisKelamin,
                          items: _listGender,
                          onChanged: (String? nilaiBaru) {
                            setState(() {
                              _selectedJenisKelamin = nilaiBaru;
                            });
                          },
                        ),
                      ),

                      // LabeledFormWrapper(
                      //   label: "Tanggal Lahir",
                      //   child: CustomTextFormField(
                      //     controller: _tanggalLahirController,
                      //     labelText: "Tanggal Lahir",
                      //     readOnly: true,
                      //     onTap: () => _selectDate(context),
                      //     suffixIcon: const Icon(
                      //       Icons.calendar_today_outlined,
                      //       color: Colors.grey,
                      //     ),
                      //   ),
                      // ),
                      LabeledFormWrapper(
                        label: "Agama",
                        child: CustomDropdownFormField(
                          hint: 'Pilih agama',
                          value: _selectedAgama,
                          items: _listAgama,
                          onChanged: (String? nilaiBaru) {
                            setState(() {
                              _selectedAgama = nilaiBaru;
                            });
                          },
                        ),
                      ),

                      LabeledFormWrapper(
                        label: "Nomor Whatsapp",
                        child: CustomPhoneNumberField(
                          controller: _whatsappController,
                        ),
                      ),

                      LabeledFormWrapper(
                        label: "Nama Bank",
                        child: CustomDropdownFormField(
                          hint: "Pilih bank",
                          value: _selectedBank,
                          items: _listBank,
                          onChanged: (String? nilaiBaru) {
                            setState(() {
                              _selectedBank = nilaiBaru;
                            });
                          },
                        ),
                      ),

                      LabeledFormWrapper(
                        label: 'Nomor Rekening',
                        child: CustomNumberFormField(
                          controller: _nomorRekeningController,
                        ),
                      ),
                    ],
                  ),

                  SectionWidget(
                    content: [
                      Text(
                        'Detail Alamat',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
                            style: TextStyle(
                              fontSize: 14,
                              color: lightTextColor,
                            ),
                          ),
                          TextButton(
                            onPressed: _mintaIzinLokasi,
                            child: const Text(
                              "Isi Otomatis",
                              style: TextStyle(color: AppColor.primary),
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
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, left: 32, right: 32),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Simpan",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildFormContent());
  }

  // --- Fetch Data API Wilayah ---
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
                  color: AppColor.primary,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Bimbel Lazuardi Membutuhkan Akses Lokasi Anda",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.primary,
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
                        side: const BorderSide(color: AppColor.primary),
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
                        style: TextStyle(color: AppColor.primary),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _ambilLokasi();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
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
              CircularProgressIndicator(color: AppColor.primary),
              SizedBox(height: 20),
              Text(
                "Mengambil Lokasi Anda",
                style: TextStyle(
                  color: AppColor.primary,
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

    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
    });

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
          initialValue: value,
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
