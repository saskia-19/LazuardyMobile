import 'package:flutter/material.dart';

class DataJadwalTutorModel {
  final String mataPelajaran;
  final String namaSiswa;
  final String status;
  final String modePembelajaran;
  final DateTime tanggalWaktu;
  final int jumlahPertemuan;
  final int pertemuanDilakukan;
  final String alamat;

  const DataJadwalTutorModel({
    required this.mataPelajaran,
    required this.namaSiswa,
    required this.status,
    required this.modePembelajaran,
    required this.tanggalWaktu,
    required this.jumlahPertemuan,
    required this.pertemuanDilakukan,
    required this.alamat,
  });
}

class JadwalTutorWidget extends StatelessWidget {
  final String mataPelajaran;
  final String namaSiswa;
  final String status;
  final String modePembelajaran;
  final DateTime tanggalWaktu;
  final int jumlahPertemuan;
  final int pertemuanDilakukan;
  final String alamat;
  
  const JadwalTutorWidget({
    super.key,
    required this.mataPelajaran,
    required this.namaSiswa,
    required this.status,
    required this.modePembelajaran,
    required this.tanggalWaktu,
    required this.jumlahPertemuan,
    required this.pertemuanDilakukan,
    required this.alamat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mataPelajaran,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text('Siswa: $namaSiswa'),
          Text('Status: $status'),
          Text('Mode: $modePembelajaran'),
          Text('Tanggal & Waktu: ${tanggalWaktu.toLocal()}'),
          Text('Pertemuan: $pertemuanDilakukan / $jumlahPertemuan'),
          Text('Alamat: $alamat'),
        ],
      ),
    );
  }
}
