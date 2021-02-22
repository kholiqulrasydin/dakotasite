class LahanPerKecamatan {
  final String kecamatan;
  final String lahansawah;
  final String lahanpekarangan;
  final String lahantegal;

  LahanPerKecamatan({
    this.kecamatan,
    this.lahansawah,
    this.lahanpekarangan,
    this.lahantegal
  });

  LahanPerKecamatan.fromJson(Map<String, dynamic> map)
      : kecamatan = map['kecamatan'],
        lahansawah = map['lahansawah'],
        lahanpekarangan = map['lahanpekarangan'],
        lahantegal = map['lahantegal'];

  LahanPerKecamatan.fromJsonL(Map<String, dynamic> map)
      : kecamatan = map['kelurahan'],
        lahansawah = map['lahansawah'],
        lahanpekarangan = map['lahanpekarangan'],
        lahantegal = map['lahantegal'];
}