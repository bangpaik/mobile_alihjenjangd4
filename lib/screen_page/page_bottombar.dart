import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_galery_movie.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_ketiga.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_listdata.dart';

class PageBottomBar extends StatefulWidget {
  const PageBottomBar({super.key});

  @override
  State<PageBottomBar> createState() => _PageBottomBarState();
}

class _PageBottomBarState extends State<PageBottomBar> with SingleTickerProviderStateMixin {

  TabController? _tabController;

  //proses do in background
  //initState : proses sebelum view di panggil
  //setState : proses didalam view

  //context :
  //this :
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const[
          PageRegisterForm(),
          PageGaleryMovie(),
          PageSearchListData(),

        ],

      ),
      bottomNavigationBar: BottomAppBar(
        //pilihannya cobain : navigation bar

        child: TabBar(
          isScrollable: true,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          controller: _tabController,

          tabs: [
            Tab(
              text: "Form Register",
              icon: Icon(Icons.input),
            ),
            Tab(
              text: "Galery Photos",
              icon: Icon(Icons.album),
            ),
            Tab(
              text: "List Data",
              icon: Icon(Icons.list),
            ),
          ],
        ),
      ),
    );
  }
}


class PageRegisterForm extends StatefulWidget {
  const PageRegisterForm({super.key});

  @override
  State<PageRegisterForm> createState() => _PageRegisterFormState();
}

class _PageRegisterFormState extends State<PageRegisterForm> {

  TextEditingController txtFullName = TextEditingController();
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtTanggalLahir = TextEditingController();
  String? valAgama, valJK;
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  //method untuk date picker
  Future selectDate() async{
    DateTime? pickedData = await showDatePicker
      (context: context,
        firstDate: DateTime(1950),
        initialDate: DateTime.now(),
        lastDate: DateTime(2100));
    if(pickedData != null){
      setState(() {
        txtTanggalLahir.text = DateFormat("dd-MM-yyyy").format(pickedData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Register Form'),
      ),
      
      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  validator: (val){
                    return val!.isEmpty ? "Tidak Boleh kosong" : null;
                  },
                  controller: txtFullName,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val){
                    return val!.isEmpty ? "Tidak Boleh kosong" : null;
                  },
                  controller: txtUsername,
                  decoration: InputDecoration(
                      hintText: "Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val){
                    return val!.isEmpty ? "Tidak Boleh kosong" : null;
                  },
                  controller: txtEmail,
                  decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onTap: (){
                    selectDate(); //ini untuk memunculkan date picker
                  },
                  validator: (val){
                    return val!.isEmpty ? "Tidak Boleh kosong" : null;
                  },
                  controller: txtTanggalLahir,
                  decoration: InputDecoration(
                      hintText: "Tanggal Lahir",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val){
                    return val!.isEmpty ? "Tidak Boleh kosong" : null;
                  },
                  controller: txtPassword,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 65,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black54),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: DropdownButton(
                    value: valAgama,
                    underline: Container(),
                    isExpanded: true,
                    hint: const Padding(padding: EdgeInsets.all(8),
                      child: Text('Pilih Agama'),
                    ),
                    items: [
                      "Islam",
                      "Budha",
                      "Kristen",
                      "Konghucu"
                    ].map((e){
                      return DropdownMenuItem(
                        value: e,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(e),

                      ));
                    }).toList(),
                    onChanged: (val){
                      setState(() {
                        valAgama = val;
                        print("Anda pilih : $val");
                      });
                    },

                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: RadioListTile(
                        value: "Laki-laki",
                        groupValue: valJK,
                        onChanged: (val){
                          setState(() {
                            valJK = val;
                          });
                        },
                        activeColor: Colors.blue,
                        title: Text('Laki-laki'),
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        value: "Wanita",
                        groupValue: valJK,
                        onChanged: (val){
                          setState(() {
                            valJK = val;
                          });
                        },
                        activeColor: Colors.blue,
                        title: Text('Wanita'),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10,),
                MaterialButton(onPressed: (){
                  if(keyForm.currentState?.validate() == true){
                    if(valJK != null && valAgama != null){
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text('Data Registrasi'),
                              content: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Fullname : ${txtFullName.text}"),
                                  Text("Username : ${txtUsername.text}"),
                                  Text("Password : ${txtPassword.text}"),
                                  Text("Email : ${txtEmail.text}"),
                                  Text("Agama : ${valAgama}"),
                                  Text("Jenis Kelamin : ${valJK}"),
                                  Text("Tanggal Lahir : ${txtTanggalLahir.text}"),
                                ],
                              ),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                },
                                    child: Text("Dismis"))
                              ],
                            );

                          });
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Silahkan isi semua field pada Form!'),
                          backgroundColor: Colors.deepOrange,
                        )
                      );
                    }
                  }
                },
                  child: Text('Submit'),
                  color: Colors.blue,
                  textColor: Colors.white,
                )


              ],
            ),
          ),
          
        ),
      )
    );
  }
}


