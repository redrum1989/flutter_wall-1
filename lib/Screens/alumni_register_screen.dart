import 'package:flutter/material.dart';
import 'package:flutter_wall/Model/AlumniData.dart';
import 'package:flutter_wall/Model/StudentData.dart';
import 'package:flutter_wall/Screens/initial_screen.dart';
import 'package:flutter_wall/Services/Database.dart';

class AlumniRegisterScreen extends StatefulWidget {
  const AlumniRegisterScreen({ Key key }) : super(key: key);

  static const routeName = "/alumni_register";

  @override
  _AlumniRegisterScreenState createState() => _AlumniRegisterScreenState();
}

class _AlumniRegisterScreenState extends State<AlumniRegisterScreen> {

  TextEditingController _emailTextController = new TextEditingController();
  TextEditingController _pwTextController = new TextEditingController();
  TextEditingController _nameTextController = new TextEditingController();
  TextEditingController _collegeTextController = new TextEditingController();
  TextEditingController _yearStartedTextController = new TextEditingController();
  TextEditingController _yearGraduatedTextController = new TextEditingController();
  TextEditingController _currentWorkTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: BoxDecoration(
              color: Colors.red[100],
            ),
          ),

          ListView(
            children: [
              SizedBox(height:50),
              Center(child: Text("Email")),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 30),
                child: TextFormField(
                  controller: _emailTextController,
                ),
              ),
              Center(child: Text("Password")),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 30),
                child: TextFormField(
                  controller: _pwTextController,
                  obscureText: true,
                ),
              ),
              Center(child: Text("College")),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 30),
                child: TextFormField(
                  controller: _collegeTextController,
                ),
              ),
              Center(child: Text("Year Started")),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 30),
                child: TextFormField(
                  controller: _yearStartedTextController,
                ),
              ),
              Center(child: Text("Year Graduated")),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 30),
                child: TextFormField(
                  controller: _yearGraduatedTextController,
                ),
              ),
              Center(child: Text("Name")),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 30),
                child: TextFormField(
                  controller: _nameTextController,
                ),
              ),
              Center(child: Text("CurrentWork")),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 30),
                child: TextFormField(
                  controller: _currentWorkTextController,
                ),
              ),
              SizedBox(height: 50),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed:() async {
                      AlumniData user = new AlumniData(
                        email: _emailTextController.text,
                        password: _pwTextController.text,
                        name: _nameTextController.text,
                        college: _collegeTextController.text,
                        yearStarted: _yearStartedTextController.text,
                        yearGraduated: _yearGraduatedTextController.text,
                        currentWork: _currentWorkTextController.text
                      );
                      await Database().registerAlumniData(context, user);
                      Navigator.of(context).popUntil(ModalRoute.withName(InitialScreen.routeName));
                    },
                    child: Text("Register"),
                  ),
                  ElevatedButton(
                    onPressed:(){
                      Navigator.of(context).pop();
                    },
                    child: Text("Back"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}