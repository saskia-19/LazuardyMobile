import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, String> profileData;
  final Function(Map<String, String>) onProfileUpdated;

  const EditProfilePage({
    super.key,
    required this.profileData,
    required this.onProfileUpdated,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late Map<String, String> _editedData;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _editedData = Map.from(widget.profileData);
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onProfileUpdated(_editedData);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveProfile),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Form fields untuk edit data profil
              _buildTextField('Nama Lengkap', 'nama', Icons.person),
              _buildTextField('Email', 'email', Icons.email),
              _buildTextField('Telepon', 'telepon', Icons.phone),
              _buildTextField('Asal Sekolah', 'asal_sekolah', Icons.school),
              _buildTextField('Kelas', 'kelas', Icons.grade),
              _buildTextField('Provinsi', 'provinsi', Icons.location_on),
              _buildTextField('Kota/Kabupaten', 'kota', Icons.location_city),
              _buildTextField('Kecamatan', 'kecamatan', Icons.map),
              _buildTextField('Desa/Kelurahan', 'desa', Icons.home),
              _buildTextField(
                'Alamat Lengkap',
                'alamat_lengkap',
                Icons.home_work,
                maxLines: 3,
              ),
              _buildTextField(
                'Nama Wali 1',
                'nama_wali_1',
                Icons.family_restroom,
              ),
              _buildTextField('Telepon Wali 1', 'telepon_wali_1', Icons.phone),
              _buildTextField(
                'Nama Wali 2',
                'nama_wali_2',
                Icons.family_restroom,
              ),
              _buildTextField('Telepon Wali 2', 'telepon_wali_2', Icons.phone),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String key,
    IconData icon, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: _editedData[key],
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        maxLines: maxLines,
        onSaved: (value) {
          _editedData[key] = value ?? '';
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label tidak boleh kosong';
          }
          return null;
        },
      ),
    );
  }
}
