import 'package:flutter/material.dart';
import 'package:flutter_wall/Services/AuthenticationService.dart';
import 'package:provider/provider.dart';

import 'choose_screen.dart';
import 'initial_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  static const routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextController = new TextEditingController();
  TextEditingController _pwTextController = new TextEditingController();

  void _signInWithEmailAndPassword(BuildContext ctx) async {
    var _success = true;
    if ((_emailTextController.text.isEmpty) ||
        (_pwTextController.text.isEmpty)) {
      return showDialog(
          context: ctx,
          builder: (ctx) {
            return AlertDialog(
                content: Text("Please fill up the necessary fields."));
          });
    }

    await context
        .read<AuthenticationService>()
        .signIn(
            email: _emailTextController.text.trim(),
            password: _pwTextController.text.trim())
        .then((_) => {
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(InitialScreen.routeName))
            })
        .catchError((e) => {
              _success = false,
              showDialog(
                  context: ctx,
                  builder: (ctx) {
                    return AlertDialog(content: Text(e.message));
                  })
            });

    if (_success) {
      dynamic scaffold = ScaffoldMessenger.of(ctx);
      await scaffold.showSnackBar(
        SnackBar(
          content: const Text('Logged in'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 75,
            ),
            Container(
              child: Image.asset(
                "assets/img/LOGIN2.png",
                scale: 12,
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 3, vertical: 10)),
            Row(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: TextFormField(
                decoration: InputDecoration(
                    filled: true,
                    focusColor: Colors.grey[200],
                    fillColor: Colors.grey[300],
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: Colors.grey[300], width: 2))),
                controller: _emailTextController,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 50,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  focusColor: Colors.grey[200],
                  fillColor: Colors.grey[300],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey[300],
                      width: 2
                    )
                  )
                ),
                controller: _pwTextController,
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22))),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 105, vertical: 10)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xfffad000))),
                  onPressed: () {
                    _signInWithEmailAndPassword(context);
                  },
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22))),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff0b5c5d))),
                  onPressed: () {
                    Navigator.of(context).pushNamed(ChooseScreen.routeName);
                  },
                  child: Text(
                    "CREATE AN ACCOUNT",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
