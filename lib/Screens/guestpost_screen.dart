import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_wall/Model/PostScreenArguments.dart';
import 'package:flutter_wall/Model/StudentData.dart';
import 'package:flutter_wall/Screens/post_screen.dart';
import 'package:flutter_wall/Screens/postcreation_screen.dart';
import 'package:flutter_wall/Screens/profile_screen.dart';
import 'package:flutter_wall/Services/AuthenticationService.dart';
import 'package:flutter_wall/Services/PostsGetter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_wall/Model/Post.dart';
import 'package:flutter_wall/Screens/guestpost_screen.dart';
import 'initial_screen.dart';

class GuestPostScreen extends StatefulWidget {
  const GuestPostScreen({Key key}) : super(key: key);

  static const routeName = "/guestpost";
  @override
  _GuestPostScreenState createState() => _GuestPostScreenState();
}

class _GuestPostScreenState extends State<GuestPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: StreamProvider<List<Post>>.value(
                  value: PostsGetter().postData,
                  initialData: [],
                  child: PostBanner(),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
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
                        context.read<AuthenticationService>().signOut();
                        Navigator.of(context).popUntil(
                            ModalRoute.withName(InitialScreen.routeName));
                      },
                      child: Text("LOGOUT")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostBanner extends StatefulWidget {
  const PostBanner({Key key}) : super(key: key);

  @override
  _PostBannerState createState() => _PostBannerState();
}

class _PostBannerState extends State<PostBanner> {
  Random rng = new Random();

  List<Color> colors = [
    Colors.yellow[800],
    Colors.teal[700],
    Colors.amber[800],
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    List<Post> posts = context.watch<List<Post>>();
    User userData = context.watch<User>();

    if ((posts == null) || (userData == null)) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Stack(
        children: [
          Container(
            child: GridView.builder(
                padding: EdgeInsets.fromLTRB(20, 110, 20, 20),
                itemCount: posts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          PostScreen.routeName,
                          arguments: PostScreenArguments(
                              authorUID: posts[index].authorUID,
                              text: posts[index].text,
                              title: posts[index].title,
                              college: posts[index].college),
                        );
                      },
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: colors[rng.nextInt(colors.length)],
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Text(posts[index].title.toUpperCase(),
                                        style: TextStyle(
                                          fontFamily: 'mont',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20
                                        ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 6, 0, 0),
                                child: Align(alignment: Alignment.centerLeft,
                                  child: Text(posts[index].college.toUpperCase(),
                                              style: TextStyle(
                                                fontFamily: 'mont',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15
                                              ),),
                                ),
                              ),
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("Permission")
                                      .doc(posts[index].authorUID)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if ((snapshot == null) ||
                                        (snapshot.data == null)) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      //Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
                                      return Column(
                                        children: [
                                          StreamBuilder(
                                              stream: (snapshot
                                                          .data["permission"] ==
                                                      "Student")
                                                  ? FirebaseFirestore.instance
                                                      .collection(
                                                          "Students Info")
                                                      .doc(posts[index]
                                                          .authorUID)
                                                      .snapshots()
                                                  : FirebaseFirestore.instance
                                                      .collection("Alumni Info")
                                                      .doc(posts[index]
                                                          .authorUID)
                                                      .snapshots(),
                                              builder:
                                                  (context, secondSnapshot) {
                                                if ((secondSnapshot == null) ||
                                                    (secondSnapshot.data ==
                                                        null)) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else {
                                                  return 
                                                  
                                                  Align(alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                      child: Text(
                                                          (secondSnapshot != null)
                                                              ? "by: " + secondSnapshot
                                                                  .data["name"]
                                                              : "", style: TextStyle(
                                                                    fontFamily: 'mont'
                                                                  ),),
                                                    ),
                                                  );
                                                }
                                              }),
                                          Align(alignment: Alignment.centerLeft,
                                            child: Padding(
                                             padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                              child: Text((snapshot != null)
                                                  ? snapshot.data["permission"]
                                                  : "",
                                                      style: TextStyle(
                                                        fontStyle: FontStyle.italic
                                                      ),),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
        width: 600,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 40, 4, 0),
          child: Text('READING',
          style: TextStyle(
            fontFamily: 'mont',
            fontSize: 50,
            fontWeight: FontWeight.w900,
            color: Colors.teal[900]
          ),),
        )),
        Container(
        width: 600,
        
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 4, 50),
          child: Text('START',
          style: TextStyle(
            fontFamily: 'mont',
            fontSize: 30
          ),),
        )),
        ],
      );
    }
  }
}
