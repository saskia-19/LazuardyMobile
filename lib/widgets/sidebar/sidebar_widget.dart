import 'package:flutter/material.dart';

class SidebarDrawerWidget extends StatelessWidget {
  final String username;
  final String subtitle; //kelas atau mengajar apa

  const SidebarDrawerWidget({
    super.key,
    required this.username,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              username,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildMenuItem(
                    icon: Icons.bar_chart_outlined,
                    label: 'Evaluasi',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.receipt_long_outlined,
                    label: 'Riwayat Transaksi',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.reviews_outlined,
                    label: 'Review Tutor',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.chat_bubble_outline,
                    label: 'Hubungi Kami',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.info_outline,
                    label: 'Tentang Kami',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.settings_outlined,
                    label: 'Pengaturan',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.logout,
                    label: 'Keluar',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF2C8AA4), width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}