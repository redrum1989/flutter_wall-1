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
      extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Bg(),
                  Welcome(),
                  Student(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                    child: IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: Icon(
                      Icons.arrow_back)),
                  )
                ],
              ),
              SizedBox(height:5),
              Email(),
              Emailtext(emailTextController: _emailTextController),
              Password(),
              PasswordText(pwTextController: _pwTextController),
              College(),
              Collegetext(collegeTextController: _collegeTextController),
              Currentyear(),
              CurrentyearText(currentYearTextController: _currentYearTextController),
              Name(),
              NameText(nameTextController: _nameTextController),
              Gender(),
              Gendertext(genderTextController: _genderTextController),
              SizedBox(height: 10),
             Pindutan(emailTextController: _emailTextController, pwTextController: _pwTextController, collegeTextController: _collegeTextController, currentYearTextController: _currentYearTextController, nameTextController: _nameTextController),
        ]),
    ]));
  }
}

class Pindutan extends StatelessWidget {
  const Pindutan({
    Key key,
    @required TextEditingController emailTextController,
    @required TextEditingController pwTextController,
    @required TextEditingController collegeTextController,
    @required TextEditingController currentYearTextController,
    @required TextEditingController nameTextController,
  }) : _emailTextController = emailTextController, _pwTextController = pwTextController, _collegeTextController = collegeTextController, _currentYearTextController = currentYearTextController, _nameTextController = nameTextController, super(key: key);

  final TextEditingController _emailTextController;
  final TextEditingController _pwTextController;
  final TextEditingController _collegeTextController;
  final TextEditingController _currentYearTextController;
  final TextEditingController _nameTextController;

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
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
    );
  }
}

class Gendertext extends StatelessWidget {
  const Gendertext({
    Key key,
    @required TextEditingController genderTextController,
  }) : _genderTextController = genderTextController, super(key: key);

  final TextEditingController _genderTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          width: 2))),
        controller: _genderTextController,
      ),
    );
  }
}

class Gender extends StatelessWidget {
  const Gender({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
        child: Text("Gender",
        style: TextStyle(
        fontFamily: 'mont',
        fontWeight: FontWeight.w900)),
      )
    );
  }
}

class NameText extends StatelessWidget {
  const NameText({
    Key key,
    @required TextEditingController nameTextController,
  }) : _nameTextController = nameTextController, super(key: key);

  final TextEditingController _nameTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          width: 2))),
        controller: _nameTextController,
      ),
    );
  }
}

class Name extends StatelessWidget {
  const Name({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
        child: Text("Name",
        style: TextStyle(
        fontFamily: 'mont',
        fontWeight: FontWeight.w900)),
      )
    );
  }
}

class CurrentyearText extends StatelessWidget {
  const CurrentyearText({
    Key key,
    @required TextEditingController currentYearTextController,
  }) : _currentYearTextController = currentYearTextController, super(key: key);

  final TextEditingController _currentYearTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              width: 2))),
          controller: _currentYearTextController,
      ),
    );
  }
}

class Currentyear extends StatelessWidget {
  const Currentyear({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
        child: Text("Current Year",
        style: TextStyle(
        fontFamily: 'mont',
        fontWeight: FontWeight.w900)),
      )
    );
  }
}

class Collegetext extends StatelessWidget {
  const Collegetext({
    Key key,
    @required TextEditingController collegeTextController,
  }) : _collegeTextController = collegeTextController, super(key: key);

  final TextEditingController _collegeTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          width: 2))),
        controller: _collegeTextController,
      ),
    );
  }
}

class College extends StatelessWidget {
  const College({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
        child: Text("College",
        style: TextStyle(
        fontFamily: 'mont',
        fontWeight: FontWeight.w900)),
    ));
  }
}

class PasswordText extends StatelessWidget {
  const PasswordText({
    Key key,
    @required TextEditingController pwTextController,
  }) : _pwTextController = pwTextController, super(key: key);

  final TextEditingController _pwTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          width: 2))),
        controller: _pwTextController,
        obscureText: true,
      ),
    );
  }
}

class Password extends StatelessWidget {
  const Password({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
        child: Text("Password",
        style: TextStyle(
        fontFamily: 'mont',
        fontWeight: FontWeight.w900))
      )
    );
  }
}

class Emailtext extends StatelessWidget {
  const Emailtext({
    Key key,
    @required TextEditingController emailTextController,
  }) : _emailTextController = emailTextController, super(key: key);

  final TextEditingController _emailTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          width: 2))),
        controller: _emailTextController,
      ),
    );
  }
}

class Email extends StatelessWidget {
  const Email({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
        child: Text("Email",
        style: TextStyle(
        fontFamily: 'mont',
        fontWeight: FontWeight.w900))
      )
    );
  }
}

class Student extends StatelessWidget {
  const Student({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 310, 0, 0),
      child: Text('STUDENT',
      style: TextStyle(
        fontFamily: 'mont',
          fontWeight: FontWeight.w900,
          fontSize: 60,
      ),),
    );
  }
}

class Welcome extends StatelessWidget {
  const Welcome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 280, 0, 0),
      child: Text('WELCOME,',
      style: TextStyle(
        fontFamily: 'mont',
        fontWeight: FontWeight.w900,
        fontSize: 30,
        color: Colors.white
      ),
      ),
    );
  }
}

class Bg extends StatelessWidget {
  const Bg({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
        child: Image(image: AssetImage('assets/img/student bg.jpg',))),
    );
  }
}