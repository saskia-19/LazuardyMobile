import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/profile/tutor/edit_profile_tutor_page.dart';
import 'package:flutter_application_1/widgets/dashboard/section_card_widget.dart';
import 'package:flutter_application_1/widgets/dashboard/topbar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopbarWidget(
          content: [
            Text(
              'Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              SectionWidget(
                content: [
                  Row(
                    children: [
                      // Foto Profil dengan Ikon Edit
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
                                          const EditProfileTutorPage(),
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

              SectionWidget(
                content: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Detail Alamat',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      InputDummyWidget(label: 'Provinsi'),
                      InputDummyWidget(label: 'Kota/kabupaten'),
                      InputDummyWidget(label: 'Kecamatan'),
                      InputDummyWidget(label: 'Desa/Kota'),
                      InputDummyWidget(
                        label: 'Nama Jalan, Gedung, Nomor Rumah',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InputDummyWidget extends StatelessWidget {
  final String label;
  const InputDummyWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          Text('-'),
          const Divider(color: Colors.grey, thickness: 1),
        ],
      ),
    );
  }
}
