import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_alihjenjangd4/screen_page/auth_gmail/base_auth.dart';
import 'package:mobile_alihjenjangd4/models/model_food_firebase.dart';
import 'package:mobile_alihjenjangd4/screen_page/auth_gmail/page_login_firebase.dart';
import 'package:mobile_alihjenjangd4/screen_page/crud_firebase/detail_page_food.dart';
import 'package:mobile_alihjenjangd4/screen_page/crud_firebase/dialog_food_form.dart';

class PageHomeFood extends StatefulWidget {
  final BaseAuth? auth;
  final VoidCallback? onSignOut;
  final String? userId;

  const PageHomeFood({super.key, this.auth, this.onSignOut, this.userId});

  @override
  State<PageHomeFood> createState() => _PageHomeFoodState();
}

class _PageHomeFoodState extends State<PageHomeFood> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference? databaseReference;
  List<ModelFoodFirebase> listfood = [];
  Query? queryFood;
  StreamSubscription<DatabaseEvent>? onAddList;

  //get data firebase
  void getData() async {
    if (kDebugMode) {
      print('user id ${widget.userId}');
    }
    setState(() {
      listfood = [];
    });
    queryFood = database
        .ref()
        .child("Kuliner")
        .orderByChild("userId")
        .equalTo(widget.userId);

    onAddList = queryFood?.onChildAdded.listen(updateList);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    checkEmailVerification();
  }

  Future<void> updateList(DatabaseEvent event) async {
    setState(() {
      listfood.add(ModelFoodFirebase.fromSnapshoot(event.snapshot));
    });
  }

  bool? isEmailVerified;

  void checkEmailVerification() async {
    isEmailVerified = await widget.auth?.isEmailVerified();
    print('status email : ${isEmailVerified}');

    if (isEmailVerified == false) {
      //belum verifikasi
      showDialogKonfirmasiEmail();
    }
  }

  void showDialogKonfirmasiEmail() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Silahkan verifikasi terlebih dahulu email anda!'),
            content: Text('Link verifikasi sudah di kirim ke email!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    resentEmailVerifikasi();
                  },
                  child: Text('Resent Link')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }

  void resentEmailVerifikasi() {
    widget.auth?.sendEmailVerification();
    showDialogVerifikasiEmail();
  }

  void showDialogVerifikasiEmail() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Silahkan verifikasi akun anda!'),
            content: Text('Email verifikasi sudah d kirim!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  Future<void> deleteData(String key, int index) async {
    await database.ref().child("Kuliner").child(key).remove();
    setState(() {
      listfood.removeAt(index);
    });
  }

  signOut() async {
    try {
      await widget.auth?.signOut();
      setState(() {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginSignUpPage()),
            (route) => false);
      });

      widget.onSignOut;
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    onAddList?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CRUD Food Firebase',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          TextButton(
              onPressed: () {
                signOut();
              },
              child: Text(
                'Signout',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return ShowDialogFoodForm(
                  user: widget.userId,
                  queryFood: queryFood,
                  listFood: listfood,
                );
              });
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: listfood.length,
        itemBuilder: (context, index) {
          ModelFoodFirebase data = listfood[index];

          return Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              child: ListTile(
                trailing: IconButton(
                  onPressed: () {
                    //ini adalah proses edit atau ke detail
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailPageFood(
                                  data: data,
                                  listFood: listfood,
                                  queryFood: queryFood,
                                  onUpdate: () {
                                    getData();
                                  },
                                )));
                  },
                  icon: Icon(Icons.edit),
                ),
                title: Text(data.namaMakanan ?? ""),
                subtitle: Text(data.asalMakanan ?? ""),
                //delete data
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                              'Apakah anda yakin ingin menghapus data ini?'),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            },
                                child: Text('NO')),

                            TextButton(onPressed: (){
                              deleteData(data.key ?? "",index )
                                  .then((value){
                                    Navigator.pop(context);
                              });
                            },
                                child: Text('Yes'))
                          ],
                        );
                      });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
