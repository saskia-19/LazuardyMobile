import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/enums/tanggal_enum.dart';
import 'package:flutter_application_1/widgets/dashboard/kotak_tanggal_widget.dart';
import 'package:flutter_application_1/widgets/dashboard/section_card_widget.dart';
import 'package:flutter_application_1/widgets/dashboard/topbar_widget.dart';
import 'package:flutter_application_1/widgets/jadwal_tutor_widget.dart';

class JadwalTutorPage extends StatefulWidget {
  const JadwalTutorPage({super.key});

  @override
  State<JadwalTutorPage> createState() => _JadwalTutorPageState();
}

class _JadwalTutorPageState extends State<JadwalTutorPage> {
  DateTime sekarang = DateTime.now();
  late DateTime seninSekarang = sekarang.subtract(
    Duration(days: sekarang.weekday - 1),
  );
  late DateTime seninTampil = seninSekarang;
  late DateTime mingguTampil = seninTampil.add(Duration(days: 6));
  late DateTime tanggalDipilih = sekarang;

  @override
  Widget build(BuildContext context) {
    
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

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TopbarWidget(
            content: [
              Text(
                'Jadwal Anda',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          // Atur tanggal minggu tampil
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    seninTampil = seninTampil.subtract(Duration(days: 7));
                    mingguTampil = seninTampil.add(Duration(days: 6));
                  });
                },
                icon: const Icon(Icons.chevron_left, color: Colors.grey),
              ),
              const SizedBox(width: 16),
              Text(
                '${seninTampil.day} ${BulanEnum.fromDateTime(seninTampil.month).tampilSingkat} ${seninTampil.year} - ${mingguTampil.day} ${BulanEnum.fromDateTime(mingguTampil.month).tampilSingkat} ${mingguTampil.year}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {
                  setState(() {
                    seninTampil = seninTampil.add(Duration(days: 7));
                    mingguTampil = seninTampil.add(Duration(days: 6));
                  });
                },
                icon: const Icon(Icons.chevron_right, color: Colors.grey),
              ),
            ],
          ),

          // Tanggal hari ini
          Row(
            children: [
              Text(
                '${sekarang.day}',
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    HariEnum.fromDateTime(sekarang.weekday).tampil,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${BulanEnum.fromDateTime(sekarang.month).tampil} ${sekarang.year}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
              // Kita hitung tanggal berdasarkan index (0-6)
              DateTime tanggalTarget = seninTampil.add(Duration(days: index));

              return KotakTanggalWidget(
                hari: HariEnum.fromDateTime(
                  tanggalTarget.weekday,
                ).tampilSingkat,
                tanggal: tanggalTarget,
                isSelected: tanggalTarget.day == tanggalDipilih.day &&
                    tanggalTarget.month == tanggalDipilih.month &&
                    tanggalTarget.year == tanggalDipilih.year,
                onTap: () {
                  setState(() {
                    tanggalDipilih = tanggalTarget; 
                  });
                },
              );
            }),
          ),

          const SizedBox(height: 16,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time),
              Text('Semangat! Anda memiliki 3 jadwal hari ini.')],
          ),

          const SizedBox(height: 16,),
          Column(
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
          )
        ],
      ),
    );
  }
}
