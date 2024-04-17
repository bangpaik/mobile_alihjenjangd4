import 'package:flutter/material.dart';

import 'package:mobile_alihjenjangd4/screen_page/auth_gmail/base_auth.dart';
import 'package:mobile_alihjenjangd4/screen_page/crud_firebase/page_home_food.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_list_user.dart';

class LoginSignUpPage extends StatefulWidget {
  final BaseAuth? auth;
  final VoidCallback? onLoggedIn;
  const LoginSignUpPage({super.key, this.auth, this.onLoggedIn});

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email, password, errorMessage;

  ///deklarasi form untuk login
  FormMode formMode = FormMode.LOGIN;
  bool? isIos;
  bool? isLoading;

  ///cek apakah form valid sebelum perform login atau signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //perform login atau register
  void _validateAndSubmit() async {
    setState(() {
      errorMessage = "";
      isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        if (formMode == FormMode.LOGIN) {
          userId = await widget.auth!.signIn(_email ?? "", password ?? "");

          setState(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const PageHomeFood()),
                    (route) => false);
          });
          print("user sign id : $userId");
        } else {
          userId = await widget.auth!.signUp(_email ?? "", password ?? "");
          setState(() {});
          widget.auth!.sendEmailVerification();
          _showDialogVerification();
          print("sign up id : $userId");
        }
        setState(() {
          isLoading = false;
        });
        if (userId.isNotEmpty && userId != null && formMode == FormMode.LOGIN) {
          widget.onLoggedIn;
          setState(() {});
        }
      } catch (e) {
        print("Error : $e");
        setState(() {
          isLoading = false;
          // if (isIos) {
          //   errorMessage = e.details;
          // } else {
          //   errorMessage = e.message;
          // }
        });
      }
    }
  }

  void changeFormKeSingUp() {
    _formKey.currentState!.reset();
    errorMessage = "";
    setState(() {
      formMode = FormMode.SIGNUP;
    });
  }

  void changeFormKeLogin() {
    _formKey.currentState!.reset();
    errorMessage = "";
    setState(() {
      formMode = FormMode.LOGIN;
    });
  }

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    errorMessage = "";
    isLoading = false;
  }

  void _showDialogVerification() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Verify Your Account'),
          content:
          const Text('Link to verify account has been sent to your email'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  changeFormKeLogin();
                  Navigator.of(context).pop();
                },
                child: const Text('Dismiss'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Food Apps'),
      //   titleTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   backgroundColor: Colors.green,
      // ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo udacoding',
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 70.0, 0.0,
                          0.0), //mengatur posisi kiri kanan atas bawah
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 48.0,
                        child: Image.network(
                          'https://hello.udacoding.id/images/app/logo.png',
                          color: Colors.green,
                        ), //nanti masukan
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
                    child: TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        icon: Icon(
                          Icons.email,
                          color: Colors.green,
                        ),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Email can\'t be Empty' : null,
                      onSaved: (value) => _email = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                    child: TextFormField(
                      maxLines: 1,
                      obscureText: true,
                      autofocus: false,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        icon: Icon(
                          Icons.lock,
                          color: Colors.green,
                        ),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Password can\'t be Empty' : null,
                      onSaved: (value) => password = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                    child: SizedBox(
                      height: 40.0,
                      child: MaterialButton(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: Colors.green,
                          child: formMode == FormMode.LOGIN
                              ? const Text('Login',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white))
                              : const Text(
                            'Create Account',
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.white),
                          ),
                          onPressed: () {
                            _validateAndSubmit();
                          }),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (formMode == FormMode.LOGIN) {
                        changeFormKeSingUp();
                      } else {
                        changeFormKeLogin();
                      }
                    },
                    child: formMode == FormMode.LOGIN
                        ? const Text(
                      'Create an Account',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    )
                        : const Text(
                      'Have an account? Please sign in',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //widget untuk menampilkan error
  Widget displayMessageError() {
    if (errorMessage!.isNotEmpty && errorMessage != null) {
      return Text(
        errorMessage ?? "",
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            height: 1.0,
            fontSize: 13.0),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  //widget untuk circular progress
  Widget showCircularProgress() {
    if (isLoading == true) {
      return const Center(child: CircularProgressIndicator());
    }
    return const SizedBox(
      height: 0.0,
      width: 0.0,
    );
  }
}