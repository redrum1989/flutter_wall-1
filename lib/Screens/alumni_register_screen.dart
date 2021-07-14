import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wall/Model/AlumniData.dart';
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
//main
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                Picture(),
                Welcome(),
                Alumni(),
                Backicon()
              ]),
            Email(),
            Emailtext(emailTextController: _emailTextController),
            Password(),
            Passwordtext(pwTextController: _pwTextController),
            College(),
            Collegetext(collegeTextController: _collegeTextController),
            Year(),
            Yeartext(yearStartedTextController: _yearStartedTextController),
            Graduate(),
            Graduatedtext(yearGraduatedTextController: _yearGraduatedTextController),
            Name(),
            Nametext(nameTextController: _nameTextController),
            Work(),
            Worktext(currentWorkTextController: _currentWorkTextController),
            RegisterButton(emailTextController: _emailTextController, pwTextController: _pwTextController, nameTextController: _nameTextController, collegeTextController: _collegeTextController, yearStartedTextController: _yearStartedTextController, yearGraduatedTextController: _yearGraduatedTextController, currentWorkTextController: _currentWorkTextController),
          ],
        ),
      ),
    );
  }
}

class Backicon extends StatelessWidget {
  const Backicon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
      child: IconButton(
        color: Colors.white,
        onPressed: (){Navigator.of(context).pop();}, 
        icon: Icon(Icons.arrow_back)),
    );
  }
}

class Picture extends StatelessWidget {
  const Picture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
        child: Image(image: AssetImage('assets/img/graduate.jpg',))
      ),
    );
  }
}
//classes here
class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key key,
    @required TextEditingController emailTextController,
    @required TextEditingController pwTextController,
    @required TextEditingController nameTextController,
    @required TextEditingController collegeTextController,
    @required TextEditingController yearStartedTextController,
    @required TextEditingController yearGraduatedTextController,
    @required TextEditingController currentWorkTextController,
  }) : _emailTextController = emailTextController, _pwTextController = pwTextController, _nameTextController = nameTextController, _collegeTextController = collegeTextController, _yearStartedTextController = yearStartedTextController, _yearGraduatedTextController = yearGraduatedTextController, _currentWorkTextController = currentWorkTextController, super(key: key);

  final TextEditingController _emailTextController;
  final TextEditingController _pwTextController;
  final TextEditingController _nameTextController;
  final TextEditingController _collegeTextController;
  final TextEditingController _yearStartedTextController;
  final TextEditingController _yearGraduatedTextController;
  final TextEditingController _currentWorkTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Align(alignment: Alignment.centerRight,
        child: ButtonBar(
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff0b5c5d)),
                shape: MaterialStateProperty.all(
                       RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))))),
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
          ],
        ),
      ),
    );
  }
}

class Alumni extends StatelessWidget {
  const Alumni({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(30, 310, 0, 0),
    child: Text('ALUMNI',
    style: TextStyle(
      fontFamily: 'mont',
      fontSize: 60,
      fontWeight: FontWeight.w900
    ),),);
  }
}

class Welcome extends StatelessWidget {
  const Welcome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(47, 285, 0, 0),
      child: Text('WELCOME,',
      style: TextStyle(
        fontFamily: 'mont',
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.w900),
      ),
    );
  }
}

class Worktext extends StatelessWidget {
  const Worktext({
    Key key,
    @required TextEditingController currentWorkTextController,
  }) : _currentWorkTextController = currentWorkTextController, super(key: key);

  final TextEditingController _currentWorkTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: TextFormField(
        decoration: InputDecoration(
        filled: true,
        focusColor: Colors.grey[800],
        fillColor: Colors.yellow[600],
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.yellow[600],
          width: 2))),
        controller: _currentWorkTextController,
      ),
    );
  }
}

class Work extends StatelessWidget {
  const Work({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Text("CurrentWork",
      style: TextStyle(
        fontFamily: 'mont',
        fontWeight: FontWeight.w900
      )),
    );
  }
}

class Nametext extends StatelessWidget {
  const Nametext({
    Key key,
    @required TextEditingController nameTextController,
  }) : _nameTextController = nameTextController, super(key: key);

  final TextEditingController _nameTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: TextFormField(
        inputFormatters: [LengthLimitingTextInputFormatter(28)],
        decoration: InputDecoration(
        filled: true,
        focusColor: Colors.grey[800],
        fillColor: Colors.amber[200],
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.amber[200],
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
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Text("Name",
      style: TextStyle(
        fontFamily: 'mont',
        fontWeight: FontWeight.w900
      )),
    );
  }
}

class Graduatedtext extends StatelessWidget {
  const Graduatedtext({
    Key key,
    @required TextEditingController yearGraduatedTextController,
  }) : _yearGraduatedTextController = yearGraduatedTextController, super(key: key);

  final TextEditingController _yearGraduatedTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: TextFormField(
        decoration: InputDecoration(
        filled: true,
        focusColor: Colors.grey[800],
        fillColor: Colors.yellow[600],
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.yellow[600],
          width: 2))),
        controller: _yearGraduatedTextController,
      ),
    );
  }
}

class Graduate extends StatelessWidget {
  const Graduate({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Text("Year Graduated",
      style: TextStyle(
        fontFamily: 'mont',
        fontWeight: FontWeight.w900
      )),
    );
  }
}

class Yeartext extends StatelessWidget {
  const Yeartext({
    Key key,
    @required TextEditingController yearStartedTextController,
  }) : _yearStartedTextController = yearStartedTextController, super(key: key);

  final TextEditingController _yearStartedTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: TextFormField(
        decoration: InputDecoration(
        filled: true,
        focusColor: Colors.grey[800],
        fillColor: Colors.amber[200],
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.amber[200],
          width: 2))),
        controller: _yearStartedTextController,
      ),
    );
  }
}

class Year extends StatelessWidget {
  const Year({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Text("Year Started",
      style: TextStyle(
        fontFamily: 'mont',
        fontWeight: FontWeight.w900
      )),
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
        focusColor: Colors.grey[800],
        fillColor: Colors.yellow[600],
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.yellow[600],
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
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Text("College",
      style: TextStyle(
        fontFamily: 'mont',
        fontWeight: FontWeight.w900
      )),
    );
  }
}

class Passwordtext extends StatelessWidget {
  const Passwordtext({
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
        focusColor: Colors.grey[800],
        fillColor: Colors.amber[200],
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.amber[200],
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
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Container(
        height: 15,
        child: Text("Password",
        style: TextStyle(
          fontFamily: 'mont',
          fontWeight: FontWeight.w900
        )),
      ),
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
        focusColor: Colors.grey[800],
        fillColor: Colors.yellow[600],
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.yellow[600],
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
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Container(
        height: 15,
        child: Text("Email",
        style: TextStyle(
          fontFamily: 'mont',
          fontWeight: FontWeight.w900
        )),
      ),
    );
  }
}