import 'package:flutter/material.dart';
import 'package:flutter_wall/Screens/choose_screen.dart';
import 'package:flutter_wall/Screens/login_screen.dart';
import 'package:flutter_wall/Screens/student_register_screen.dart';
import 'package:flutter_wall/Services/AuthenticationService.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({ Key key }) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    child: Image.asset(
                      "assets/img/logo 2-02.png",
                    ),
                  ),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xfffe4f00)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                      ),
                    ),
                    onPressed:(){
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    child: Text("Login"),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xfffe4f00)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                      ),
                    ),
                    onPressed:(){
                      Navigator.of(context).pushNamed(ChooseScreen.routeName);
                    },
                    child: Text("Register"),
                  ),
                ],
              ),

              TextButton(
                onPressed:(){
                  context.read<AuthenticationService>().signInAnon();
                },
                child: Text(
                  "Continue as Guest",
                  style: TextStyle(
                    color: Color(0xfffe4f00),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
