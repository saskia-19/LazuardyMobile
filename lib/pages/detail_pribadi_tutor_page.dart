import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_constants.dart';
import 'package:flutter_application_1/models/form_data_model.dart';
import 'package:flutter_application_1/services/get_register_form_service.dart';
import 'package:flutter_application_1/widgets/header_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/widgets/form_field_widget.dart';

class DetailPribadiTutorPage extends StatefulWidget {
  const DetailPribadiTutorPage({super.key});

  @override
  State<DetailPribadiTutorPage> createState() => _DetailPribadiTutorPageState();
}

class _DetailPribadiTutorPageState extends State<DetailPribadiTutorPage> {
  // Data state
  // Identitas form untuk validasi
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  String? _selectedJenisKelamin;
  String? _selectedAgama;
  final _whatsappController = TextEditingController();
  String? _selectedBank;
  final _nomorRekeningController = TextEditingController();
  final _tanggalLahirController = TextEditingController();

  DateTime? _selectedTanggalLahir;
  XFile? _imageFile;

  FormDataModel? formData;
  var isLoaded = false;
  List<String> _genderOptions = [];
  List<String> _religionOptions = [];
  List<String> _bankOptions = [];

  @override
  void initState() {
    super.initState();

    // fetch data dari API
    getData();
  }

  getData() async {
    try {
      formData = await GetRegisterFormService().getFormData();
      if (formData != null) {
        final data = formData!;

        setState(() {
          _genderOptions = data.gender;
          _religionOptions = data.religion;
          _bankOptions = data.bank;
          isLoaded = true;
        });
      } else {
        _showErrorDialog('Data dari API kosong');
      }
    } catch (e) {
      _showErrorDialog('Error: $e');
      print('Error fetching form data: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedTanggalLahir ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedTanggalLahir) {
      setState(() {
        _selectedTanggalLahir = picked;
        _tanggalLahirController.text =
            '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  // Menghapus controller setelah digunakan
  @override
  void dispose() {
    _namaController.dispose();
    _tanggalLahirController.dispose();
    _whatsappController.dispose();
    _nomorRekeningController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_selectedTanggalLahir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap pilih tanggal lahir'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      String tanggalLahir = _selectedTanggalLahir!.toIso8601String();

      final Map<String, dynamic> dataTutor = {
        'nama': _namaController.text.trim(),
        'jenisKelamin': _selectedJenisKelamin!,
        'agama': _selectedAgama!,
        'whatsapp': _whatsappController.text,
        'bank': _selectedBank!,
        'tanggal_lahir': tanggalLahir,
        'rekening': _nomorRekeningController.text,
        'fotoProfile': _imageFile,
      };

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const DetailAlamatPage(), // Halaman yang dituju
      //   ),
      // );

      print('Data siap dikirim: $dataTutor');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi semua field yang wajib diisi'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded
          ? _buildFormContent()
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildFormContent() {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            
            LogoHeaderWidget(withTextLogo: true,),

            CustomTextSectionHeader(title: 'Detail Pribadi'),

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
                items: _genderOptions,
                onChanged: (String? nilaiBaru) {
                  setState(() {
                    _selectedJenisKelamin = nilaiBaru;
                  });
                },
              ),
            ),

            LabeledFormWrapper(
              label: "Tanggal Lahir",
              child: CustomTextFormField(
                controller: _tanggalLahirController,
                labelText: "Tanggal Lahir",
                readOnly: true,
                onTap: () => _selectDate(context),
                suffixIcon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
              ),
            ),

            LabeledFormWrapper(
              label: "Agama",
              child: CustomDropdownFormField(
                hint: 'Pilih agama',
                value: _selectedAgama,
                items: _religionOptions,
                onChanged: (String? nilaiBaru) {
                  setState(() {
                    _selectedAgama = nilaiBaru;
                  });
                },
              ),
            ),

            LabeledFormWrapper(
              label: "Nomor Whatsapp",
              child: CustomPhoneNumberField(controller: _whatsappController),
            ),

            LabeledFormWrapper(
              label: "Nama Bank",
              child: CustomDropdownFormField(
                hint: "Pilih bank",
                value: _selectedBank,
                items: _bankOptions,
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

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
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
    );
  }
}

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Lazuardi App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//         useMaterial3: true,
//       ),
//       home: const DetailPribadiTutorPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
