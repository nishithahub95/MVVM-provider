import 'package:provider_mvvm/Data/network/BaseApiServices.dart';
import 'package:provider_mvvm/Data/network/NetworkApiServices.dart';
import 'package:provider_mvvm/Resources/app_url.dart';

class AuthRepository{
  BaseApiServices _apiServices=NetworkApiServices();
  Future<dynamic>loginApi(dynamic data)async{
    try{
     dynamic response=await _apiServices.getPostApiResponses(AppUrl.loginEndPint, data);
     return response;
    }catch(e){
      throw e;
    }

  }
  Future<dynamic>signUpApi(dynamic data)async{
    try{
      dynamic response=await _apiServices.getPostApiResponses(AppUrl.registerApiEndPoint, data);
      return response;
    }catch(e){
      throw e;
    }

  }
}