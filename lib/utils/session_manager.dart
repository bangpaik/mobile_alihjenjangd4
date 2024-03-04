import 'package:shared_preferences/shared_preferences.dart';

class SessionManager{
  int? value;
  String? idUser;
  String? userName;
  String? fullname;

  //simpan sesi
  Future<void> saveSession(int val, String id, String userName, String fullName) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("value", val);
    pref.setString("id", id);
    pref.setString("username", userName);
    pref.setString("fullname", fullName);
  }

  Future getSession() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getInt("value");
    idUser = pref.getString("id");
    userName = pref.getString("username");
    fullname = pref.getString("fullname");
  }
  //remove --> logout
  Future clearSession() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

}

//instance class biar d panggil
SessionManager sessionManager = SessionManager();