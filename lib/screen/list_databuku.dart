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
  bool _isloading = false;

  @override
  void initState() {
    DBHelper.instance.dummybuku();
    super.initState();
    _fetchDataBuku();
  }

  // Future<void> _fetchDataBuku() async {
  //   final bukuMaps = await DBHelper.instance.getBuku();
  //   setState(() {
  //     _buku = bukuMaps.map((bukuMaps) => ModelBuku.fromMap(bukuMaps)).toList();
  //   });
  // }

  Future<void> _fetchDataBuku() async {
    setState(() {
      _isloading = true;
    });

    final bukuMaps = await DBHelper.instance.getBuku();
    setState(() {
      _buku = bukuMaps.map((bukuMaps) => ModelBuku.fromMap(bukuMaps)).toList();
      _isloading = false;
    });

  }

  _showSuccessSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

_deleteFormDialog(BuildContext context, bukuId){
  return showDialog(context: context, builder: (param){
    return AlertDialog(
      title: const Text("apakah anda yakin ingin menghapus"),
      actions: [
        TextButton(onPressed: () async{
          var result = await DBHelper.instance.deletebuku(bukuId);
          if(result != null){
            Navigator.pop(context);
            _fetchDataBuku();
            _showSuccessSnackbar("buku dengan id ${bukuId} berhasil dihapus");
          }
        }, child: const Text("Delete")),
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
      ],
    );
  });
}

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Buku"),
        actions: [
          IconButton(onPressed: () {_fetchDataBuku();}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: _isloading ? const Center(child: CircularProgressIndicator(),) : ListView.builder(
        
        itemCount: _buku.length,
        itemBuilder: (context, index){
          return ListTile(
            onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Editbuku(buku: _buku[index]),
              ),
            );
            if (result == true) {
              _fetchDataBuku();
              _showSuccessSnackbar("Data buku berhasil diupdate");
            }
          },
            title: Text(_buku[index].judulbuku),
            subtitle: Text(_buku[index].kategori),
            onLongPress: () {
              _deleteFormDialog(context , _buku[index].id);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        // Navigator.push(context, (MaterialPageRoute(builder: (context)=> const Addbuku())));
        await Navigator.push(context, MaterialPageRoute(builder: (context)=> const Addbuku()));
        _fetchDataBuku();
      },
      child: Icon(Icons.add),
      ),

    );
  }
}