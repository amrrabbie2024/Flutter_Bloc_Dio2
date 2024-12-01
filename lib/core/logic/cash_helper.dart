import 'package:flutter_apis_pagination/features/login/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{

  static late SharedPreferences _preferences;
  static Future<void> init() async {
    _preferences=await SharedPreferences.getInstance();
  }

  static void saveLanguage(String languge){
    _preferences.setString("languge", languge);
  }

  static String getLanguage(){
    return _preferences.getString("languge")??"en";
  }

  static void saveUserData(LoginModel data){
    _preferences.setString("fullname", data.fullname);
    _preferences.setString("token", data.token);
    _preferences.setString("image", data.image);
  }

  static String getFullname(){
    return _preferences.getString("fullname")??"";
  }

  static String getToken(){
    return _preferences.getString("token")??"";
  }

  static String getImage(){
    return _preferences.getString("image")??"";
  }

  static void saveIntroStatus(bool status){
    _preferences.setBool("intro_status", status);
  }

  static bool getIntroStatus(){
    return _preferences.getBool("intro_status")??false;
  }

  static saveLoginToken(String token){
    _preferences.setString("login_token", token);
  }

  static String getLoginToken(){
    return _preferences.getString("login_token")??"";
  }

  static saveLoginId(String id){
    _preferences.setString("login_id", id);
  }

  static String getLoginId(){
    return _preferences.getString("login_id")??"";
  }
}