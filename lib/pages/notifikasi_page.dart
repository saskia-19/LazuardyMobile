import 'package:flutter/material.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _buildNotifikasiItem(
            'Pembayaran Berhasil',
            'Pembayaran paket Matematika telah berhasil diproses',
            '1 jam yang lalu',
            Icons.payment,
            Colors.green,
          ),
          _buildNotifikasiItem(
            'Jadwal Baru',
            'Sesi belajar Fisika dengan Bu Sari dijadwalkan besok',
            '3 jam yang lalu',
            Icons.calendar_today,
            Colors.blue,
          ),
          _buildNotifikasiItem(
            'Reminder',
            'Jangan lupa mengerjakan tugas Matematika',
            '1 hari yang lalu',
            Icons.notifications,
            Colors.orange,
          ),
          _buildNotifikasiItem(
            'Promo Spesial',
            'Dapatkan diskon 20% untuk paket belajar baru',
            '2 hari yang lalu',
            Icons.local_offer,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildNotifikasiItem(
    String title,
    String message,
    String time,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message),
        trailing: Text(
          time,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}
