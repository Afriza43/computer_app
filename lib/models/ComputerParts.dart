// To parse this JSON data, do
//
//     final computer = computerFromJson(jsonString);

import 'dart:convert';

List<Computer> computerFromJson(String str) =>
    List<Computer>.from(json.decode(str).map((x) => Computer.fromJson(x)));

String computerToJson(List<Computer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Computer {
  String id;
  String nama;
  String harga;
  String gambar;
  Tipe tipe;
  String deskripsi;

  Computer({
    required this.id,
    required this.nama,
    required this.harga,
    required this.gambar,
    required this.tipe,
    required this.deskripsi,
  });

  factory Computer.fromJson(Map<String, dynamic> json) => Computer(
        id: json["id"],
        nama: json["nama"],
        harga: json["harga"],
        gambar: json["gambar"],
        tipe: tipeValues.map[json["tipe"]]!,
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "harga": harga,
        "gambar": gambar,
        "tipe": tipeValues.reverse[tipe],
        "deskripsi": deskripsi,
      };
}

enum Tipe { MOTHERBOARD, PROCESSOR, VGA }

final tipeValues = EnumValues({
  "Motherboard": Tipe.MOTHERBOARD,
  "Processor": Tipe.PROCESSOR,
  "VGA": Tipe.VGA
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
