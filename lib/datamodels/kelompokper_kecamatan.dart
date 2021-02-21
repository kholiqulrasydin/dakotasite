class KelompokPerKecamatan {
  final String kecamatan;
  final int totalkelompok;
  final int alsintan;
  final int sarpras;
  final int bibit;
  final int ternak;
  final int perikanan;
  final int lainnya;

  KelompokPerKecamatan({
    this.kecamatan,
    this.totalkelompok,
    this.alsintan,
    this.sarpras,
    this.bibit,
    this.ternak,
    this.perikanan,
    this.lainnya,
  });

  KelompokPerKecamatan.fromJson(Map<String, dynamic> map)
      : kecamatan = map['kecamatan'],
        totalkelompok = map['totalkelompok'],
        alsintan = map['alsintan'],
        sarpras = map['sarpras'],
        bibit = map['bibit'],
        ternak = map['ternak'],
        perikanan = map['perikanan'],
        lainnya = map['lainnya'];
}