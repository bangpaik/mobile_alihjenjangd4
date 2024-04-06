import 'package:flutter/material.dart';
import 'package:mobile_alihjenjangd4/screen_page/auth_gmail/base_auth.dart';
import 'package:mobile_alihjenjangd4/screen_page/auth_gmail/page_login_firebase.dart';
import 'package:mobile_alihjenjangd4/screen_page/page_list_user.dart';


class RootPage extends StatefulWidget {
  final BaseAuth? auth;
  const RootPage({this.auth, super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

//status auth
enum AuthStatus{ NOT_DETERMINED, NOT_LOGGED_IN, LOGGED_IN }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String userId = "";
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth?.getCurrentUser().then((user) {
      setState(() {
        //cek status
        if(user != null){
          userId = user.uid;
        }
        authStatus = user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }
  
  //method untuk login
  void onLoggedIn(){
    widget.auth?.getCurrentUser().then((user){
      setState(() {
        userId = user?.uid ?? "";
      });
    });

    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  //method untuk logout
  void onSignOut(){
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      userId = "";
    });
  }

  //widget untuk loading
  Widget buildWaitingScreen(){
    return Scaffold(
      body : Container(
        alignment : Alignment.center,
        child : CircularProgressIndicator(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    switch(authStatus){
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
      case AuthStatus.NOT_LOGGED_IN:
        return LoginSignUpPage(auth : widget.auth, onLoggedIn : onLoggedIn);
      case AuthStatus.LOGGED_IN:
        if(userId.isNotEmpty && userId != null){
          //untuk crud firebase
          return PageListUser();
        }else{
          return buildWaitingScreen();
        }
      default :
        return buildWaitingScreen();
    }
  }
}
