import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wall/Screens/initial_screen.dart';
import 'package:flutter_wall/Services/AuthenticationService.dart';
import 'package:provider/provider.dart';

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

  TextEditingController _aboutmeTextController = new TextEditingController();
  _ProfileScreenState({this.name, this.college, this.currentYear});

  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    if (user == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.75,
                                height:
                                    MediaQuery.of(context).size.width / 2.75,
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
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
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
                                                fontSize: 15,
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
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
                            SizedBox(width: 50),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "About me",
                                style: TextStyle(
                                    color: Colors.teal[800],
                                    fontFamily: 'mont',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    height: 1),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(50, 10, 50, 10),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                maxLines: 3,
                                decoration: InputDecoration(
                                    hintText: "Introduce",
                                    filled: true,
                                    focusColor: Colors.grey[200],
                                    fillColor: Colors.grey[300],
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300],
                                            width: 2))),
                                controller: _aboutmeTextController,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  });
            }),
      ),
    );
  }
}
