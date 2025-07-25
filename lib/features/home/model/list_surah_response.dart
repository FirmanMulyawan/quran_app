import '../../../component/model/response_model.dart';

class ListSurahResponse implements Serializable {
  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  String? audio;
  String audioCondition;

  ListSurahResponse(
      {this.nomor,
      this.nama,
      this.namaLatin,
      this.jumlahAyat,
      this.tempatTurun,
      this.arti,
      this.deskripsi,
      this.audio,
      this.audioCondition = "stop"});

  ListSurahResponse.fromJson(Map<String, dynamic> json)
      : nomor = json['nomor'],
        nama = json['nama'],
        namaLatin = json['nama_latin'],
        jumlahAyat = json['jumlah_ayat'],
        tempatTurun = json['tempat_turun'],
        arti = json['arti'],
        deskripsi = json['deskripsi'],
        audio = json['audio'],
        audioCondition = "stop";

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nomor'] = nomor;
    data['nama'] = nama;
    data['nama_latin'] = namaLatin;
    data['jumlah_ayat'] = jumlahAyat;
    data['tempat_turun'] = tempatTurun;
    data['arti'] = arti;
    data['deskripsi'] = deskripsi;
    data['audio'] = audio;
    data['audioCondition'] = audioCondition;
    return data;
  }
}
