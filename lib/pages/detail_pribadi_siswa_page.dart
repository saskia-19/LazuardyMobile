import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/pages/detail_alamat_page.dart';

class DetailPribadiPage extends StatefulWidget {
  const DetailPribadiPage({super.key});

  @override
  State<DetailPribadiPage> createState() => _DetailPribadiPageState();
}

class _DetailPribadiPageState extends State<DetailPribadiPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  String? _selectedKelas;
  String? _selectedJenisKelamin;
  final _tanggalLahirController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _namaOrtuController = TextEditingController();
  final _whatsappOrtuController = TextEditingController();

  DateTime? _selectedDate;
  XFile? _imageFile;

  final List<String> _kelasList = [
    'SD Kelas 1',
    'SD Kelas 2',
    'SD Kelas 3',
    'SD Kelas 4',
    'SD Kelas 5',
    'SD Kelas 6',
    'SMP Kelas 7',
    'SMP Kelas 8',
    'SMP Kelas 9',
    'SMA Kelas 10',
    'SMA Kelas 11',
    'SMA Kelas 12',
  ];
  final List<String> _jenisKelaminList = ['Laki-laki', 'Perempuan'];

  // PINDAHKAN VARIABEL KE SINI, DI LUAR BUILD METHOD
  final Color _borderColor = const Color(0xFFCBD5E1);

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _tanggalLahirController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Validasi form berhasil, lanjutkan ke halaman alamat
      // Ambil nama dari controller dan kirim ke DetailAlamatPage
      String namaSiswa = _namaController.text.trim();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailAlamatPage(namaSiswa: namaSiswa),
        ),
      );
    } else {
      print('Form tidak valid');
      // Tampilkan snackbar atau alert untuk memberi tahu user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi semua field yang wajib diisi'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF3B9CA7);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- LOGO DAN JUDUL BRAND ---
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ganti 'assets/images/logo.png' dengan path logo Anda
                    Image.asset(
                      'assets/images/logo_lazuardi_noText.png',
                      height: 80,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Bimbel Lazuardy',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // --- BAGIAN DETAIL PRIBADI ---
              _buildSectionHeader('Detail Pribadi'),
              _buildLabeledWidget(
                label: 'Nama Lengkap',
                child: _buildTextFormField(controller: _namaController),
              ),
              _buildLabeledWidget(
                label: 'Kelas',
                child: _buildDropdownFormField(
                  hint: 'Pilih Kelas',
                  value: _selectedKelas,
                  items: _kelasList,
                  onChanged: (value) {
                    setState(() => _selectedKelas = value);
                  },
                ),
              ),
              _buildLabeledWidget(
                label: 'Jenis kelamin',
                child: _buildDropdownFormField(
                  hint: 'Pilih Jenis Kelamin',
                  value: _selectedJenisKelamin,
                  items: _jenisKelaminList,
                  onChanged: (value) {
                    setState(() => _selectedJenisKelamin = value);
                  },
                ),
              ),
              _buildLabeledWidget(
                label: 'Tanggal Lahir',
                child: _buildTextFormField(
                  controller: _tanggalLahirController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  suffixIcon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              _buildLabeledWidget(
                label: 'Nomor WhatsApp',
                child: _buildPhoneNumberField(controller: _whatsappController),
              ),
              _buildLabeledWidget(
                label: 'Foto Profile',
                child: _buildImagePickerField(),
              ),

              // --- BAGIAN KONTAK ORANG TUA/WALI ---
              _buildSectionHeader('Kotak Orang Tua/Wali'),
              _buildLabeledWidget(
                label: 'Nama Orang Tua/Wali',
                child: _buildTextFormField(controller: _namaOrtuController),
              ),
              _buildLabeledWidget(
                label: 'Nomor WhatsApp Orang Tua/Wali',
                child: _buildPhoneNumberField(
                  controller: _whatsappOrtuController,
                ),
              ),

              const SizedBox(height: 24),
              // --- TOMBOL SELANJUTNYA ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Selanjutnya',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget untuk membuat header section
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Helper widget untuk membuat label di atas field
  Widget _buildLabeledWidget({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        child,
        const SizedBox(height: 16),
      ],
    );
  }

  // Helper widget untuk TextFormField
  Widget _buildTextFormField({
    required TextEditingController controller,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      // GUNAKAN VARIABEL _borderColor DI SINI
      decoration: _inputDecoration(suffixIcon: suffixIcon),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Kolom ini tidak boleh kosong';
        }
        return null;
      },
    );
  }

  // Helper widget untuk DropdownButtonFormField
  Widget _buildDropdownFormField({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      // GUNAKAN VARIABEL _borderColor DI SINI
      decoration: _inputDecoration(),
      isExpanded: true,
      hint: Text(hint, style: const TextStyle(color: Colors.grey)),
      value: value,
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Silakan pilih salah satu';
        }
        return null;
      },
    );
  }

  // Helper widget untuk input nomor telepon
  Widget _buildPhoneNumberField({required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      // GUNAKAN VARIABEL _borderColor DI SINI
      decoration: _inputDecoration(
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '+62',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nomor WhatsApp tidak boleh kosong';
        }
        if (value.length < 9) {
          return 'Nomor WhatsApp terlalu pendek';
        }
        return null;
      },
    );
  }

  // Helper widget untuk image picker
  Widget _buildImagePickerField() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          // GUNAKAN VARIABEL _borderColor DI SINI
          border: Border.all(color: _borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.photo_camera_outlined, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _imageFile?.name ?? 'Pilih foto...',
                style: TextStyle(
                  color: _imageFile == null ? Colors.grey : Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dekorasi input yang seragam
  InputDecoration _inputDecoration({Widget? prefixIcon, Widget? suffixIcon}) {
    // HAPUS DEFINISI borderColor DARI SINI
    return InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _borderColor), // GUNAKAN VARIABEL KELAS
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _borderColor), // GUNAKAN VARIABEL KELAS
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF3B9CA7), width: 2),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tanggalLahirController.dispose();
    _whatsappController.dispose();
    _namaOrtuController.dispose();
    _whatsappOrtuController.dispose();
    super.dispose();
  }
}
