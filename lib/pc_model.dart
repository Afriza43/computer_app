class ComputerHardware {
  final int? page;
  final int? perPage;
  final List<Data>? data;

  ComputerHardware({
    this.page,
    this.perPage,
    this.data,
  });

  ComputerHardware.fromJson(Map<String, dynamic> json)
      : page = json['page'] as int?,
        perPage = json['per_page'] as int?,
        data = (json['data'] as List?)
            ?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'page': page,
        'per_page': perPage,
        'data': data?.map((e) => e.toJson()).toList()
      };
}

class Data {
  final String? id;
  final String? nama;
  final String? harga;
  final String? gambar;
  final String? tipe;
  final String? deskripsi;

  Data({
    this.id,
    this.nama,
    this.harga,
    this.gambar,
    this.tipe,
    this.deskripsi,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        nama = json['nama'] as String?,
        harga = json['harga'] as String?,
        gambar = json['gambar'] as String?,
        tipe = json['tipe'] as String?,
        deskripsi = json['deskripsi'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'harga': harga,
        'gambar': gambar,
        'tipe': tipe,
        'deskripsi': deskripsi
      };
}
