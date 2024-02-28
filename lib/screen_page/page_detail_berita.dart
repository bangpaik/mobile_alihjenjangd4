import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_alihjenjangd4/models/model_berita.dart';

class PageDetailBerita extends StatelessWidget {
  final Datum? data;

  const PageDetailBerita(this.data, {super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data!.judul),
        backgroundColor: Colors.cyan,
      ),

      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'http://192.168.1.30:8080/beritaDb/gambar_berita/${data?.gambarBerita}',
                fit: BoxFit.fill,
              ),
            ),
          ),

          ListTile(
            title: Text(data?.judul ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
            subtitle: Text(DateFormat().format(data?.tglBerita ?? DateTime.now())),
            trailing: Icon(Icons.star, color: Colors.orange,),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              data?.isiBerita ?? "",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }
}
