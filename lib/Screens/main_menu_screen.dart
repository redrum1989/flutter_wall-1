import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_wall/Model/PostScreenArguments.dart';
import 'package:flutter_wall/Model/StudentData.dart';
import 'package:flutter_wall/Screens/post_screen.dart';
import 'package:flutter_wall/Screens/profile_screen.dart';
import 'package:flutter_wall/Services/AuthenticationService.dart';
import 'package:flutter_wall/Services/PostsGetter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_wall/Model/Post.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({ Key key }) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  User userInfo;

  @override
  Widget build(BuildContext context) {
    userInfo = context.watch<User>();
    if(userInfo.isAnonymous){
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Guest Mode"),
                ElevatedButton(
                  onPressed: (){
                    context.read<AuthenticationService>().signOut().then((String msg){
                      Phoenix.rebirth(context);
                    });
                  },
                  child: Text("Logout")
                ),
              ],
            ),
          ),
        ),
      );
    } else if (userInfo != null) {
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
                      onPressed: (){
                        Navigator.of(context).pushNamed(ProfileScreen.routeName);
                      },
                      child: Text("Profile")
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      );
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
  const PostBanner({ Key key }) : super(key: key);

  @override
  _PostBannerState createState() => _PostBannerState();
}

class _PostBannerState extends State<PostBanner> {

  Random rng = new Random();

  List<Color> colors = [Colors.red[200],
                        Colors.blue[200],
                        Colors.amber[600],
                        Colors.pink[200],
                        ];

  @override
  Widget build(BuildContext context) {
    List<Post> posts = context.watch<List<Post>>();
    User userData = context.watch<User>();

    if((posts  == null)||(userData == null)){
      return Center(child: CircularProgressIndicator());
    } else {
      return Container(
        child: GridView.builder(
          padding: EdgeInsets.all(12),
          itemCount: posts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
          ), 
          itemBuilder: (context, index){
            return InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(PostScreen.routeName, 
                  arguments: PostScreenArguments(
                    authorUID: posts[index].authorUID,
                    text: posts[index].text,
                    title: posts[index].title
                  ),
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
                        Text(posts[index].title),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("Permission").doc(posts[index].authorUID).snapshots(),
                          builder: (context, snapshot){
                            if((snapshot == null)|| (snapshot.data==null)){
                              return Center(child: CircularProgressIndicator());
                            } else {
                              //Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
                              return Column(
                                children: [
                                  StreamBuilder(
                                    stream: (snapshot.data["permission"] == "Student") ? 
                                      FirebaseFirestore.instance.collection("Students Info").doc(posts[index].authorUID).snapshots() : 
                                      FirebaseFirestore.instance.collection("Alumni Info").doc(posts[index].authorUID).snapshots(),
                                    builder: (context, secondSnapshot){
                                      if((secondSnapshot == null)||(secondSnapshot.data==null)){
                                        return Center(child: CircularProgressIndicator());
                                      } else {
                                        return Text((secondSnapshot!=null) ? secondSnapshot.data["name"] : "");
                                      }
                                    }
                                  ),
                                  Text((snapshot != null) ? snapshot.data["permission"] : ""),
                                ],
                              );
                            }
                          }
                        ),
                      ],
                    ),
                ),
              ),
            );
          }
        ),
      );
    }
  }
}