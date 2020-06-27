import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poc/models/post_model.dart';
import 'package:poc/views/home_view.dart';
import 'package:poc/views/image_view.dart';
import 'package:poc/views/login_view.dart';
import 'package:poc/views/splash_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings);
    switch (settings.name) {
      case RoutePaths.Splash:
        return MaterialPageRoute(builder: (_) => SplashView());
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutePaths.image:
        var post = settings.arguments as PostDetails;
        return MaterialPageRoute(
            builder: (_) => ImageView(
                  postDetails: post,
                ));
//      case RoutePaths.Post:
//        var post = settings.arguments as Post;
//        return MaterialPageRoute(builder: (_) => PostView(post: post));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

class RoutePaths {
  static const String Login = 'login';
  static const String Home = 'home';
  static const String Post = 'post';
  static const String image = 'image';
  static const String Splash = 'splash';
}
