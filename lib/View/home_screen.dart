import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/Data/responses/status.dart';
import 'package:provider_mvvm/Model/album_model.dart';
import 'package:provider_mvvm/Utils/Routes/routes_name.dart';
import 'package:provider_mvvm/ViewModel/home_view_model.dart';
import 'package:provider_mvvm/ViewModel/user_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel=HomeViewModel();
  @override
  void initState() {
    // TODO: implement initState
    homeViewModel.fetchAlbumApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: (){
                userPrefernece.remove().then((value) {
                  Navigator.pushNamed(context, RoutesName.login);
                });
              },
              child: Text('Logout')),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context)=>homeViewModel,
        child:Consumer<HomeViewModel>(builder: (context,value,_){
         // final alb=value.albumList.;
    switch(value.albumList.status) {
      case Status.LOADING:
        return Center(child: CircularProgressIndicator());
      case Status.ERROR:
        return Center(child: Text(value.albumList.message.toString()));
      case Status.COMPLETED:
        return ListView.builder(itemCount: value.albumList.data!.title!.length,
            itemBuilder: (context, index){
          return Card(
          child:Text(value.albumList.data!.title![index].toString())
              //child:Text(value.albumList.data!.id.toString())
          );
        });
    }
          return Container(

          );
        },)
      )
    );
  }
}
