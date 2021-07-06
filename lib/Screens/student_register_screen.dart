import 'dart:ffi';

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
            Column(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
                    child: Image(image: AssetImage('assets/img/student bg.jpg',))),
                )
              ],
            ),
            AppBar(
              iconTheme: IconThemeData(
              color: Colors.black),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            ListView(
              children: [
                SizedBox(height: 250,),
                Container(
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text('WELCOME,',
                    style: TextStyle(
                      fontFamily: 'mont',
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Colors.white
                    ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text('STUDENT',
                    style: TextStyle(
                      fontFamily: 'mont',
                        fontWeight: FontWeight.w900,
                        fontSize: 60,
                    ),),
                  ),
                ),
                SizedBox(height:5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Text("Email",
                    style: TextStyle(
                    fontFamily: 'mont',
                    fontWeight: FontWeight.w900
                ),),
                  )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                    filled: true,
                    focusColor: Colors.grey[200],
                    fillColor: Colors.deepOrange[600],
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.deepOrange[600],
                      width: 2
                    )
                  )
                
                    ),
                    controller: _emailTextController,
                  ),
                ),


                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Text("Password",
                    style: TextStyle(
                    fontFamily: 'mont',
                    fontWeight: FontWeight.w900
                ),),
                  )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                    filled: true,
                    focusColor: Colors.grey[200],
                    fillColor: Colors.deepOrange[300],
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.deepOrange[300],
                      width: 2
                    )
                  )  
                    ),
                    controller: _pwTextController,
                    obscureText: true,
                  ),
                ),


                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Text("College",
                    style: TextStyle(
                    fontFamily: 'mont',
                    fontWeight: FontWeight.w900
                ),),
                  )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                    filled: true,
                    focusColor: Colors.grey[200],
                    fillColor: Colors.deepOrange[600],
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.deepOrange[600],
                      width: 2
                    )
                  )  
                ),
                    controller: _collegeTextController,
              ),
            ),


                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Text("Current Year",
                    style: TextStyle(
                    fontFamily: 'mont',
                    fontWeight: FontWeight.w900
                ),),
                  )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                    filled: true,
                    focusColor: Colors.grey[200],
                    fillColor: Colors.deepOrange[300],
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.deepOrange[300],
                      width: 2
                    )
                  )  
                ),
                    controller: _currentYearTextController,
              ),
            ),


                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Text("Name",
                    style: TextStyle(
                    fontFamily: 'mont',
                    fontWeight: FontWeight.w900
                ),),
                  )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                    filled: true,
                    focusColor: Colors.grey[800],
                    fillColor: Colors.deepOrange[600],
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.deepOrange[600],
                      width: 2
                    )
                  )  
                ),
                    controller: _nameTextController,
              ),
            ),

            
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Text("Gender",
                    style: TextStyle(
                    fontFamily: 'mont',
                    fontWeight: FontWeight.w900
                ),),
                  )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                    filled: true,
                    focusColor: Colors.grey[200],
                    fillColor: Colors.deepOrange[300],
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.deepOrange[300],
                      width: 2
                    )
                  )  
                ),
                    controller: _genderTextController,
              ),
            ),
                SizedBox(height: 10),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xff0b5c5d)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            )
                          )
                        ),
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
                        child: Text("REGISTER",
                        ),
                      ),
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