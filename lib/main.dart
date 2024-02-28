import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_bottombar.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_kedua.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_ketiga.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_list_berita.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_list_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PageUtama(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PageUtama extends StatelessWidget {
  const PageUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //huruf kecil :properti
        //huruf besar :Widget
        backgroundColor: Colors.green,
        title: Text(
          'Politeknik Negeri Padang',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(

        //child : hanya bisa menampung 1 widget didalamnya
        //children : bisa menampung lebih dari 1 widget (column, row, list, stack)
        child: Padding(
          padding: EdgeInsets.all(7),
          
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('gambar/logo_pnp.png',height: 150, width: 150,),
                Image.asset('gambar/movie/film9.png',height: 150, width: 150,),
                Text('Alih Jenjang D4 PNP'),
                SizedBox(
                  height: 10,
                ),
                Text('Teknik Informatika'),
                SizedBox(
                  height: 20,
                ),
                Text('Politeknik Negeri Padang'),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () {
                    showToast('This is normal toast with animation',
                        context: context,
                        animation: StyledToastAnimation.slideFromRight,
                        reverseAnimation: StyledToastAnimation.slideToRight,
                        position: StyledToastPosition.top,
                        startOffset: Offset(1.0, 0.0),
                        reverseEndOffset: Offset(1.0, 0.0),
                        animDuration: Duration(seconds: 1),
                        duration: Duration(seconds: 4),
                        curve: Curves.linearToEaseOut,
                        reverseCurve: Curves.fastOutSlowIn);
                  },
                  child: Text('Tekan Ini'),
                  color: Colors.green,
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 5,
                ),
                MaterialButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('ini adalah snackbar'),
                      backgroundColor: Colors.deepOrangeAccent,
                      action: SnackBarAction(
                        label: "OK",
                        onPressed: () {},
                      ),
                    ));
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('Snackbar'),
                ),
            
                SizedBox(height: 10,),
                MaterialButton(onPressed: (){
                  //pindah ke page lain
                  //navigator push : dari class A ke class B
                  //navigator pop : class B ke class A
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    PageNavigation()
                  ));
            
                },
                  child: Text('Page Navigation'),
                  color: Colors.deepOrangeAccent,
                  textColor: Colors.white,
                ),
                SizedBox(height: 10,),
                MaterialButton(onPressed: (){
                  //pindah ke page lain
                  //navigator push : dari class A ke class B
                  //navigator pop : class B ke class A
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      PagePassingData()
                  ));
            
                },
                  child: Text('Page Passing Data'),
                  color: Colors.deepOrangeAccent,
                  textColor: Colors.white,
                ),
            
                SizedBox(height: 10,),
                MaterialButton(onPressed: (){
                  //pindah ke page lain
                  //navigator push : dari class A ke class B
                  //navigator pop : class B ke class A
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      PageBottomBar()
                  ));
            
                },
                  child: Text('Bottom Menu'),
                  color: Colors.deepOrangeAccent,
                  textColor: Colors.white,
                ),
                SizedBox(height: 10,),
                MaterialButton(onPressed: (){
                  //pindah ke page lain
                  //navigator push : dari class A ke class B
                  //navigator pop : class B ke class A
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      PageListUser()
                  ));
            
                },
                  child: Text('List Data User'),
                  color: Colors.deepOrangeAccent,
                  textColor: Colors.white,
                ),
                SizedBox(height: 10,),
                MaterialButton(onPressed: (){
                  //pindah ke page lain
                  //navigator push : dari class A ke class B
                  //navigator pop : class B ke class A
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      PageListBerita()
                  ));

                },
                  child: Text('List Berita'),
                  color: Colors.deepOrangeAccent,
                  textColor: Colors.white,
                ),
            
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PageNavigation extends StatelessWidget {
  const PageNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Page Navigation'),
        backgroundColor: Colors.purple,
      ),
      drawer: SizedBox(
        width: 200,
        child: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(accountName: Text('Rizki Syaputra'),
                  accountEmail: Text('rizki@udacoding.id'),
                  currentAccountPicture: CircleAvatar(
                    radius: 55,
                    child: Icon(
                      Icons.person,
                      color: Colors.green,
                      size: 65,
                    ),
                  ),
              ),

              ListTile(
                title: Text("Row Widget"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                    => PageKedua()
                  ));
                },
              ),
              ListTile(
                title: Text("Row  & Column Widget"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  => PageKetiga()
                  ));
                },
              ),
              ListTile(
                title: Text("List Horizontal"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  => PageListView()
                  ));
                },
              ),

            ],
          ),
        ),
      ),

      body: Center(child: Text('Ini Page Navigation')),
    );
  }
}

