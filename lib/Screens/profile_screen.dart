import 'package:flutter/material.dart';
import 'package:flutter_wall/Services/AuthenticationService.dart';
import 'package:provider/provider.dart';

import 'initial_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key key }) : super(key: key);

  static const routeName = "/profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Row(
              children: [

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    // MediaQuery.of(context) stores the current information of the device
                    width: MediaQuery.of(context).size.width/2.25,
                    height: MediaQuery.of(context).size.width/2.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset("assets/img/profile_picture.jpg"),
                    ),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Name: " + "\n" +
                      "Section: " + "\n" +
                      "Year: " + "\n"
                    ),
                    ElevatedButton(
                      onPressed: (){
                        context.read<AuthenticationService>().signOut();
                        Navigator.of(context).popUntil(ModalRoute.withName(InitialScreen.routeName));
                      },
                      child: Text("Logout")
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