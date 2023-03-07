import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider_mvvm/Data/App_exceptions.dart';
import 'package:provider_mvvm/Data/network/BaseApiServices.dart';

class NetworkApiServices extends BaseApiServices{
  @override
  Future getGetApiResponses(String url) async{

    dynamic responseJson;

   try{
     final response=await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
     responseJson=returnResponse(response);

   }on SocketException{
     //Socket exception for no internet connection
     throw FetchDataExceptions('No internet connection');
   }
   return responseJson;
  }

  @override
  Future getPostApiResponses(String url,dynamic data)async {
    dynamic responseJson;

    try{
      Response response=await http.post(Uri.parse(url),body: data).timeout(Duration(seconds: 10));
      responseJson=returnResponse(response);

    }on SocketException{
      //Socket exception for no internet connection
      throw FetchDataExceptions('No internet connection');
    }
    return responseJson;
  }
  dynamic returnResponse(http.Response response){

    switch(response.statusCode){
      case 200:
        dynamic responseJson=jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestExceptions(response.statusCode.toString());
      case 404:
        throw UnauthorisedExceptions(response.statusCode.toString());

      default:
        throw FetchDataExceptions('Error occurred during communicating with server with statuscode' + response.statusCode.toString());
    }

  }

}