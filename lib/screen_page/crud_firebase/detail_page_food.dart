import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobile_alihjenjangd4/models/model_food_firebase.dart';

class DetailPageFood extends StatefulWidget {

  final Function? onUpdate;
  final ModelFoodFirebase? data;
  final List<ModelFoodFirebase>? listFood;
  final Query? queryFood;

  const DetailPageFood({super.key,
    this.data,
    this.listFood,
    this.queryFood,
    required this.onUpdate
  });

  @override
  State<DetailPageFood> createState() => _DetailPageFoodState();
}

class _DetailPageFoodState extends State<DetailPageFood> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference? databaseReference;
  StreamSubscription<DatabaseEvent>? streamSubscriptionUpdate;

  TextEditingController txtNamaMakanan = TextEditingController();
  TextEditingController txtAsalMakanan = TextEditingController();

  //proses do in background

  Future<void> updateFood(ModelFoodFirebase foodModel, String nama, String asal) async{
    foodModel.namaMakanan = nama;
    foodModel.asalMakanan = asal;

    await database.ref().child("Kuliner").child(foodModel.key ?? "").set(
      foodModel.toJson(),
    );
    widget.onUpdate!();
  }

  void onUpdateFood(DatabaseEvent event){
    var oldEntry = widget.listFood?.singleWhere((food){
      return food.key == event.snapshot.key;
    });

    setState(() {
      widget.listFood?[widget.listFood!.indexOf(oldEntry!)]=
          ModelFoodFirebase.fromSnapshoot(event.snapshot);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamSubscriptionUpdate = databaseReference?.onChildChanged.listen(onUpdateFood);
    databaseReference = database.ref().child("Kuliner");
    txtNamaMakanan = TextEditingController(text: widget.data?.namaMakanan);
    txtAsalMakanan = TextEditingController(text: widget.data?.asalMakanan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        backgroundColor : Colors.green,
        title : Text("Edit Data Food",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
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
                  updateFood(widget.data!, txtNamaMakanan.text, txtAsalMakanan.text)
                      .then((value){
                        Navigator.pop(context);
                  });

                },
                child: Text(widget.data?.key != null ? "Update" : "Simpan"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
