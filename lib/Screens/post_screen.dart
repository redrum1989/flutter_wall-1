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
              title: Text(title, style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Stack(
              children: [
                // Put background here.
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    image: DecorationImage(
                      image: AssetImage("assets/img/background.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SafeArea(
                  child: ListView(
                    children: [
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
                                          return Text(
                                              secondSnapshot.data["name"]);
                                        }
                                      }),
                                  Text((snapshot != null)
                                      ? snapshot.data["permission"]
                                      : ""),
                                ],
                              );
                            }
                          }),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(title),
                          Text(college),
                          Text(text),
                        ],
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
