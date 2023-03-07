import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider_mvvm/Model/user_model.dart';
import 'package:provider_mvvm/Utils/Routes/routes_name.dart';
import 'package:provider_mvvm/ViewModel/user_view_model.dart';

class SplashServices{
  Future<UserModel>gerUserData()=>UserViewModel().getUser();
  void checkAuthentication(BuildContext context)async{
    gerUserData().then((value) async{
      if(value.token.toString() == 'null' || value.token.toString() == ''){
        await Future.delayed(Duration(seconds: 5));
        Navigator.pushNamed(context, RoutesName.login);
      }else {
        await  Future.delayed(Duration(seconds: 5));
        Navigator.pushNamed(context, RoutesName.home);
      }

    }).onError((error, stackTrace){
      if(kDebugMode){
        print(error.toString());
      }
    }


    );

  }
}