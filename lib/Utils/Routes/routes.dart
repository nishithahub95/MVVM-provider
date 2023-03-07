import 'package:flutter/material.dart';
import 'package:provider_mvvm/Utils/Routes/routes_name.dart';
import 'package:provider_mvvm/View/home_screen.dart';
import 'package:provider_mvvm/View/login_view.dart';
import 'package:provider_mvvm/View/signup_view.dart';
import 'package:provider_mvvm/View/splash_view.dart';

class Routes{
  static MaterialPageRoute generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context)=>const LoginView());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (BuildContext context)=>const SignUpView());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());

      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });

    }
  }
}
