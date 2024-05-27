class Volcano {
  final String nama;
  final String bentuk;
  final String tinggi_meter;
  final int estimasi_letusan_terakhir;
  final String geolokasi;

  Volcano({
    required this.nama,
    required this.bentuk,
    required this.tinggi_meter,
    required this.estimasi_letusan_terakhir,
    required this.geolokasi,
  });

  factory Volcano.fromJson(Map<String, dynamic> json) {
    return Volcano(
      nama: json['nama'],
      bentuk: json['bentuk'],
      tinggi_meter: json['tinggi_meter'],
      estimasi_letusan_terakhir: json['estimasi_letusan_terakhir'],
      geolokasi: json['geolokasi'],
    );
  }
}
