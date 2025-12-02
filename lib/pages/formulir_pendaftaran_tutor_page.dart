import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/form_field_widget.dart';
import 'package:flutter_application_1/widgets/header_widget.dart';
import 'package:image_picker/image_picker.dart';

class FormulirPendaftaranTutorPage extends StatefulWidget {
  const FormulirPendaftaranTutorPage({super.key});

  @override
  State<FormulirPendaftaranTutorPage> createState() =>
      _FormulirPendaftaranTutorPageState();
}

class _FormulirPendaftaranTutorPageState extends State<FormulirPendaftaranTutorPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedKelas;
  String? _selectedMataPelajaran;
  final _pengalamanController = TextEditingController();
  final _organisasiController = TextEditingController();

  List<PlatformFile>? _cvFile;
  PlatformFile? _ktpFile;
  List<PlatformFile>? _ijazahFile;
  List<PlatformFile>? _sertifikatFile;
  List<PlatformFile>? _portofolioFile;

  List<String> _kelasOptions = [];
  List<String> _mataPelajaranOptions = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildFormulirPendaftaran(),
    );
  }

  Widget _buildFormulirPendaftaran() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LogoHeaderWidget(withTextLogo: true,),

              LabeledFormWrapper(
                label: "Kelas", 
                child: CustomDropdownFormField(
                  hint: 'Pilih kelas',
                  value: _selectedKelas,
                  items: _kelasOptions,
                  onChanged: (String? nilaiBaru) {
                  setState(() {
                    _selectedKelas = nilaiBaru;
                  });
                },
                )
              ),

              LabeledFormWrapper(
                label: "Mata Pelajaran", 
                child: CustomDropdownFormField(
                  hint: 'Pilih mata pelajaran',
                  value: _selectedMataPelajaran,
                  items: _mataPelajaranOptions,
                  onChanged: (String? nilaiBaru) {
                  setState(() {
                    _selectedKelas = nilaiBaru;
                  });
                },
                )
              ),

              LabeledFormWrapper(
                label: 'Pengalaman',
                child: CustomTextFormField(
                  controller: _pengalamanController,
                  labelText: 'Ceritakan pengalaman Anda',
                  maxLines: 5,
                ),
              ),

              LabeledFormWrapper(
                label: 'Pengalaman',
                child: CustomTextFormField(
                  controller: _pengalamanController,
                  labelText: 'Ceritakan pengalaman Anda',
                  maxLines: 5,
                ),
              ),

              LabeledFormWrapper(
                label: "Organisasi", 
                child: CustomTagInputField(
                  labelText: 'Organisasi', 
                  onChanged: (newTags){
                    setState(() {
                      _organisasiController.text = newTags.join(', ');
                    });
                  }
                )
              ),

              LabeledFormWrapper(
                label: 'CV', 
                child: CustomFilePickerField(
                  labelText: 'Unggah CV',
                  maxFiles: 5,
                  onFilesPicked: (files) {
                    setState(() {
                      _cvFile = files;
                    });
                  },
                ),
              ),

              LabeledFormWrapper(
                label: 'KTP', 
                child: CustomFilePickerField(
                  labelText: 'Unggah KTP',
                  maxFiles: 1,
                  onFilesPicked: (files) {
                    setState(() {
                      _cvFile = files;
                    });
                  },
                ),
              ),

              LabeledFormWrapper(
                label: 'Ijazah', 
                child: CustomFilePickerField(
                  labelText: 'Unggah Ijazah',
                  maxFiles: 5,
                  onFilesPicked: (files) {
                    setState(() {
                      _ijazahFile = files;
                    });
                  },
                ),
              ),

              LabeledFormWrapper(
                label: 'Sertifikat Keahlian / Pelatihan', 
                child: CustomFilePickerField(
                  labelText: 'Unggah Sertifikat Keahlian / Pelatihan',
                  maxFiles: 5,
                  onFilesPicked: (files) {
                    setState(() {
                      _sertifikatFile = files;
                    });
                  },
                ),
              ),

              LabeledFormWrapper(
                label: 'Portofolio', 
                child: CustomFilePickerField(
                  labelText: 'Unggah portofolio',
                  maxFiles: 5,
                  onFilesPicked: (files) {
                    setState(() {
                      _sertifikatFile = files;
                    });
                  },
                ),
              ),

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
      home: const FormulirPendaftaranTutorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}