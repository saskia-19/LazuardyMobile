import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_constants.dart';
import 'package:flutter_application_1/models/menu_item_model.dart';
import 'package:flutter_application_1/pages/tutor/tampilan_profile_tutor_page.dart';
import 'package:flutter_application_1/widgets/dashboard/section_card_widget.dart';
import 'package:flutter_application_1/widgets/header/header_dashboard_widget.dart';
import 'package:flutter_application_1/widgets/jadwal_tutor_widget.dart';
import 'package:flutter_application_1/widgets/menu_item_widget.dart';
import 'package:flutter_application_1/widgets/progressbar_widget.dart';

class HomeTutorPage extends StatefulWidget {
  const HomeTutorPage({super.key});

  @override
  State<HomeTutorPage> createState() => _HomeTutorPageState();
}

class _HomeTutorPageState extends State<HomeTutorPage> {
  final String username = 'Mardhika';
  final String status = 'aktif';
  final int totalPengajuanSiswa = 0;
  final int totalPengajuanDiterima = 0;

  List<MenuItemModel> get menuItems { 
    return [
      MenuItemModel(
        iconAsset: 'assets/images/icons/daftar_siswa.png',
        label: "Daftar Siswa",
        onTap: () => print('pindah ke halaman daftar siswa'),
      ),
      MenuItemModel(
        iconAsset: 'assets/images/icons/tampilan_profile_tutor.png',
        label: "Tampilan Profil Tutor",
        onTap: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => TampilanProfileTutorPage())
          );
        },
      ),
      MenuItemModel(
        iconAsset: 'assets/images/icons/lencana.png',
        label: "Lencana",
        onTap: () => print('pindah ke halaman lencana'),
      ),
      MenuItemModel(
        iconAsset: 'assets/images/icons/ulasan.png',
        label: "Ulasan",
        onTap: () => print('pindah ke halaman ulasan'),
      ),
    ];
  }

  final List<DataJadwalTutorModel> jadwalTutor = [
    DataJadwalTutorModel(
      mataPelajaran: 'Matematika',
      namaSiswa: 'Andi',
      status: 'aktif',
      modePembelajaran: 'Online',
      tanggalWaktu: DateTime.now(),
      jumlahPertemuan: 10,
      pertemuanDilakukan: 5,
      alamat: 'Jl. Merdeka No. 10',
    ),
    DataJadwalTutorModel(
      mataPelajaran: 'Fisika',
      namaSiswa: 'Budi',
      status: 'Menunggu',
      modePembelajaran: 'Offline',
      tanggalWaktu: DateTime.now().add(const Duration(days: 2)),
      jumlahPertemuan: 8,
      pertemuanDilakukan: 0,
      alamat: 'Jl. Sudirman No. 20',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header AppBar
          Builder(
            builder: (builderContext) {
              return HeaderDashboardWidget(
                username: username,
                builderContext: builderContext,
              );
            },
          ),
          // Pembuka
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionCardWidget(
                  content: [
                    Image.asset('assets/images/logo_memanjang.png'),
                    const SizedBox(height: 16),
                    Text(
                      'Bimbel Lazuardy adalah platform bimbingan belajar inovatif yang dirancang untuk mewujudkan proses belajar tanpa batas dengan pengalaman yang nyaman dan terpersonalisasi',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                SectionCardWidget(
                  content: [
                    Text(
                      'Menu Cepat',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.72,
                      children: menuItems.map((item) {
                        return MenuItemWidget(
                          iconAsset: item.iconAsset,
                          label: item.label,
                          onTap: item.onTap,
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                SectionCardWidget(
                  content: [
                    Text(
                      'Pengajuan Belajar',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total pengajuan siswa:'),
                        Text('$totalPengajuanSiswa'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total pengajuan diterima:'),
                        Text('$totalPengajuanDiterima'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ProgressbarWidget(progressValue: 0.50),
                    const SizedBox(height: 8),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '   Jadwal Tutor',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 241, 241, 241),
                  ),
                  textAlign: TextAlign.left,
                ),

                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: jadwalTutor.map((item) {
                      return SectionCardWidget(
                        content: [
                          JadwalTutorWidget(
                            mataPelajaran: item.mataPelajaran,
                            namaSiswa: item.namaSiswa,
                            status: item.status,
                            modePembelajaran: item.modePembelajaran,
                            tanggalWaktu: item.tanggalWaktu,
                            jumlahPertemuan: item.jumlahPertemuan,
                            pertemuanDilakukan: item.pertemuanDilakukan,
                            alamat: item.alamat,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
