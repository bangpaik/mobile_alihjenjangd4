import 'package:flutter/material.dart';
import 'package:mobile_alihjenjangd4/helpe/db_helper_sqflite.dart';
import 'package:mobile_alihjenjangd4/models/model_pegawai_sqflite.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_add_pegawai_sqflite.dart';

class PageListPegawaiSqflite extends StatefulWidget {
  const PageListPegawaiSqflite({super.key});

  @override
  State<PageListPegawaiSqflite> createState() => _PageListPegawaiSqfliteState();
}

class _PageListPegawaiSqfliteState extends State<PageListPegawaiSqflite> {
  DatabaseHelperSqflite dbHelper = DatabaseHelperSqflite();
  List<ModelPegawai> itemList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper.getAllPegawai().then((value) {
      setState(() {
        for (var item in value!) {
          itemList.add(ModelPegawai.fromMap(item));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Pegawai'),
        backgroundColor: Colors.green,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 14),
        actions: [
          //untuk add data pegawai form
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)
                  => PageAddPegawaiSqflite()
                ));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          ModelPegawai data = itemList[index];
          return Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: ListTile(
                trailing: IconButton(
                  onPressed: () {
                    //untuk edit form
                    Navigator.push(context, MaterialPageRoute(builder: (context)
                      => PageAddPegawaiSqflite(data: data,)
                    ));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  //untuk delete
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                              'Anda yakin ingin menghapus data ${data.firstName} ?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No')),
                            TextButton(
                                onPressed: () {
                                  dbHelper.deletePegawai(data.id).then((_) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PageListPegawaiSqflite()),
                                        (route) => false);
                                  });
                                },
                                child: Text('Yes'))
                          ],
                        );
                      });
                },
                title: Text(data.firstName),
                subtitle: Text(data.emailId),
              ),
            ),
          );
        },
      ),
    );
  }
}
