import 'package:flutter/material.dart';

// ======================================================
// dashboard_siswa_page.dart
// Versi tunggal, lengkap, dapat dijalankan (dengan data dummy)
// ======================================================

// =================== MODELS ===================
class Tutor {
  final int id;
  final String name;
  final String mapel;
  final String jenjang;
  final double rating;
  final int totalSiswa;
  final int totalSesi;
  final double distance;
  final String description;
  final String pendidikan;
  final String pengalaman;
  final String metode;
  final List<String> mode;
  final String imageUrl;

  Tutor({
    required this.id,
    required this.name,
    required this.mapel,
    required this.jenjang,
    required this.rating,
    required this.totalSiswa,
    required this.totalSesi,
    required this.distance,
    required this.description,
    required this.pendidikan,
    required this.pengalaman,
    required this.metode,
    required this.mode,
    required this.imageUrl,
  });
}

class FilterData {
  List<String> modePembelajaran;
  double minRating;
  List<String> jenisKelamin;
  List<String> hariKetersediaan;
  TimeOfDay jamMulai;
  TimeOfDay jamSelesai;

  FilterData({
    List<String>? modePembelajaran,
    double? minRating,
    List<String>? jenisKelamin,
    List<String>? hariKetersediaan,
    TimeOfDay? jamMulai,
    TimeOfDay? jamSelesai,
  }) : modePembelajaran = modePembelajaran ?? [],
      minRating = minRating ?? 1.0,
      jenisKelamin = jenisKelamin ?? ['Semua'],
      hariKetersediaan = hariKetersediaan ?? [],
      jamMulai = jamMulai ?? const TimeOfDay(hour: 8, minute: 0),
      jamSelesai = jamSelesai ?? const TimeOfDay(hour: 17, minute: 0);
}

// =================== DASHBOARD SISWA ===================
class DashboardSiswaPage extends StatefulWidget {
  final String namaSiswa;
  final String? kelasSiswa;

  const DashboardSiswaPage({
    super.key,
    required this.namaSiswa,
    this.kelasSiswa,
  });

  @override
  State<DashboardSiswaPage> createState() => _DashboardSiswaPageState();
}

class _DashboardSiswaPageState extends State<DashboardSiswaPage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _BerandaPage(
        namaSiswa: widget.namaSiswa,
        onMapelSelected: (mapel, kelas) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PencarianTutorPage(
                selectedMapel: mapel,
                selectedKelas: kelas,
              ),
            ),
          );
        },
      ),
      const PencarianTutorPage(),
      const JadwalBelajarPlaceholderPage(),
      ProfileSiswaPage(
        namaSiswa: widget.namaSiswa,
        kelasSiswa: widget.kelasSiswa,
      ),
    ];
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      drawer: SidebarDrawer(
        namaSiswa: widget.namaSiswa,
        kelasSiswa: widget.kelasSiswa ?? '—',
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF2C8AA4),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Tutor'),
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

// =================== BERANDA ===================
class _BerandaPage extends StatefulWidget {
  final String namaSiswa;
  final Function(String, String?) onMapelSelected;

  const _BerandaPage({required this.namaSiswa, required this.onMapelSelected});

  @override
  State<_BerandaPage> createState() => __BerandaPageState();
}

class __BerandaPageState extends State<_BerandaPage> {
  final List<String> _kelasList = [
    'Kelas',
    'Kelas 1 SD',
    'Kelas 2 SD',
    'Kelas 3 SD',
    'Kelas 4 SD',
    'Kelas 5 SD',
    'Kelas 6 SD',
    'Kelas 1 SMP',
    'Kelas 2 SMP',
    'Kelas 3 SMP',
    'Kelas 1 SMA',
    'Kelas 2 SMA',
    'Kelas 3 SMA',
  ];

  final List<Map<String, dynamic>> _mapelList = [
    {
      'nama': 'Matematika',
      'icon': Icons.calculate_outlined,
      'color': const Color(0xFF42A5F5),
    },
    {
      'nama': 'Fisika',
      'icon': Icons.science_outlined,
      'color': const Color(0xFF00ACC1),
    },
    {
      'nama': 'Kimia',
      'icon': Icons.bubble_chart,
      'color': const Color(0xFFFFB74D),
    },
    {
      'nama': 'Biologi',
      'icon': Icons.monitor_heart_outlined,
      'color': const Color(0xFFE57373),
    },
    {
      'nama': 'Bahasa Indonesia',
      'icon': Icons.chat_bubble_outline,
      'color': const Color(0xFF8D6E63),
    },
    {
      'nama': 'Bahasa Inggris',
      'icon': Icons.book_outlined,
      'color': const Color(0xFF7CB342),
    },
    {
      'nama': 'Sejarah',
      'icon': Icons.history_outlined,
      'color': const Color(0xFF9575CD),
    },
    {
      'nama': 'Semua Pelajaran',
      'icon': Icons.apps,
      'color': const Color(0xFF78909C),
    },
  ];

  String _selectedKelas = 'Kelas';
  final bool _isPaidUser = true;

  @override
  void initState() {
    super.initState();
    _selectedKelas = _kelasList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C8AA4),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBimbelCard(),
                  const SizedBox(height: 16),
                  _buildCariPaketCard(),
                  const SizedBox(height: 16),
                  if (_isPaidUser) _buildProgressCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 8,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: const CircleAvatar(
              backgroundColor: Color(0xFFEEEEEE),
              radius: 22,
              child: Icon(Icons.person_outline, color: Colors.grey, size: 26),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo ${widget.namaSiswa}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Aktif',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.black54,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotifikasiPage()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBimbelCard() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(
              Icons.auto_stories_outlined,
              color: Color(0xFF2C8AA4),
              size: 36,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Bimbel Lazuardy',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Belajar Tanpa Batas',
                    style: TextStyle(fontSize: 12, color: Color(0xFF2196F3)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCariPaketCard() {
    Widget buildDropdown() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedKelas,
            isDense: true,
            items: _kelasList
                .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                .toList(),
            onChanged: (v) =>
                setState(() => _selectedKelas = v ?? _selectedKelas),
          ),
        ),
      );
    }

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Cari Paket Belajar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                buildDropdown(),
              ],
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _mapelList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final m = _mapelList[index];
                return GestureDetector(
                  onTap: () => widget.onMapelSelected(
                    m['nama'] as String,
                    _selectedKelas != 'Kelas' ? _selectedKelas : null,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: (m['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: (m['color'] as Color).withOpacity(0.4),
                          ),
                        ),
                        child: Icon(
                          m['icon'] as IconData,
                          color: m['color'] as Color,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        m['nama'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    final prosesBelajarList = [
      {
        'paket': 'Paket 4 Pertemuan - Matematika',
        'nama': 'Budi Santoso',
        'tanggal': 'Selasa, 24 Sept 2025 - 16.00',
        'progress_current': 2,
        'progress_total': 4,
        'progress_value': 0.5,
        'color': const Color(0xFF42A5F5),
      },
    ];

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progress Belajar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...prosesBelajarList.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p['paket'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 6),
                        Text(p['nama'] as String),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: p['progress_value'] as double,
                            minHeight: 8,
                            backgroundColor: Colors.grey.shade200,
                            color: p['color'] as Color,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${p['progress_current']}/${p['progress_total']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =================== PENCARIAN TUTOR (LIST + FILTER) ===================
class PencarianTutorPage extends StatefulWidget {
  final String? selectedMapel;
  final String? selectedKelas;

  const PencarianTutorPage({super.key, this.selectedMapel, this.selectedKelas});

  @override
  State<PencarianTutorPage> createState() => _PencarianTutorPageState();
}

class _PencarianTutorPageState extends State<PencarianTutorPage> {
  final List<Tutor> _tutors = [
    Tutor(
      id: 1,
      name: 'Budi Santoso',
      mapel: 'Matematika',
      jenjang: 'SMA',
      rating: 4.8,
      totalSiswa: 45,
      totalSesi: 120,
      distance: 2.5,
      description:
          'Pengalaman mengajar matematika selama 5 tahun, spesialis UTBK.',
      pendidikan: 'S1 Pendidikan Matematika - Universitas Indonesia',
      pengalaman: '3 tahun di Bimbel Champion, 2 tahun mengajar privat',
      metode: 'Interaktif & problem solving',
      mode: ['Online', 'Offline'],
      imageUrl: '',
    ),
    Tutor(
      id: 2,
      name: 'Sari Dewi',
      mapel: 'Fisika',
      jenjang: 'SMP-SMA',
      rating: 4.9,
      totalSiswa: 38,
      totalSesi: 95,
      distance: 1.8,
      description:
          'Mengajar fisika dengan pendekatan praktis dan eksperimen sederhana.',
      pendidikan: 'S1 Fisika - ITB',
      pengalaman: '4 tahun mengajar fisika',
      metode: 'Eksperimen virtual & analogi',
      mode: ['Online'],
      imageUrl: '',
    ),
  ];

  List<Tutor> _filteredTutors = [];
  final TextEditingController _searchController = TextEditingController();
  FilterData _currentFilters = FilterData();

  @override
  void initState() {
    super.initState();
    _filteredTutors = List.from(_tutors);
    _applyInitialFilters();
  }

  void _applyInitialFilters() {
    if (widget.selectedMapel != null) {
      _filteredTutors = _tutors
          .where((t) => t.mapel == widget.selectedMapel)
          .toList();
    }
  }

  void _searchTutors(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredTutors = List.from(_tutors);
        _applyInitialFilters();
      } else {
        _filteredTutors = _tutors.where((t) {
          return t.name.toLowerCase().contains(query.toLowerCase()) ||
              t.mapel.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  Future<void> _openFilter() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FilterTutorPage(initialFilters: _currentFilters),
      ),
    );
    if (result != null && result is FilterData) {
      setState(() {
        _currentFilters = result;
        _filterTutors(result);
      });
    }
  }

  void _filterTutors(FilterData f) {
    setState(() {
      _filteredTutors = _tutors.where((tutor) {
        final matchesMode =
            f.modePembelajaran.isEmpty ||
            f.modePembelajaran.any((m) => tutor.mode.contains(m));
        final matchesRating = tutor.rating >= f.minRating;
        final matchesGender =
            true; // kita tidak simulasikan gender tutor di model
        return matchesMode && matchesRating && matchesGender;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final info = (widget.selectedMapel != null || widget.selectedKelas != null)
        ? 'Menampilkan tutor untuk ${widget.selectedMapel ?? 'semua mapel'} ${widget.selectedKelas != null ? '(${widget.selectedKelas})' : ''}'
        : '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Tutor'),
        backgroundColor: const Color(0xFF2C8AA4),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _searchTutors,
                    decoration: InputDecoration(
                      hintText: 'Cari tutor...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: _openFilter,
                  color: Colors.white,
                  padding: const EdgeInsets.all(12),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFF2C8AA4),
                  ),
                ),
              ],
            ),
          ),
          if (info.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      info,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
          Expanded(
            child: _filteredTutors.isEmpty
                ? const Center(
                    child: Text('Tidak ada tutor yang sesuai dengan kriteria'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredTutors.length,
                    itemBuilder: (context, index) {
                      final tutor = _filteredTutors[index];
                      return _buildTutorCard(tutor);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorCard(Tutor tutor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailTutorPage(tutor: tutor)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: _buildTutorInfoColumn(tutor)),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                tutor.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: tutor.mode
                    .map(
                      (m) => Chip(
                        label: Text(m),
                        visualDensity: VisualDensity.compact,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTutorInfoColumn(Tutor tutor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tutor.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          '${tutor.mapel} • ${tutor.jenjang}',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(
              tutor.rating.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.people_outline, size: 16),
            const SizedBox(width: 4),
            Text('${tutor.totalSiswa} siswa'),
            const SizedBox(width: 12),
            const Icon(Icons.schedule, size: 16),
            const SizedBox(width: 4),
            Text('${tutor.totalSesi} sesi'),
          ],
        ),
      ],
    );
  }
}

// =================== FILTER TUTOR PAGE ===================
class FilterTutorPage extends StatefulWidget {
  final FilterData initialFilters;

  const FilterTutorPage({super.key, required this.initialFilters});

  @override
  State<FilterTutorPage> createState() => _FilterTutorPageState();
}

class _FilterTutorPageState extends State<FilterTutorPage> {
  late FilterData _filters;

  @override
  void initState() {
    super.initState();
    // copy
    _filters = FilterData(
      modePembelajaran: List.from(widget.initialFilters.modePembelajaran),
      minRating: widget.initialFilters.minRating,
      jenisKelamin: List.from(widget.initialFilters.jenisKelamin),
      hariKetersediaan: List.from(widget.initialFilters.hariKetersediaan),
      jamMulai: widget.initialFilters.jamMulai,
      jamSelesai: widget.initialFilters.jamSelesai,
    );
  }

  void _resetFilters() {
    setState(() {
      _filters = FilterData();
    });
  }

  void _applyFilters() => Navigator.pop(context, _filters);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Tutor'),
        backgroundColor: const Color(0xFF2C8AA4),
        actions: [
          TextButton(
            onPressed: _resetFilters,
            child: const Text(
              'Atur Ulang',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildSectionHeader('Mode Pembelajaran'),
                  const SizedBox(height: 8),
                  _buildModePembelajaranSection(),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Rating Minimum'),
                  const SizedBox(height: 8),
                  _buildRatingSection(),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Jenis Kelamin Tutor'),
                  const SizedBox(height: 8),
                  _buildGenderSection(),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Hari Ketersediaan'),
                  const SizedBox(height: 8),
                  _buildDaysSection(),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Jam Mengajar'),
                  const SizedBox(height: 8),
                  _buildTimeSection(),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C8AA4),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) => Text(
    title,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  );

  Widget _buildModePembelajaranSection() {
    final modes = ['Online', 'Offline'];
    return Wrap(
      spacing: 8,
      children: modes.map((mode) {
        final selected = _filters.modePembelajaran.contains(mode);
        return FilterChip(
          label: Text(mode),
          selected: selected,
          onSelected: (v) {
            setState(() {
              if (v) {
                _filters.modePembelajaran.add(mode);
              } else {
                _filters.modePembelajaran.remove(mode);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildRatingSection() {
    return Column(
      children: [
        Text(
          _filters.minRating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C8AA4),
          ),
        ),
        Slider(
          value: _filters.minRating,
          min: 1,
          max: 5,
          divisions: 4,
          onChanged: (v) => setState(() => _filters.minRating = v),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('1.0'), Text('5.0')],
        ),
      ],
    );
  }

  Widget _buildGenderSection() {
    final genders = ['Semua', 'Laki-laki', 'Perempuan'];
    return Wrap(
      spacing: 8,
      children: genders.map((g) {
        final selected = _filters.jenisKelamin.contains(g);
        return FilterChip(
          label: Text(g),
          selected: selected,
          onSelected: (v) {
            setState(() {
              if (v) {
                if (g == 'Semua') {
                  _filters.jenisKelamin = ['Semua'];
                } else {
                  _filters.jenisKelamin.remove('Semua');
                  if (!_filters.jenisKelamin.contains(g)) {
                    _filters.jenisKelamin.add(g);
                  }
                }
              } else {
                _filters.jenisKelamin.remove(g);
                if (_filters.jenisKelamin.isEmpty) {
                  _filters.jenisKelamin.add('Semua');
                }
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildDaysSection() {
    final days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: days.map((d) {
        final selected = _filters.hariKetersediaan.contains(d);
        return FilterChip(
          label: Text(d),
          selected: selected,
          onSelected: (v) {
            setState(() {
              if (v) {
                _filters.hariKetersediaan.add(d);
              } else {
                _filters.hariKetersediaan.remove(d);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildTimeSection() {
    return Row(
      children: [
        Expanded(child: _buildTimeTile('Dari Jam', _filters.jamMulai, true)),
        const SizedBox(width: 12),
        Expanded(
          child: _buildTimeTile('Sampai Jam', _filters.jamSelesai, false),
        ),
      ],
    );
  }

  Widget _buildTimeTile(String label, TimeOfDay time, bool isStart) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final picked = await showTimePicker(
              context: context,
              initialTime: time,
            );
            if (picked != null) {
              setState(() {
                if (isStart) {
                  _filters.jamMulai = picked;
                } else {
                  _filters.jamSelesai = picked;
                }
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(time.format(context)),
          ),
        ),
      ],
    );
  }
}

// =================== DETAIL TUTOR ===================
class DetailTutorPage extends StatefulWidget {
  final Tutor tutor;

  const DetailTutorPage({super.key, required this.tutor});

  @override
  State<DetailTutorPage> createState() => _DetailTutorPageState();
}

class _DetailTutorPageState extends State<DetailTutorPage> {
  bool _showFullDescription = false;
  bool _showFullPendidikan = false;
  bool _showFullPengalaman = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tutor'),
        backgroundColor: const Color(0xFF2C8AA4),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderInfo(),
            const SizedBox(height: 24),
            _buildSectionTitle('Deskripsi Tutor'),
            const SizedBox(height: 8),
            Text(
              widget.tutor.description,
              maxLines: _showFullDescription ? null : 3,
              overflow: _showFullDescription
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
            ),
            if (widget.tutor.description.length > 120)
              TextButton(
                onPressed: () => setState(
                  () => _showFullDescription = !_showFullDescription,
                ),
                child: Text(
                  _showFullDescription
                      ? 'Tampilkan Lebih Sedikit'
                      : 'Tampilkan Lebih Banyak',
                  style: const TextStyle(color: Color(0xFF2C8AA4)),
                ),
              ),
            const SizedBox(height: 16),
            _buildSectionTitle('Kualifikasi & Pengalaman'),
            const SizedBox(height: 8),
            Text(
              'Pendidikan',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              widget.tutor.pendidikan,
              maxLines: _showFullPendidikan ? null : 2,
              overflow: _showFullPendidikan
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
            ),
            if (widget.tutor.pendidikan.length > 100)
              TextButton(
                onPressed: () =>
                    setState(() => _showFullPendidikan = !_showFullPendidikan),
                child: Text(
                  _showFullPendidikan
                      ? 'Tampilkan Lebih Sedikit'
                      : 'Tampilkan Lebih Banyak',
                  style: const TextStyle(color: Color(0xFF2C8AA4)),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              'Pengalaman',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              widget.tutor.pengalaman,
              maxLines: _showFullPengalaman ? null : 2,
              overflow: _showFullPengalaman
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
            ),
            if (widget.tutor.pengalaman.length > 100)
              TextButton(
                onPressed: () =>
                    setState(() => _showFullPengalaman = !_showFullPengalaman),
                child: Text(
                  _showFullPengalaman
                      ? 'Tampilkan Lebih Sedikit'
                      : 'Tampilkan Lebih Banyak',
                  style: const TextStyle(color: Color(0xFF2C8AA4)),
                ),
              ),
            const SizedBox(height: 16),
            _buildSectionTitle('Metode Mengajar'),
            const SizedBox(height: 8),
            Text(widget.tutor.metode),
            const SizedBox(height: 24),
            _buildSectionTitle('Ulasan Siswa'),
            const SizedBox(height: 8),
            _buildReviewsSection(),
            const SizedBox(height: 96),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PilihPaketPage(tutor: widget.tutor),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2C8AA4),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              'Pilih Tutor',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 44,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, size: 44, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Text(
              widget.tutor.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              '${widget.tutor.mapel} • ${widget.tutor.jenjang}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  Icons.star,
                  widget.tutor.rating.toString(),
                  'Rating',
                ),
                _buildStatItem(
                  Icons.people_outline,
                  widget.tutor.totalSiswa.toString(),
                  'Siswa',
                ),
                _buildStatItem(
                  Icons.schedule,
                  widget.tutor.totalSesi.toString(),
                  'Sesi',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: widget.tutor.mode
                  .map((m) => Chip(label: Text(m)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF2C8AA4)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildSectionTitle(String title) => Text(
    title,
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  );

  Widget _buildReviewsSection() {
    final reviews = [
      {
        'name': 'Rina Sari',
        'rating': 5.0,
        'comment': 'Pak Budi sangat sabar, penjelasannya mudah dimengerti.',
      },
      {
        'name': 'Andi Pratama',
        'rating': 4.5,
        'comment': 'Metode menyenangkan dan jelas.',
      },
    ];

    return Column(
      children: reviews.map((r) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r['name'] as String,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 6),
                    Text((r['rating'] as double).toString()),
                  ],
                ),
                const SizedBox(height: 8),
                Text(r['comment'] as String),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// =================== JADWAL MENGAJAR PAGE ===================
class JadwalMengajarPage extends StatefulWidget {
  final Tutor tutor;

  const JadwalMengajarPage({super.key, required this.tutor});

  @override
  State<JadwalMengajarPage> createState() => _JadwalMengajarPageState();
}

class _JadwalMengajarPageState extends State<JadwalMengajarPage> {
  DateTime _selectedDate = DateTime.now();
  final Map<String, List<String>> _scheduleData = {
    'Senin': ['08:00 - 10:00', '14:00 - 16:00'],
    'Selasa': ['10:00 - 12:00', '16:00 - 18:00'],
    'Rabu': ['08:00 - 10:00', '18:00 - 20:00'],
    'Kamis': ['14:00 - 16:00'],
    'Jumat': ['08:00 - 10:00', '16:00 - 18:00'],
    'Sabtu': ['10:00 - 12:00', '14:00 - 16:00'],
    'Minggu': ['Libur'],
  };

  String get _selectedDay {
    final days = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
    ];
    return days[_selectedDate.weekday % 7]; // weekday: 1..7
  }

  @override
  Widget build(BuildContext context) {
    final availableSlots = _scheduleData[_selectedDay] ?? ['Tidak ada jadwal'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Mengajar'),
        backgroundColor: const Color(0xFF2C8AA4),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _selectDate,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildWeekNavigation(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _getFormattedDate(_selectedDate),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: availableSlots.length,
              itemBuilder: (context, index) {
                final slot = availableSlots[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: slot == 'Libur' ? Colors.grey[100] : Colors.white,
                  child: ListTile(
                    leading: Icon(
                      slot == 'Libur' ? Icons.beach_access : Icons.access_time,
                      color: slot == 'Libur'
                          ? Colors.grey
                          : const Color(0xFF2C8AA4),
                    ),
                    title: Text(
                      slot,
                      style: TextStyle(
                        color: slot == 'Libur' ? Colors.grey : Colors.black87,
                      ),
                    ),
                    subtitle: slot == 'Libur'
                        ? const Text('Hari libur')
                        : Text('Available untuk ${widget.tutor.mapel}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekNavigation() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => setState(
                () => _selectedDate = _selectedDate.subtract(
                  const Duration(days: 7),
                ),
              ),
            ),
            Text(
              'Minggu ${_getWeekNumber(_selectedDate)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () => setState(
                () =>
                    _selectedDate = _selectedDate.add(const Duration(days: 7)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getWeekNumber(DateTime date) {
    final firstDay = DateTime(date.year, 1, 1);
    final daysDiff = date.difference(firstDay).inDays;
    return ((daysDiff + firstDay.weekday) / 7).ceil();
  }

  String _getFormattedDate(DateTime date) {
    final days = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
    ];
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return '${days[date.weekday % 7]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }
}

// =================== PILIH PAKET PAGE ===================
class PilihPaketPage extends StatefulWidget {
  final Tutor tutor;

  const PilihPaketPage({super.key, required this.tutor});

  @override
  State<PilihPaketPage> createState() => _PilihPaketPageState();
}

class _PilihPaketPageState extends State<PilihPaketPage> {
  int _selectedPackageIndex = 0;

  final List<Map<String, dynamic>> _packages = [
    {
      'name': 'Paket 4x Pertemuan',
      'meetings': 4,
      'duration': '90 menit/pertemuan',
      'price': 400000,
      'features': [
        '4 sesi',
        'Materi kurikulum',
        'Latihan soal',
        'Konsultasi WA',
      ],
      'description':
          'Paket ideal untuk pemahaman dasar dan persiapan ulangan harian.',
    },
    {
      'name': 'Paket 8x Pertemuan',
      'meetings': 8,
      'duration': '90 menit/pertemuan',
      'price': 720000,
      'features': [
        '8 sesi',
        'Materi lengkap',
        'Try out',
        'Akses materi digital',
      ],
      'description':
          'Paket komprehensif untuk persiapan ujian dan pemahaman mendalam.',
    },
  ];

  void _showPackageDetail(int index) {
    showDialog(
      context: context,
      builder: (_) =>
          PackageDetailDialog(package: _packages[index], tutor: widget.tutor),
    );
  }

  void _selectPackage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Memilih ${_packages[_selectedPackageIndex]['name']}'),
      ),
    );
    // disini kamu bisa navigasi ke page pembayaran
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Paket Belajar'),
        backgroundColor: const Color(0xFF2C8AA4),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.tutor.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _packages.length,
              itemBuilder: (context, index) {
                final p = _packages[index];
                final selected = index == _selectedPackageIndex;
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: selected
                          ? const Color(0xFF2C8AA4)
                          : Colors.transparent,
                    ),
                  ),
                  child: ListTile(
                    title: Text(p['name']),
                    subtitle: Text(
                      '${p['meetings']} pertemuan • ${p['duration']}',
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Rp ${p['price']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        TextButton(
                          onPressed: () => _showPackageDetail(index),
                          child: const Text('Detail'),
                        ),
                      ],
                    ),
                    onTap: () => setState(() => _selectedPackageIndex = index),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectPackage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C8AA4),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Pilih Paket',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PackageDetailDialog extends StatelessWidget {
  final Map<String, dynamic> package;
  final Tutor tutor;

  const PackageDetailDialog({
    super.key,
    required this.package,
    required this.tutor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(package['name']),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(package['description']),
          const SizedBox(height: 8),
          Text('Fitur:', style: const TextStyle(fontWeight: FontWeight.bold)),
          ...List<Widget>.from(
            (package['features'] as List).map((f) => Text('- $f')),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Tutup'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Pilih'),
        ),
      ],
    );
  }
}

// =================== SIDEBAR ===================
class SidebarDrawer extends StatelessWidget {
  final String namaSiswa;
  final String kelasSiswa;

  const SidebarDrawer({
    super.key,
    required this.namaSiswa,
    required this.kelasSiswa,
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
              namaSiswa,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(kelasSiswa, style: const TextStyle(color: Colors.black54)),
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

// =================== PROFIL SISWA (placeholder sederhana) ===================
class ProfileSiswaPage extends StatelessWidget {
  final String namaSiswa;
  final String? kelasSiswa;

  const ProfileSiswaPage({super.key, required this.namaSiswa, this.kelasSiswa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: const Color(0xFF2C8AA4),
      ),
      body: Center(
        child: Text(
          'Profil $namaSiswa\n${kelasSiswa ?? ''}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// =================== NOTIFIKASI PAGE ===================
class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        backgroundColor: const Color(0xFF2C8AA4),
      ),
      body: const Center(child: Text('Halaman Notifikasi')),
    );
  }
}

// =================== PLACEHOLDER JADWAL PAGE (digunakan di dashboard kalau belum ada) ===================
class JadwalBelajarPlaceholderPage extends StatelessWidget {
  const JadwalBelajarPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal'),
        backgroundColor: const Color(0xFF2C8AA4),
      ),
      body: const Center(child: Text('Halaman Jadwal (placeholder)')),
    );
  }
}
