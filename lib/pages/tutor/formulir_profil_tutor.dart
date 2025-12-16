import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/form_field_widget.dart';
import 'package:flutter_application_1/widgets/header_widget.dart';

class FormulirProfilTutor extends StatefulWidget {
  const FormulirProfilTutor({super.key});

  @override
  State<FormulirProfilTutor> createState() => _FormulirProfilTutorState();
}

class _FormulirProfilTutorState extends State<FormulirProfilTutor> {
  final _formKey = GlobalKey<FormState>();
  final _deskripsiController = TextEditingController();
  final _metodeMengajarController = TextEditingController();
  List<String>? _kualifikasiData = [];
  List<TimeOfDay>? _waktuTersedia = [];
  List<TimeOfDay>? _hariTersedia = [];
  String? _selectedModePembelajaran;

  List<String> _modePembelajaranOptions = ['Online', 'Offline'];
  List<String> _hariOptions = [
    'Senin',
    'Selasa',
    'Rabu',
    'kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Proses data form di sini
      print('Form submitted successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildFormulirProfilTutor(),
    );
  }

  Widget _buildFormulirProfilTutor() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              LogoHeaderWidget(withTextLogo: true,),
              CustomTextSectionHeader(
                title: 'Formulir Profil Tutor',
              ),
              LabeledFormWrapper(
                label: "Mode Pembelajaran",
                child: CustomDropdownFormField(
                  hint: 'Pilih mode pembelajaran',
                  value: _selectedModePembelajaran,
                  items: _modePembelajaranOptions,
                  onChanged: (value) {
                    setState(() {
                      _selectedModePembelajaran = value;
                    });
                  },
                ),
              ),

              LabeledFormWrapper(
                label: "Deskripsi Tentang Anda",
                child: CustomTextFormField(
                  controller: _deskripsiController,
                  labelText: 'Ceritakan tentang diri Anda sebagai tutor',
                  maxLines: 5,
                ),
              ),

              LabeledFormWrapper(
                label: "Kualifikasi",
                child: CustomTagInputField(
                  labelText: "Tambah kualifikasi",
                  onChanged: (tags) {
                    setState(() {
                      _kualifikasiData = tags;
                    });
                  },
                ),
              ),

              LabeledFormWrapper(
                label: "Metode Mengajar",
                child: CustomTextFormField(
                  controller: _metodeMengajarController,
                  labelText: 'Jelaskan metode mengajar Anda',
                  maxLines: 5,
                ),
              ),

              CustomSubmitButton(
                text: 'Simpan', onPressed: _submitForm,
              )

              // LabeledFormWrapper(label: label, child: child)
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lazuardi App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FormulirProfilTutor(),
      debugShowCheckedModeBanner: false,
    );
  }
}
