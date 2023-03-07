import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/Model/user_model.dart';
import 'package:provider_mvvm/Repository/auth_repository.dart';
import 'package:provider_mvvm/Utils/Routes/routes_name.dart';
import 'package:provider_mvvm/Utils/utils.dart';
import 'package:provider_mvvm/ViewModel/user_view_model.dart';

class AuthViewModel with ChangeNotifier{

  final _myRepo=AuthRepository();
  bool _loading=false;
  bool get loading=>_loading;
  bool _signUpLoading=false;
  bool get signUpLoading=>_signUpLoading;
  setLoading(bool value){
    _loading=value;
    notifyListeners();
  }
  setsignUpLoading(bool value){
    _signUpLoading=value;
    notifyListeners();
  }
  Future<void>loginApi(dynamic data,BuildContext context)async{
    setLoading(true);
  _myRepo.loginApi(data).then((value){
    setLoading(false);
    Utils.flushbarErrorMessage('Login successful', context);
    Navigator.pushNamed(context, RoutesName.home);
    if(kDebugMode){
      print(value.toString());
    }

  }).onError((error, stackTrace){
    setLoading(false);
    if(kDebugMode){

      Utils.flushbarErrorMessage(error.toString(), context);
      print(error.toString());
    }

  });
  }
  Future<void>signUpApi(dynamic data,BuildContext context)async{
    setsignUpLoading(true);
    _myRepo.signUpApi(data).then((value){
      setsignUpLoading(false);
      final userPreferences=Provider.of<UserViewModel>(context,listen: false);
      userPreferences.saveUser(
        UserModel(token: value['token'].toString())//It will not allow to go back to login page when you are restart the app(already logged in)
      );
      Utils.flushbarErrorMessage('signup successful', context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());
      }

    }).onError((error, stackTrace){
      setsignUpLoading(false);
      if(kDebugMode){

        Utils.flushbarErrorMessage(error.toString(), context);
        print(error.toString());
      }

    });
  }
}