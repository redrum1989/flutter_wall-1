import 'package:flutter/material.dart';
import 'package:flutter_wall/Services/AuthenticationService.dart';
import 'package:provider/provider.dart';

import 'initial_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key key }) : super(key: key);

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
            return AlertDialog(content: Text("Please fill up the necessary fields."));
          });
    }

    await context
        .read<AuthenticationService>()
        .signIn(
            email: _emailTextController.text.trim(),
            password: _pwTextController.text.trim())
        .then((_) => {
          Navigator.of(context).popUntil(ModalRoute.withName(InitialScreen.routeName))
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
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50,0,0,0),
              child: Text("Email"),
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
            child: TextFormField(
              controller: _emailTextController,
              decoration: InputDecoration(
                fillColor: Colors.grey[400],
                filled: true,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50,50,0,0),
              child: Text("Password"),
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 50),
            child: TextFormField(
              controller: _pwTextController,
              obscureText: true,
              decoration: InputDecoration(
                fillColor: Colors.grey[400],
                filled: true,
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed:(){
                  _signInWithEmailAndPassword(context);
                },
                child: Text("Login"),
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
    );
  }
}