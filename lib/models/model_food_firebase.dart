import 'package:firebase_database/firebase_database.dart';

class ModelFoodFirebase{

  String? key, namaMakanan, asalMakanan, userId;

  ModelFoodFirebase(this.namaMakanan, this.asalMakanan, this.userId);

  ModelFoodFirebase.fromSnapshoot(DataSnapshot snapshot){
    var map = snapshot.value as Map;

    key = snapshot.key;
    namaMakanan = map["namaMakanan"];
    asalMakanan = map["asalMakanan"];
    userId = map["userId"];
  }

  toJson(){
    return{
      "namaMakanan" : namaMakanan,
      "asalMakanan" : asalMakanan,
      "userId" : userId,
    };
  }

}