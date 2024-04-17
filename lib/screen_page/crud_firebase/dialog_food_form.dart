import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobile_alihjenjangd4/models/model_food_firebase.dart';

class ShowDialogFoodForm extends StatefulWidget {

  final String? user;
  final Query? queryFood;
  final List<ModelFoodFirebase>? listFood;

  const ShowDialogFoodForm({super.key, this.user, this.queryFood, this.listFood});


  @override
  State<ShowDialogFoodForm> createState() => _ShowDialogFoodFormState();
}

class _ShowDialogFoodFormState extends State<ShowDialogFoodForm> {

  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference? databaseReference;
  StreamSubscription<DatabaseEvent>? streamSubscriptionUpdate;

  TextEditingController txtNamaMakanan = TextEditingController();
  TextEditingController txtAsalMakanan = TextEditingController();

  //method untuk proses add makanan
  Future<void> addMakanan(String nama, String asal) async{
    if(widget.listFood!.isNotEmpty){}
    print("user add id ${widget.user}");
    ModelFoodFirebase res = ModelFoodFirebase(nama, asal, widget.user);

    print("respon data $res");
    await database
        .ref()
        .child("Kuliner")
        .child(res.key ?? "")
        .push()//submit
        .set(res.toJson());
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Makanan'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: txtNamaMakanan,
            decoration: InputDecoration(
              hintText: 'Nama Makananan'
            ),
          ),
          SizedBox(height: 8,),
          TextFormField(
            controller: txtAsalMakanan,
            decoration: InputDecoration(
                hintText: 'Asal Makananan'
            ),
          ),
          SizedBox(height: 25,),
          Center(
            child: MaterialButton(
              color: Colors.green,
              minWidth: 200,
              height: 45,
              onPressed: (){
                print("data user : ${widget.user}");
                addMakanan(txtNamaMakanan.text, txtAsalMakanan.text).then((value){
                  Navigator.pop(context);
                });
              },
              child: Text('Simpan'),
            ),
          )

        ],
      ),

    );
  }
}
