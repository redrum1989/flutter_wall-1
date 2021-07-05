import 'package:flutter/material.dart';
import 'package:flutter_wall/Model/StudentData.dart';
import 'package:flutter_wall/Screens/initial_screen.dart';
import 'package:flutter_wall/Services/Database.dart';

class StudentRegisterScreen extends StatefulWidget {
  const StudentRegisterScreen({ Key key }) : super(key: key);

  static const routeName = "/student_register";

  @override
  _StudentRegisterScreenState createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {

  TextEditingController _emailTextController = new TextEditingController();
  TextEditingController _pwTextController = new TextEditingController();
  TextEditingController _collegeTextController = new TextEditingController();
  TextEditingController _currentYearTextController = new TextEditingController();
  TextEditingController _nameTextController = new TextEditingController();
  TextEditingController _genderTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
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
                Center(child: Text("Current Year")),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 30),
                  child: TextFormField(
                    controller: _currentYearTextController,
                  ),
                ),
                Center(child: Text("Name")),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 30),
                  child: TextFormField(
                    controller: _nameTextController,
                  ),
                ),
                Center(child: Text("Gender")),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 30),
                  child: TextFormField(
                    controller: _genderTextController,
                  ),
                ),
                SizedBox(height: 50),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed:() async {
                        StudentData user = new StudentData(
                          email: _emailTextController.text,
                          password: _pwTextController.text,
                          college: _collegeTextController.text,
                          currentYear: _currentYearTextController.text,
                          name: _nameTextController.text,
                        );
                        await Database().registerStudentData(context, user);
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
      ),
    );
  }
}