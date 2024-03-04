import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_alihjenjangd4/main.dart';
import 'package:mobile_alihjenjangd4/models/model_berita.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_detail_berita.dart';
import 'package:mobile_alihjenjangd4/utils/session_manager.dart';

class PageListBerita extends StatefulWidget {
  const PageListBerita({super.key});

  @override
  State<PageListBerita> createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {

  String? userName;

  Future<List<Datum>?> getBerita() async{
    try{
      http.Response res = await http.get(Uri.parse('http://192.168.1.14:8080/beritaDb/getBerita.php'));
      return modelBeritaFromJson(res.body).data;
    }catch(e){
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()))
        );
      });
    }
  }

  //untuk mendapatkan data sesi
  Future getDataSession() async{
    await Future.delayed(const Duration(seconds: 5),(){
      sessionManager.getSession().then((value) {
        print('data sesi :' + value.toString());
        // userName = value.toString();
        userName = sessionManager.userName;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionManager.getSession();
    print(sessionManager.getSession());
    getDataSession();

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita Nasional'),
        backgroundColor: Colors.cyan,
        actions: [
          TextButton(onPressed: (){}, child: Text('Hi, ${userName}')),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Logout',
            onPressed: () {
             //clear session
              setState(() {
                sessionManager.clearSession();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => PageUtama()),
                        (route) => false);
              });
            },
          ),
        ],
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(

          child: FutureBuilder(
            future: getBerita(),
            builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index){
                    Datum? data = snapshot.data?[index];
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)
                            => PageDetailBerita(data)
                          ));
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              Padding(
                                padding: EdgeInsets.all(8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network('http://192.168.1.14:8080/beritaDb/gambar_berita/${data?.gambarBerita}',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text("${data?.judul}",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                subtitle: Text("${data?.isiBerita}",
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black54
                                  ),
                                ),

                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }else if (snapshot.hasError){
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }else{
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
