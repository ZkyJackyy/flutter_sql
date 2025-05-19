
class ModelBuku {
  final int? id;
  final String judulbuku;
  final String kategori;
  
  ModelBuku({this.id,required this.judulbuku,required this.kategori});

  //insert data
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judulbuku': judulbuku,
      'kategori': kategori,
    };
  }

  //get data
  factory ModelBuku.fromMap(Map<String, dynamic> map) {
    return ModelBuku(
      id: map['id'],
      judulbuku: map['judulbuku'],
      kategori: map['kategori'],
    );
  }
}