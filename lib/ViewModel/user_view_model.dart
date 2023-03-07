import 'package:flutter/material.dart';
import 'package:provider_mvvm/Model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier{
Future<bool>saveUser(UserModel user)async{
  SharedPreferences sp= await SharedPreferences.getInstance();
 sp.setString('token', user.token.toString());
 notifyListeners();
  return true;

}

Future<UserModel>getUser()async{
  SharedPreferences sp= await SharedPreferences.getInstance();
 String? tocken= sp.getString('token');

  return UserModel(
    token:tocken.toString()
  );

}
Future<bool>remove()async{
  SharedPreferences sp= await SharedPreferences.getInstance();
 return sp.clear();
}

}