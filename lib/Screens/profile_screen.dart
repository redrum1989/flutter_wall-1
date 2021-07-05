<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
>>>>>>> 99e5773815019b2a8194a3f9da0600473ea58c05
import 'package:flutter/material.dart';
import 'package:flutter_wall/Screens/initial_screen.dart';
import 'package:flutter_wall/Services/AuthenticationService.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  final name;
  final college;
  final currentYear;

  const ProfileScreen({Key key, this.name, this.college, this.currentYear})
      : super(key: key);

  static const routeName = "/profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState(
      name: name, college: college, currentYear: currentYear);
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name;
  String college;
  String currentYear;

  _ProfileScreenState({this.name, this.college, this.currentYear});

  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    return Scaffold(
<<<<<<< HEAD
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Permission")
                .doc(user.uid)
                .snapshots(),
            builder: (context, snapshotPermission) {
              if ((snapshotPermission == null) ||
                  (snapshotPermission == null)) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return StreamBuilder(
                  stream: (snapshotPermission.data["permission"] == "Student")
                      ? FirebaseFirestore.instance
                          .collection("Students Info")
                          .doc(user.uid)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection("Alumni Info")
                          .doc(user.uid)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if ((snapshot == null) || (snapshot.data == null)) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.25,
                                height:
                                    MediaQuery.of(context).size.width / 2.25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset("assets/img/pikachu.jpg"),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (snapshotPermission.data["permission"] ==
                                        "Student")
                                    ? Text(
                                        "Name:  " +
                                            snapshot.data["name"] +
                                            "\n" +
                                            "College: " +
                                            snapshot.data["college"] +
                                            "\n" +
                                            "Year Level: " +
                                            snapshot.data["currentYear"] +
                                            "\n",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        "Name:   " +
                                            snapshot.data["name"] +
                                            "\n" +
                                            "College:  " +
                                            snapshot.data["college"] +
                                            "\n" +
                                            "Current Work:  " +
                                            snapshot.data["currentWork"] +
                                            "\n" +
                                            " Year Started:  " +
                                            snapshot.data["yearStarted"] +
                                            "\n" +
                                            "Year Graduated:  " +
                                            snapshot.data["yearGraduated"],
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<AuthenticationService>()
                                          .signOut();
                                      Navigator.of(context).popUntil(
                                          ModalRoute.withName(
                                              InitialScreen.routeName));
                                    },
                                    child: Text("Logout")),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  });
            }),
=======
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
>>>>>>> 99e5773815019b2a8194a3f9da0600473ea58c05
      ),
    );
  }
}
