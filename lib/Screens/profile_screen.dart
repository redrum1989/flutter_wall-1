import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wall/Screens/initial_screen.dart';
import 'package:flutter_wall/Services/AuthenticationService.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final uid;
  final description;

  const ProfileScreen({Key key, this.uid, this.description}) : super(key: key);

  static const routeName = "/profile";

  @override
  _ProfileScreenState createState() =>
      _ProfileScreenState(uid: this.uid, description: this.description);
}

class _ProfileScreenState extends State<ProfileScreen> {
  String uid;
  String description;

  TextEditingController _aboutmeTextController = new TextEditingController();
  _ProfileScreenState({this.uid, this.description});

  @override
  void initState() {
    _aboutmeTextController.text = description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    if (user == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          
          iconTheme: IconThemeData(color: Colors.black),
          
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Text(
                      'PROFILE',
                      style: TextStyle(
                        fontFamily: 'mont',
                        fontSize: 60,
                        fontWeight: FontWeight.w900,
                        color: Colors.amber[900]
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                SafeArea(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Permission")
                          .doc(user.uid)
                          .snapshots(),
                      builder: (context, snapshotPermission) {
                        if ((snapshotPermission.data == null) ||
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
                              return Stack(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width / 2.75,
                                              height:
                                                  MediaQuery.of(context).size.width / 2.75,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 4,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(20),
                                                child: Image.asset("assets/img/dp.jpg", scale: 0.7,),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            
                                            child: Column(
                                             
                                              children: [
                                                (snapshotPermission.data["permission"] ==
                                                        "Student")
                                                    ? Padding(
                                                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                      child: Align(alignment: Alignment.centerLeft,
                                                        child: Text(
                                                            "NAME:  " +"\n"+ "  "+
                                                                snapshot.data["name"] +
                                                                "\n" +
                                                                "From: " + "\n" + "  "+
                                                                snapshot.data["college"] +
                                                                "\n" +"  "+
                                                                snapshot.data["currentYear"] + " student",
                                                                
                                                            style: TextStyle(
                                                              
                                                                fontFamily: 'mont',
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                      ),
                                                    )
                                                    : Align(alignment: Alignment.bottomLeft,
                                                      child: Container(
                                                        constraints: BoxConstraints(maxWidth: 450),
                                                        child: Flexible(
                                                          child: Text(
                                                              "Name:   " + "\n" +
                                                                  snapshot.data["name"] +
                                                                  "\n" +
                                                                  "College:  " + "\n" +
                                                                  snapshot.data["college"] +
                                                                  "\n" +
                                                                  "Current Work:  " +
                                                                  snapshot.data["currentWork"] +
                                                                  "\n" +
                                                                  "Year Started:  " +
                                                                  snapshot.data["yearStarted"] +
                                                                  "\n" +
                                                                  "Year Graduated:  " +
                                                                  snapshot.data["yearGraduated"],
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                        ),
                                                      ),
                                                    ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      elevation: MaterialStateProperty.all(0),
                                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(22))),
                                                      padding: MaterialStateProperty.all(
                                                          EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                                                      backgroundColor:
                                                          MaterialStateProperty.all(Color(0xff0b5c5d))),
                                                      onPressed: () {
                                                        context
                                                            .read<AuthenticationService>()
                                                            .signOut();
                                                        Navigator.of(context).popUntil(
                                                            ModalRoute.withName(
                                                                InitialScreen.routeName));
                                                      },
                                                      child: Text("LOGOUT",
                                                      style: TextStyle(
                                                        fontFamily: 'mont'
                                                      ),)),
                                                ),
                                                
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(padding: EdgeInsets.fromLTRB(0, 70, 0, 0)),
                                          SizedBox(width: 60),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "ABOUT ME",
                                                style: TextStyle(
                                                    color: Colors.teal[800],
                                                    fontFamily: 'mont',
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 30,
                                                    height: 1),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                            child: TextField(
                                              
                                              keyboardType: TextInputType.text,
                                              maxLines: 3,
                                              decoration: InputDecoration(
                                                  hintText: "Introduce yourself!",
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
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                          elevation: MaterialStateProperty.all(0),
                                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(22))),
                                                          padding: MaterialStateProperty.all(
                                                              EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                                                          backgroundColor:
                                                              MaterialStateProperty.all(Color(0xff0b5c5d))),
                                                onPressed: () {
                                                  (snapshotPermission.data["permission"] ==
                                                          "Student")
                                                      ? FirebaseFirestore.instance
                                                          .collection("Students Info")
                                                          .doc(uid)
                                                          .set({
                                                          'description':
                                                              _aboutmeTextController.text
                                                        }, SetOptions(merge: true))
                                                      : FirebaseFirestore.instance
                                                          .collection("Alumni Info")
                                                          .doc(user.uid)
                                                          .set({
                                                          'description':
                                                              _aboutmeTextController.text
                                                        }, SetOptions(merge: true));
                                                },
                                                child: Text("SAVE",
                                                style: TextStyle(
                                                  fontSize: 15
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            });
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
