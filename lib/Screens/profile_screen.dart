import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    User user = context.watch<User>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Profile",style: TextStyle(color: Colors.black)),
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black)
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Students Info").doc(user.uid).snapshots(),
          builder: (context, snapshot) {
            if((snapshot==null)||(snapshot.data==null)){
              return Center(child: CircularProgressIndicator(),);
            }
            return Column(
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
                          "Name: " + snapshot.data["name"] + "\n" +
                          "College: " + snapshot.data["college"] + "\n" +
                          "Year: " + snapshot.data["currentYear"] + "\n"
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

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: Text("About me"),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}