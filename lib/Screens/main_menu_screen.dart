import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_wall/Model/PostScreenArguments.dart';
import 'package:flutter_wall/Model/ProfileScreenArguments.dart';
import 'package:flutter_wall/Model/StudentData.dart';
import 'package:flutter_wall/Screens/guestpost_screen.dart';
import 'package:flutter_wall/Screens/post_screen.dart';
import 'package:flutter_wall/Screens/postcreation_screen.dart';
import 'package:flutter_wall/Screens/profile_screen.dart';
import 'package:flutter_wall/Services/AuthenticationService.dart';
import 'package:flutter_wall/Services/PostsGetter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_wall/Model/Post.dart';
import 'package:flutter_wall/Services/RouteGenerator.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key key}) : super(key: key);

  static const routeName = "/mainmenu";

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  User userInfo;

  @override
  Widget build(BuildContext context) {
    userInfo = context.watch<User>();
    if (userInfo.isAnonymous) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Guest Mode"),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(GuestPostScreen.routeName);
                    },
                    child: Text('proceed'))
              ],
            ),
          ),
        ),
      );
    } else if (userInfo != null) {
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Permission')
              .doc(userInfo.uid)
              .snapshots(),
          builder: (context, permission) {
            if ((permission == null) || (permission.data == null)){
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return StreamBuilder(
                stream: (permission.data["permission"] == "Student")
                    ? FirebaseFirestore.instance
                        .collection("Students Info")
                        .doc(userInfo.uid)
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection("Alumni Info")
                        .doc(userInfo.uid)
                        .snapshots(),
                builder: (context, snapshot) {
                  if ((snapshot == null) || (snapshot.data == null)){
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } 
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
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                                      child: IconButton(onPressed: (){
                                      Navigator.of(context).pushNamed(
                                          PostCreationScreen.routeName);
                                      },
                                      color: Colors.orange[900],
                                      icon: Icon(Icons.post_add,
                                      size: 45,)),
                                    ),
                                    Text('TESTIFY',
                                    style: TextStyle(
                                      fontFamily: 'mont',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700
                                    ),)
                                  ],
                                ),
                                SizedBox(width: 120),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
                                      child: IconButton(onPressed: (){
                                      Navigator.of(context).pushNamed(
                                          ProfileScreen.routeName,
                                          arguments: ProfileScreenArguments(
                                              description: snapshot
                                                      .data["description"] ??
                                                  '',
                                              uid: userInfo.uid));
                                    },
                                      color: Colors.teal[800],
                                      icon: Icon(Icons.account_circle_rounded,
                                      size: 45,)),
                                    ),
                                    Text('PROFILE',
                                    style: TextStyle(
                                      fontFamily: 'mont',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700
                                    ),)
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          });
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
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
    Colors.yellow[300],
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
                          
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    children: [
                                      Text(posts[index].title.toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: 'mont',
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20
                                      ),),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(posts[index].college.toUpperCase(),
                                          style: TextStyle(
                                            fontFamily: 'mont',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15
                                          ),)),
                                      )
                                    ],
                                  ),
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
                                                  return Padding(
                                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                    child: Align(alignment: Alignment.topLeft,
                                                      child: Text(
                                                          (secondSnapshot != null)
                                                              ? "by: " + secondSnapshot.data["name"]
                                                              : "",
                                                              style: TextStyle(
                                                                fontFamily: 'mont'
                                                              ),),
                                                    ),
                                                  );
                                                }
                                              }),
                                          Align(alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                              child: Text((snapshot != null)
                                                  ? snapshot.data["permission"]
                                                  : "",
                                                  style: TextStyle(
                                                    fontStyle: FontStyle.italic
                                                  ),)
                                                
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
          Container(child: Starttext()),
          Readingtext(), 
        ],
      );
    }
  }
}

class Readingtext extends StatelessWidget {
  const Readingtext({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        ));
  }
}

class Starttext extends StatelessWidget {
  const Starttext({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 600,
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 4, 50),
          child: Text('START',
          style: TextStyle(
            fontFamily: 'mont',
            fontSize: 30
          ),),
        ));
  }
}
