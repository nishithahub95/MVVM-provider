import 'package:flutter/cupertino.dart';
import 'package:provider_mvvm/Data/responses/api_responses.dart';
import 'package:provider_mvvm/Model/album_model.dart';
import 'package:provider_mvvm/Repository/home_repository.dart';

class HomeViewModel with ChangeNotifier{
final _myRepo=HomeRepository();
ApiResponses<Album>albumList=ApiResponses.loading();
setMovieList(ApiResponses<Album>responses){
  albumList=responses;
  notifyListeners();
}
Future<void>fetchAlbumApi()async{
  setMovieList(ApiResponses.loading());
  _myRepo.fetchAlbum().then((value) {
setMovieList(ApiResponses.completed(value));
  }).onError((error, stackTrace){
    setMovieList(ApiResponses.error(error.toString()));
  });

}
}