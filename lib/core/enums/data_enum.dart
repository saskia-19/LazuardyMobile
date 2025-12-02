mixin dataClass {
  String get value;
  String get tampil;
}

enum KelasEnum with dataClass {
  kelas_1('kelas 1', 'Kelas 1', 'SD', 0),
  kelas_2('kelas 2', 'Kelas 2', 'SD', 1),
  kelas_3('kelas 3', 'Kelas 3', 'SD', 2),
  kelas_4('kelas 4', 'Kelas 4', 'SD', 3),
  kelas_5('kelas 5', 'Kelas 5', 'SD', 4),
  kelas_6('kelas 6', 'Kelas 6', 'SD', 5),
  kelas_7('kelas 7', 'Kelas 7', 'SMP', 6),
  kelas_8('kelas 8', 'Kelas 8', 'SMP', 7),
  kelas_9('kelas 9', 'Kelas 9', 'SMP', 8),
  kelas_10('kelas 10', 'Kelas 10', 'SMA', 9),
  kelas_11('kelas 11', 'Kelas 11', 'SMA', 10),
  kelas_12('kelas 12', 'Kelas 12', 'SMA', 11);

  const KelasEnum(this.value, this.tampil, this.jenjang, this.bobot);

  @override
  final String value;
  @override
  final String tampil;
  final String jenjang;
  final int bobot;
}

enum GenderEnum with dataClass {
  pria('male', 'Laki-laki'),
  wanita('female', 'Perempuan');

  const GenderEnum(this.value, this.tampil);

  @override
  final String value;
  @override
  final String tampil;
}



enum AgamaEnum{ 
  islam,kristen, katolik, hindu, buddha, konghucu }

enum BankEnum { bsi, bri, dpd, mandiri, bca, bni }

class EnumHelper {
  // static 
}