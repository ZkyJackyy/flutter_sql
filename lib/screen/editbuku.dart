import 'package:flutter/material.dart';
import 'package:flutter_sql/helper/db_helper.dart';
import 'package:flutter_sql/model/model_buku.dart';

class Editbuku extends StatefulWidget {
  final ModelBuku buku;
  const Editbuku({super.key, required this.buku});

  @override
  State<Editbuku> createState() => _EditbukuState();
}

class _EditbukuState extends State<Editbuku> {

  var _judulController = TextEditingController();
  var _kategotiController = TextEditingController();

  bool _validatejudul = false;
  bool _validatekategori = false;

  @override
  void initState() {
    super.initState();
    _judulController = TextEditingController(text: widget.buku.judulbuku);
    _kategotiController = TextEditingController(text: widget.buku.kategori);
  }

  @override
  void dispose() {
    _judulController.dispose();
    _kategotiController.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit data Buku"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('edit data buku',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.teal
              ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _judulController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'edit judul buku',
                  labelText: 'Judul Buku',
                  errorText: _validatejudul ? 'Judul Buku Harus Diisi' : null,
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _kategotiController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'edit Kategori Buku',
                  labelText: 'Kategori Buku',
                  errorText: _validatekategori ? 'Kategori Buku Harus Diisi' : null,
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                    textStyle: TextStyle(fontSize: 14,color: Colors.white,
                    fontWeight: FontWeight.bold
                    )
                    ),
                    onPressed: () async{
                      setState(() {
                      _validatejudul = _judulController.text.isEmpty;
                        _validatekategori = _kategotiController.text.isEmpty;
                      });

                      if (!_validatejudul && !_validatekategori) {
                        ModelBuku updatedBuku = ModelBuku(
                          id: widget.buku.id,
                          judulbuku: _judulController.text,
                          kategori: _kategotiController.text,
                        );

                        await DBHelper.instance.updatebuku(updatedBuku);

                        Navigator.pop(context, true); // kembali dan beri sinyal berhasil
  }
                    }, child: Text('Update Data')
                    ),
                    SizedBox(width: 10,),
                    TextButton(
                    style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: TextStyle(fontSize: 14,color: Colors.white,
                    fontWeight: FontWeight.bold
                    )
                    ),
                    onPressed: (){
                      _judulController.clear();
                      _kategotiController.clear();
                      setState(() {
                        _validatejudul = false;
                        _validatekategori = false;
                      });
                    }, child: Text('Clear Data')
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}