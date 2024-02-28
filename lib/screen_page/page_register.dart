import 'package:flutter/material.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_login.dart';

class PageRegister extends StatefulWidget {
  const PageRegister({super.key});

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {

  TextEditingController txtFullName = TextEditingController();
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();


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


                  SizedBox(height: 10,),
                  MaterialButton(onPressed: (){
                    if(keyForm.currentState?.validate() == true){

                      // else{
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //         content: Text('Silahkan isi semua field pada Form!'),
                      //         backgroundColor: Colors.deepOrange,
                      //       )
                      //   );
                      // }
                    }
                  },
                    child: Text('Register'),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),



                ],
              ),
            ),

          ),
        ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(
              width: 1,
              color: Colors.green
            )
          ),
          onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)
              => PageLogin()
            ),
                    (route) => false);
          },
          child: Text('Anda Sudah Punya Akun ? Silahkan Login'),
        ),
      ),
    );
  }
}
