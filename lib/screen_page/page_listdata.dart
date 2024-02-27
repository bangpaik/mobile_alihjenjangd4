import 'dart:html';

import 'package:flutter/material.dart';

class PageSearchListData extends StatefulWidget {
  const PageSearchListData({super.key});

  @override
  State<PageSearchListData> createState() => _PageSearchListDataState();
}

class _PageSearchListDataState extends State<PageSearchListData> {
  
  List<String> listDevice = [
    "Android",
    "Tab",
    "Iphone",
    "Ipad",
    "Macbook",
    "Laptop",
    "Printer",
    "Iwatch",
    "Smartwatch"
  ];
  
  bool isCari = true;
  List<String> filterDevice = [];
  TextEditingController txtCari = TextEditingController();
  
  _PageSearchListDataState(){
    txtCari.addListener(() { 
      if(txtCari.text.isEmpty){
        setState(() {
          isCari = true;
          txtCari.text = "";
        });
      }else{
        setState(() {
          isCari = false;
          txtCari.text != "";
        });
      }
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('List Data'),
      ),
      
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: txtCari,
              decoration: InputDecoration(
                hintText: "Search Data",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: Colors.green.withOpacity(0.1)
              ),
            ),
            //kondisi
            isCari ?
            Expanded(child: ListView.builder(
              itemCount: listDevice.length,
                itemBuilder: (context, index){
                return ListTile(
                  title: Text(listDevice[index]),
                );

                })) : CreateFilterList()
          ],
        ),
      ),
      
    );
  }

  Widget CreateFilterList(){
    filterDevice = [];
    for(int i =0; i<listDevice.length; i++){
      var item = listDevice[i];
      if(item.toLowerCase().contains(txtCari.text.toLowerCase())){
        filterDevice.add(item);
      }
    }
    return HasilSearch();
  }

  Widget HasilSearch(){
    return Expanded(
      child: ListView.builder(
        itemCount: filterDevice.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(filterDevice[index]),
          );
        },
      ),
    );
  }
}
