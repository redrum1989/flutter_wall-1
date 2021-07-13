import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wall/Screens/alumni_register_screen.dart';
import 'package:flutter_wall/Model/Post.dart';

class PostScreen extends StatefulWidget {
  final authorUID;
  final title;
  final text;
  final college;

  PostScreen({Key key, this.title, this.authorUID, this.text, this.college})
      : super(key: key);

  static const routeName = "/post_screen";

  @override
  _PostScreenState createState() => _PostScreenState(
      authorUID: authorUID, text: text, title: title, college: college);
}

class _PostScreenState extends State<PostScreen> {
  String authorUID;
  String title;
  String text;
  String college;

  _PostScreenState({this.authorUID, this.text, this.title, this.college});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black),
             
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Stack(
              children: [
                // Put background here.
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/contentbg.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SafeArea(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(title,
                              style: TextStyle(
                                height: 0.9,
                                fontFamily: 'mont',
                                fontWeight: FontWeight.w900,
                                fontSize: 50
                              ),),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Align(alignment: Alignment.topLeft,
                              child: Text("FROM: " + college.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'mont',
                                fontSize: 20
                              ),)),
                          ),
                          
                        ],
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Permission")
                              .doc(authorUID)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if ((snapshot == null) || (snapshot.data == null)) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StreamBuilder(
                                      stream: (snapshot.data["permission"] ==
                                              "Student")
                                          ? FirebaseFirestore.instance
                                              .collection("Students Info")
                                              .doc(authorUID)
                                              .snapshots()
                                          : FirebaseFirestore.instance
                                              .collection("Alumni Info")
                                              .doc(authorUID)
                                              .snapshots(),
                                      builder: (context, secondSnapshot) {
                                        if ((secondSnapshot == null) ||
                                            (secondSnapshot.data == null)) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else {
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                            child: Align(alignment: Alignment.topLeft,
                                              child: Text("by: " +
                                                  secondSnapshot.data["name"],
                                                  style: TextStyle(
                                                    fontFamily: 'mont',
                                                    fontSize: 20
                                                  ),),
                                            ),
                                          );
                                        }
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Align(alignment: Alignment.topLeft,
                                      child: Text((snapshot != null)
                                          ? snapshot.data["permission"]
                                          : "",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'mont',
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.italic
                                          ),),
                                    ),
                                  ),
                                ],
                              );
                            }
                          }),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text("        " + text,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          
                          fontFamily: 'mont',
                          fontSize: 15
                        ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
