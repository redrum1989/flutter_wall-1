import 'package:flutter/material.dart';
import 'package:flutter_wall/Model/PostScreenArguments.dart';
import 'package:flutter_wall/Screens/alumni_register_screen.dart';
import 'package:flutter_wall/Screens/choose_screen.dart';
import 'package:flutter_wall/Screens/initial_screen.dart';
import 'package:flutter_wall/Screens/login_screen.dart';
import 'package:flutter_wall/Screens/post_screen.dart';
import 'package:flutter_wall/Screens/postcreation_screen.dart';
import 'package:flutter_wall/Screens/profile_screen.dart';
import 'package:flutter_wall/Screens/student_register_screen.dart';
import 'package:flutter_wall/Screens/guestpost_screen.dart';
import 'package:provider/provider.dart';

Route<Null> getGenerateRoute(RouteSettings settings){

  switch(settings.name){

    case InitialScreen.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: InitialScreen.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: InitialScreen(),
          );
        },
      );
    
    case LoginScreen.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: LoginScreen.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: LoginScreen(),
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child){
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      );

    case StudentRegisterScreen.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: StudentRegisterScreen.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: StudentRegisterScreen(),
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child){
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      );

    case AlumniRegisterScreen.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: AlumniRegisterScreen.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: AlumniRegisterScreen(),
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child){
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      );

    case ChooseScreen.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: ChooseScreen.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: ChooseScreen(),
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child){
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      );

    case PostScreen.routeName:
      final args = settings.arguments as PostScreenArguments;
      return PageRouteBuilder(
        settings: RouteSettings(name: PostScreen.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: PostScreen(
              authorUID: args.authorUID,
              text: args.text,
              title: args.title
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child){
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      );

    case ProfileScreen.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: ProfileScreen.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: ProfileScreen(),
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child){
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      );

    case PostCreationScreen.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: PostCreationScreen.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: PostCreationScreen(),
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child){
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      );

    case GuestPostScreen.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: GuestPostScreen.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: GuestPostScreen(),
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child){
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      );

  }

  return null;
}