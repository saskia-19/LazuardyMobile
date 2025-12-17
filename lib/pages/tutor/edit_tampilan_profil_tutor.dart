import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/tutor/tampilan_profile_tutor_page.dart';
import 'package:flutter_application_1/widgets/dashboard/section_card_widget.dart';
import 'package:flutter_application_1/widgets/dashboard/topbar_widget.dart';
import 'package:flutter_application_1/widgets/form_field_widget.dart';

class EditTampilanProfilTutor extends StatefulWidget {
  const EditTampilanProfilTutor({super.key});

  @override
  State<EditTampilanProfilTutor> createState() =>
      _EditTampilanProfilTutorState();
}

class _EditTampilanProfilTutorState extends State<EditTampilanProfilTutor> {
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

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildFormContent());
  }

  Widget buildFormContent() {
    return SingleChildScrollView(
      child: Column(
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
                          MaterialPageRoute(
                            builder: (context) => TampilanProfileTutorPage(),
                          ),
                        );
                      });
                    },
                    icon: const Icon(Icons.chevron_left, color: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Edit Tampilan Profile Tutor',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),

          Container(
            margin: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SectionWidget(content: [
                    Text(
                      'Tampilan Profil Tutor',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16,),
                  
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
                  ]),
                  
                  SizedBox(height: 32,),

                  CustomSubmitButton(
                    text: 'Simpan', onPressed: _submitForm,
                  )
                ],
              ),
            ) 
          )
        ],
      ),
    );
  }
}
