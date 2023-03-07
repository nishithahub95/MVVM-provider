import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm/Utils/Routes/routes.dart';
import 'package:provider_mvvm/Utils/Routes/routes_name.dart';
import 'package:provider_mvvm/View/login_view.dart';
import 'package:provider_mvvm/ViewModel/auth_view_model.dart';
import 'package:provider_mvvm/ViewModel/user_view_model.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>AuthViewModel()),
      ChangeNotifierProvider(create: (_)=>UserViewModel())
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),

    );
  }
}


