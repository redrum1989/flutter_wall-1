import 'package:flutter/material.dart';
import 'package:flutter_wall/Screens/alumni_register_screen.dart';
import 'package:flutter_wall/Screens/student_register_screen.dart';

class ChooseScreen extends StatefulWidget {
  const ChooseScreen({ Key key }) : super(key: key);
  
  static const routeName = "/choose";

  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Are you a: "
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(StudentRegisterScreen.routeName);
                },
                child: Text("Student")
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(AlumniRegisterScreen.routeName);
                },
                child: Text("Alumni")
              ),
            ],
          ),
        ),
      ),
    );
  }
}