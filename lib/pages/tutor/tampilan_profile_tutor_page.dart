import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/dashboard/main_dashboard_tutor_page.dart';
import 'package:flutter_application_1/pages/tutor/edit_tampilan_profil_tutor.dart';
import 'package:flutter_application_1/widgets/dashboard/section_card_widget.dart';
import 'package:flutter_application_1/widgets/dashboard/topbar_widget.dart';
import 'package:flutter_application_1/widgets/form_field_widget.dart';

class TampilanProfileTutorPage extends StatefulWidget {
  const TampilanProfileTutorPage({super.key});

  @override
  State<TampilanProfileTutorPage> createState() =>
      _TampilanProfileTutorPageState();
}

class _TampilanProfileTutorPageState extends State<TampilanProfileTutorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildContent(),
    );
  }

  Widget buildContent() {
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
                            builder: (context) => MainDashboardTutorPage(),
                          ),
                        );
                      });
                    },
                    icon: const Icon(Icons.chevron_left, color: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Tampilan Profile Tutor',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),

          Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionWidget(
                  content: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey[300],
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.blueGrey),
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 32),
                        // Info Teks
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Budi Santoso',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'budisantoso@gmail.com',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text(
                                '(+62) 89676785840',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 8),
                              // Tombol Edit Profil
                              SizedBox(
                                height: 35,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EditTampilanProfilTutor(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(
                                      0xFF2B8DA3,
                                    ), // Warna teal di gambar
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text(
                                    'Edit Profil',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SectionWidget(content: [
                  Text(
                    'Detail Pribadi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16,),
                  LabeledFormWrapper(
                    label: "Mode kursus", 
                    fontWeight: FontWeight.w600,
                    child: CustomTextFormField(
                      controller: null,
                      readOnly: true,
                      initialValue: "online",
                    )
                  ),

                  LabeledFormWrapper(
                    label: 'Deskripsi', 
                    child: CustomTextFormField(
                      controller: null,
                      readOnly: true,
                      initialValue: 'sedwwefefwcwscwecw',
                    )
                  ),

                  LabeledFormWrapper(
                    label: 'Kualifikasi', 
                    child: CustomTextFormField(
                      controller: null,
                      readOnly: true,
                      initialValue: 'wvdwvJCVEHIEB',
                    )
                  ),

                  LabeledFormWrapper(
                    label: 'Metode mengajar', 
                    child: CustomTextFormField(
                      controller: null,
                      readOnly: true,
                      initialValue: 'wuwnawbin aidbbhwj',
                    )
                  ),                  
                ])
              ],
            )
          )
        ],
      ),
    );
  }
}
