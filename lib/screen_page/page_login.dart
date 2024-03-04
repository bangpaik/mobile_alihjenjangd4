import 'package:flutter/material.dart';
import 'package:mobile_alihjenjangd4/models/ModelLogin.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_list_berita.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_register.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_alihjenjangd4/utils/session_manager.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {

  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isLoading = false;
  Future<ModelLogin?> loginAccount() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.post(
          Uri.parse('http://192.168.1.14:8080/beritaDb/login.php'),
          body: {
            "username": txtUsername.text,
            "password": txtPassword.text,

          });

      ModelLogin data = modelLoginFromJson(res.body);
      //cek kondisi respon
      if (data.value == 1) {
        setState(() {
          isLoading = false;
          sessionManager.saveSession(data.value ?? 0, data.id ?? "", data.username ?? "", data.fullname ?? "");
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
          //kondisi berhasil dan pindah ke page login
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PageListBerita()),
                  (route) => false);
        });
        //kondisi email sudah ada
      } else if (data.value == 2) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
        //kondisi gagal daftar
      } else {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${data.message}')));
      }
    } catch (e) {
      isLoading = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Login Form'),
      ),

      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [

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
                  controller: txtPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),


                SizedBox(height: 10,),
                Center(
                  child: isLoading
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : MaterialButton(
                    minWidth: 150,
                    height: 45,
                    onPressed: () {
                      if (keyForm.currentState?.validate() == true) {
                        loginAccount();
                      }
                    },
                    child: Text('Login'),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                )
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
            => PageRegister()
            ),
                    (route) => false);
          },
          child: Text('Anda Belum Punya Akun ? Silahkan Register'),
        ),
      ),
    );
  }
}
