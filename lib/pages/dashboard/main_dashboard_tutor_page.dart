import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/dashboard/tutor_navigation/home_tutor_page.dart';
import 'package:flutter_application_1/pages/dashboard/tutor_navigation/jadwal_tutor_page.dart';
import 'package:flutter_application_1/pages/dashboard/tutor_navigation/presensi_page.dart';
import 'package:flutter_application_1/pages/dashboard/tutor_navigation/profile_page.dart';
import 'package:flutter_application_1/widgets/dashboard/bottom_navigation_widget.dart';
import 'package:flutter_application_1/widgets/sidebar/sidebar_widget.dart';

class MainDashboardTutorPage extends StatefulWidget {
  int? index;
  MainDashboardTutorPage({super.key, this.index});

  @override
  State<MainDashboardTutorPage> createState() => _MainDashboardTutorPageState();
}

class _MainDashboardTutorPageState extends State<MainDashboardTutorPage> {
  late int _selectedIndex = widget.index ?? 0;

  List<Widget?> get _drawers => [
    const SidebarDrawerWidget(
      username: 'Mardhika',
      subtitle: 'Tutor Mengajar Matematika',
    ),
    null,
    null,
    null,
  ];

  List<Widget?> get _pages => [
    const HomeTutorPage(),
    const PresensiPage(),
    const JadwalTutorPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawers[_selectedIndex],
      body: _pages[_selectedIndex],
      // backgroundColor: AppColor.background,
      bottomNavigationBar: BottomNavigationWidget(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'Presensi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
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
      home: MainDashboardTutorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
