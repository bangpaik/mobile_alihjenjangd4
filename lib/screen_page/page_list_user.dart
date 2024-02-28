import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_alihjenjangd4/models/model_user.dart';

class PageListUser extends StatefulWidget {
  const PageListUser({super.key});

  @override
  State<PageListUser> createState() => _PageListUserState();
}

class _PageListUserState extends State<PageListUser> {

  bool isLoading = false;
  List<ModelUsers> listUser = [];

  //bikin method untuk get user
  Future getUser() async{
    try{
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      var data = jsonDecode(res.body);
      setState(() {
        for(Map<String, dynamic> i in data){
          listUser.add(ModelUsers.fromJson(i));
        }
      });

    }catch (e){
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
        );
      });
    }
  }

  //proses do in background
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data User from Api"),
        backgroundColor: Colors.deepOrangeAccent,
      ),

      body: ListView.builder(
          itemCount: listUser.length,
          itemBuilder: (context, index){
            return Padding(
              padding: EdgeInsets.all(8),
              child: Card(
                child: ListTile(
                  title: Text(listUser[index].name ?? "",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(listUser[index].email ?? ""),
                      Text(listUser[index].address.street ?? ""),
                      Text("Company : ${listUser[index].company.name}" ?? ""),

                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
