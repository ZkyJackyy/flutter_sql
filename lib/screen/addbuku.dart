import 'package:flutter/material.dart';
import 'package:flutter_sql/helper/db_helper.dart';
import 'package:flutter_sql/model/model_buku.dart';

class Addbuku extends StatefulWidget {
  const Addbuku({super.key});

  @override
  State<Addbuku> createState() => _AddbukuState();
}

class _AddbukuState extends State<Addbuku> {

  var _judulController = TextEditingController();
  var _kategoriController = TextEditingController();

  bool _validatejudul = false;
  bool _validatekategori = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Buku"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add new buku',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.teal
              ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _judulController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'masukan judul buku',
                  labelText: 'Judul Buku',
                  errorText: _validatejudul ? 'Judul Buku Harus Diisi' : null,
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _kategoriController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan Kategori Buku',
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
                        _judulController.text.isEmpty ? _validatejudul = true : _validatekategori = false;
                        _kategoriController.text.isEmpty ? _validatejudul = false : _validatekategori = false;
                      });
                      if(_validatejudul == false && _validatekategori == false){
                        var buku  =ModelBuku(judulbuku: _judulController.text, kategori: _kategoriController.text);

                        var result = await DBHelper.instance.insertBuku(buku);
                        Navigator.pop(context, result);
                      }
                    }, child: Text('Save Data')
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
                      _judulController.text = '';
                      _kategoriController.text = '';  
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