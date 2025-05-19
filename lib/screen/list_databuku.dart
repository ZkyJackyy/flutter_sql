import 'package:flutter/material.dart';
import 'package:flutter_sql/model/model_buku.dart';
import 'package:flutter_sql/helper/db_helper.dart';
import 'package:flutter_sql/screen/addbuku.dart';
import 'package:flutter_sql/screen/editbuku.dart';

class ListDatabuku extends StatefulWidget {
  const ListDatabuku({super.key});

  @override
  State<ListDatabuku> createState() => _ListDatabukuState();
}

class _ListDatabukuState extends State<ListDatabuku> {

  List<ModelBuku> _buku = [];

  @override
  void initState() {
    DBHelper.instance.dummybuku();
    super.initState();
    _fetchDataBuku();
  }

  Future<void> _fetchDataBuku() async {
    final bukuMaps = await DBHelper.instance.getBuku();
    setState(() {
      _buku = bukuMaps.map((bukuMaps) => ModelBuku.fromMap(bukuMaps)).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Buku"),
      ),
      body: ListView.builder(
        
        itemCount: _buku.length,
        itemBuilder: (context, index){
          return ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> Editbuku()));
            },
            title: Text(_buku[index].judulbuku),
            subtitle: Text(_buku[index].kategori),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, (MaterialPageRoute(builder: (context)=> const Addbuku())));
      },
      child: Icon(Icons.add),
      ),

    );
  }
}