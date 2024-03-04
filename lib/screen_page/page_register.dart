import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_alihjenjangd4/models/model_register.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_login.dart';
import 'package:http/http.dart' as http;

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

  bool isLoading = false;
  Future<ModelRegister?> registerAccount() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.post(
          Uri.parse('http://192.168.1.14:8080/beritaDb/register.php'),
          body: {
            "username": txtUsername.text,
            "password": txtPassword.text,
            "fullname": txtFullName.text,
            "email": txtEmail.text,
          });

      ModelRegister data = modelRegisterFromJson(res.body);
      //cek kondisi respon
      if (data.value == 1) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
          //kondisi berhasil dan pindah ke page login
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PageLogin()),
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
    return Scaffold(
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
                  validator: (val) {
                    return val!.isEmpty ? "Tidak Boleh kosong" : null;
                  },
                  controller: txtFullName,
                  decoration: InputDecoration(
                      hintText: "Full Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Tidak Boleh kosong" : null;
                  },
                  controller: txtUsername,
                  decoration: InputDecoration(
                      hintText: "Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Tidak Boleh kosong" : null;
                  },
                  controller: txtEmail,
                  decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    return val!.isEmpty ? "Tidak Boleh kosong" : null;
                  },
                  controller: txtPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
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
                              registerAccount();
                            }
                          },
                          child: Text('Register'),
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
              side: const BorderSide(width: 1, color: Colors.green)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => PageLogin()),
                (route) => false);
          },
          child: Text('Anda Sudah Punya Akun ? Silahkan Login'),
        ),
      ),
    );
  }
}
