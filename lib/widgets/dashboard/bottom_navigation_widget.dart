import 'package:flutter/material.dart';
class BottomNavigationWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final List<BottomNavigationBarItem> items;

  const BottomNavigationWidget({
    super.key, 
    this.selectedIndex = 0,
    required this.onItemTapped,
    required this.items
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onItemTapped, 
      selectedItemColor: const Color(0xFF2C8AA4),
      unselectedItemColor: Colors.grey,
      items: items
    );
  }
}

// cara make
// BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
// BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Tutor'),
// BottomNavigationBarItem(
//   icon: Icon(Icons.calendar_month),
//   label: 'Jadwal',
// ),
// BottomNavigationBarItem(
//   icon: Icon(Icons.person_outline),
//   label: 'Profil',
// ),