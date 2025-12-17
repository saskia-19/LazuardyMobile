enum BulanEnum {
  januari('01', 'Januari', 'Jan'),
  februari('02', 'Februari', 'Feb'),
  maret('03', 'Maret', 'Mar'),
  april('04', 'April', 'Apr'),
  mei('05', 'Mei', 'Mei'),
  juni('06', 'Juni', 'Jun'),
  juli('07', 'Juli', 'Jul'),
  agustus('08', 'Agustus', 'Agu'),
  september('09', 'September', 'Sep'),
  oktober('10', 'Oktober', 'Okt'),
  november('11', 'November', 'Nov'),
  desember('12', 'Desember', 'Des');

  const BulanEnum(this.value, this.tampil, this.tampilSingkat);

  final String value;
  final String tampil;
  final String tampilSingkat;

  static BulanEnum fromDateTime(int month) {
    String target = month.toString().padLeft(2, '0');
    return BulanEnum.values.firstWhere(
      (e) => e.value == target,
      orElse: () => BulanEnum.januari,
    );
  }
}

enum HariEnum {
  senin('1', 'Senin', 'Sen'),
  selasa('2', 'Selasa', 'Sel'),
  rabu('3', 'Rabu', 'Rab'),
  kamis('4', 'Kamis', 'Kam'),
  jumat('5', 'Jumat', 'Jum'),
  sabtu('6', 'Sabtu', 'Sab'),
  minggu('7', 'Minggu', 'Min');

  const HariEnum(this.value, this.tampil, this.tampilSingkat);

  final String value;
  final String tampil;
  final String tampilSingkat;

  static HariEnum fromDateTime(int weekday) {
    return HariEnum.values.firstWhere(
      (e) => e.value == weekday.toString(),
      orElse: () => HariEnum.senin,
    );
  }
}

