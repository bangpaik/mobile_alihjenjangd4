import 'dart:math';

import 'package:flutter/material.dart';

class PageGaleryMovie extends StatefulWidget {
  const PageGaleryMovie({super.key});

  @override
  State<PageGaleryMovie> createState() => _PageGaleryMovieState();
}

class _PageGaleryMovieState extends State<PageGaleryMovie> {

  List<Map<String, dynamic>> listMovie = [
    {
      "judul" : "Ancika",
      "gambar": "film1.jpeg",
      "harga" : 4500
    },
    {
      "judul" : "Pulang Tak Harus Rumah",
      "gambar": "film2.jpeg",
      "harga" : 4500
    },
    {
      "judul" : "Sehidup Semati",
      "gambar": "film4.jpeg",
      "harga" : 4500
    },
    {
      "judul" : "The Beepkeeper",
      "gambar": "film5.jpeg",
      "harga" : 4500
    },
    {
      "judul" : "13 Bom Di Jakarta",
      "gambar": "film7.jpeg",
      "harga" : 4500
    },

    {
      "judul" : "Jatuh Cinta Seperti Film-film",
      "gambar": "film8.jpeg",
      "harga" : 4500
    },
    {
      "judul" : "Air Mata di Ujung Sajadah",
      "gambar": "film9.png",
      "harga" : 4500
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galery Movie'),
        backgroundColor: Colors.cyan,
      ),
      body: GridView.builder(
          itemCount: listMovie.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                  => PageDetailGaleri("${listMovie[index]["gambar"]}", "${listMovie[index]["gambar"]}", "${listMovie[index]["judul"]}")
                ));

              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: GridTile(
                  footer: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.black54)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${listMovie[index]["judul"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16
                          ),
                        ),
                        Text("Rp. ${listMovie[index]["harga"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16
                          ),
                        ),

                      ],
                    ),
                  ), child: Image.asset("gambar/movie/${listMovie[index]['gambar']}"),
                ),
              ),
            );

          }),
    );
  }
}


class PageDetailGaleri extends StatelessWidget {
  final  String itemJudul, itemGambar, itemHarga;
  const PageDetailGaleri(this.itemGambar, this.itemHarga, this.itemJudul,{super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('${itemJudul}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset('gambar/movie/${itemGambar}'),
                Text('Harga : Rp. ${itemHarga}')
              ],
            ),
          ),
        ),
      ),

    );
  }
}

