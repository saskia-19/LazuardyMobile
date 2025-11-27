import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/edit_profile_page.dart'; // Halaman edit profil

class ProfileSiswaPage extends StatefulWidget {
  final String namaSiswa;
  final String? kelasSiswa;

  const ProfileSiswaPage({super.key, required this.namaSiswa, this.kelasSiswa});

  @override
  State<ProfileSiswaPage> createState() => _ProfileSiswaPageState();
}

class _ProfileSiswaPageState extends State<ProfileSiswaPage> {
  // Data profil - seharusnya diambil dari database/local storage
  Map<String, String> _profileData = {
    'nama': '',
    'email': '',
    'telepon': '',
    'provinsi': '',
    'kota': '',
    'kecamatan': '',
    'desa': '',
    'alamat_lengkap': '',
    'asal_sekolah': '',
    'kelas': '',
    'nama_wali_1': '',
    'telepon_wali_1': '',
    'nama_wali_2': '',
    'telepon_wali_2': '',
  };

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // Simulasi loading data profil dari storage
  void _loadProfileData() {
    // TODO: Ganti dengan data sebenarnya dari SharedPreferences/API
    setState(() {
      _profileData = {
        'nama': widget.namaSiswa,
        'email': 'siswa@email.com', // Ini contoh, seharusnya dari input user
        'telepon':
            '+62 812-3456-7890', // Ini contoh, seharusnya dari input user
        'provinsi': 'Jawa Barat',
        'kota': 'Bandung',
        'kecamatan': 'Bandung Wetan',
        'desa': 'Cihapit',
        'alamat_lengkap': 'Jl. Merdeka No. 123, Gedung Plaza, RT 01/RW 02',
        'asal_sekolah': 'SMA Negeri 1 Bandung',
        'kelas': widget.kelasSiswa ?? '10 IPA',
        'nama_wali_1': 'Ayah Siswa',
        'telepon_wali_1': '+62 812-3456-7891',
        'nama_wali_2': 'Ibu Siswa',
        'telepon_wali_2': '+62 812-3456-7892',
      };
    });
  }

  // Helper method untuk menampilkan data atau placeholder
  String _getDisplayValue(String value) {
    return value.isNotEmpty ? value : '-';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Card Profil
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                            'assets/images/profile_default.png',
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                            onPressed: () {
                              // Edit foto profil
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _getDisplayValue(_profileData['nama']!),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getDisplayValue(_profileData['email']!),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getDisplayValue(_profileData['telepon']!),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(
                                profileData: _profileData,
                                onProfileUpdated: (updatedData) {
                                  setState(() {
                                    _profileData = updatedData;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                        child: const Text('Edit Profil'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Card Detail Alamat
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detail Alamat',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailItem('Provinsi', _profileData['provinsi']!),
                    _buildDetailItem('Kota/Kabupaten', _profileData['kota']!),
                    _buildDetailItem('Kecamatan', _profileData['kecamatan']!),
                    _buildDetailItem('Desa/Kelurahan', _profileData['desa']!),
                    _buildDetailItem(
                      'Alamat',
                      _profileData['alamat_lengkap']!,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Card Detail Sekolah
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detail Sekolah',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailItem(
                      'Asal Sekolah',
                      _profileData['asal_sekolah']!,
                    ),
                    _buildDetailItem('Kelas', _profileData['kelas']!),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Card Kontak Orang Tua/Wali
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kontak Orang Tua/Wali',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailItem(
                      'Nama Orang Tua/Wali 1',
                      _profileData['nama_wali_1']!,
                    ),
                    _buildDetailItem(
                      'Nomor Telepon Wali 1',
                      _profileData['telepon_wali_1']!,
                    ),
                    _buildDetailItem(
                      'Nama Orang Tua/Wali 2',
                      _profileData['nama_wali_2']!,
                    ),
                    _buildDetailItem(
                      'Nomor Telepon Wali 2',
                      _profileData['telepon_wali_2']!,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _getDisplayValue(value),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
