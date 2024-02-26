import 'package:flutter/material.dart';

class PageKedua extends StatelessWidget {
  const PageKedua({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Page Kedua',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),

      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.person, size: 45,color: Colors.purple,),
            Icon(Icons.account_balance_outlined, size: 45,color: Colors.purple,),
            Icon(Icons.add_business_sharp, size: 45,color: Colors.purple,),
          ],
        ),
      ),
    );
  }
}

class PagePassingData extends StatelessWidget {
  const PagePassingData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('List Data'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, nData){
          return ListTile(
            title: Text('Judul Berita ke $nData'),
            subtitle: Text('Sub Judul Berita ke $nData'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
              PageGetData(nData)
              ));
            },
          );
        },
      ),
    );
  }
}

class PageGetData extends StatelessWidget {
  final int index;
  const PageGetData(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Page Detail Get Data'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Detail Berita $index'),
            Text('Detail Sub Berita $index')
          ],
        ),
      ),

    );
  }
}


