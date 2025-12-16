import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_constants.dart';
import 'package:flutter_application_1/models/menu_item_model.dart';
import 'package:flutter_application_1/widgets/dashboard/bottom_navigation_widget.dart';
import 'package:flutter_application_1/widgets/dashboard/section_card_widget.dart';
import 'package:flutter_application_1/widgets/header/header_dashboard_widget.dart';
import 'package:flutter_application_1/widgets/jadwal_tutor_widget.dart';
import 'package:flutter_application_1/widgets/menu_item_widget.dart';
import 'package:flutter_application_1/widgets/progressbar_widget.dart';
import 'package:flutter_application_1/widgets/sidebar/sidebar_widget.dart';

class DashboardTutorPage extends StatefulWidget {
  const DashboardTutorPage({super.key});

  @override
  State<DashboardTutorPage> createState() => _DashboardTutorPageState();
}

class _DashboardTutorPageState extends State<DashboardTutorPage> {
  final String username = 'Mardhika';
  final String status = 'aktif';
  final int totalPengajuanSiswa = 0;
  final int totalPengajuanDiterima = 0;
  int _selectedIndex = 0;

  final List<MenuItemModel> menuItems = [
    MenuItemModel(
      iconAsset: 'assets/images/icons/daftar_siswa.png',
      label: "Daftar Siswa",
      onTap: () => print('pindah ke halaman daftar siswa'),
    ),
    MenuItemModel(
      iconAsset: 'assets/images/icons/tampilan_profile_tutor.png',
      label: "Tampilan Profil Tutor",
      onTap: () => print('pindah ke halaman profil tutor'),
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

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarDrawer(username: username, subtitle: status),
      body: _buildDashboardTutor(),
      backgroundColor: AppColor.background,
      bottomNavigationBar: BottomNavigationWidget(
        onItemTapped: _onItemTapped, 
        selectedIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Presensi'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ]
      ),
    );
  }

  Widget _buildDashboardTutor() {
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
      home: const DashboardTutorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
