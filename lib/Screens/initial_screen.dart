import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_wall/Screens/start_screen.dart';
import 'package:provider/provider.dart';

import 'main_menu_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({ Key key }) : super(key: key);

  static const routeName = "/main";

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  User firebaseUser;

  @override
  Widget build(BuildContext context) {
    firebaseUser = context.watch<User>();
    if(firebaseUser != null){
      return MainMenu();
    } else {
      return StartScreen();
    }
  }
}