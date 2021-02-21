class BantuanUsahaCount{
  final int alsintan;
  final int sarpras;
  final int bibit;
  final int ternak;
  final int perikanan;
  final int lainnya;

  BantuanUsahaCount({
    this.alsintan,
    this.sarpras,
    this.bibit,
    this.ternak,
    this.perikanan,
    this.lainnya
  });

  BantuanUsahaCount.fromJson(Map<String, dynamic> map)
  : alsintan = map['alsintan'],
    sarpras = map['sarpras'],
    bibit = map['bibit'],
    ternak = map['ternak'],
    perikanan = map['perikanan'],
    lainnya = map['lainnya'];

}