class ComputerHardware {
  String? id;
  String? nama;
  String? harga;
  String? gambar;
  String? tipe;
  String? deskripsi;

  ComputerHardware(
      {this.id, this.nama, this.harga, this.gambar, this.tipe, this.deskripsi});

  ComputerHardware.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    harga = json['harga'];
    gambar = json['gambar'];
    tipe = json['tipe'];
    deskripsi = json['deskripsi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['harga'] = this.harga;
    data['gambar'] = this.gambar;
    data['tipe'] = this.tipe;
    data['deskripsi'] = this.deskripsi;
    return data;
  }
}
