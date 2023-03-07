import 'package:provider_mvvm/Data/network/BaseApiServices.dart';
import 'package:provider_mvvm/Data/network/NetworkApiServices.dart';
import 'package:provider_mvvm/Model/album_model.dart';
import 'package:provider_mvvm/Resources/app_url.dart';

class HomeRepository{
  BaseApiServices _apiServices=NetworkApiServices();
  Future<Album>fetchAlbum()async{
    try{
      dynamic response=await _apiServices.getGetApiResponses(AppUrl.albumEndPoint);
      return response=Album.fromJson(response);
    }catch(e){
      throw e;
    }

  }
}