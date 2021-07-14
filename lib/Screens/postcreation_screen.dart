import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wall/Model/Post.dart';
import 'package:flutter_wall/Screens/post_screen.dart';
import 'package:flutter_wall/Services/Database.dart';
import 'package:flutter_wall/Services/Database.dart';

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({Key key}) : super(key: key);

  static const routeName = "/postcreation";

  @override
  _PostCreationScreenState createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  TextEditingController _postcontentTextController =
      new TextEditingController();
  TextEditingController _postTitleTextController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Ttiel(),
                TextController(
                    postTitleTextController: _postTitleTextController),
                College(),
                Collegetext(),
                Writehere(),
                WiteHereText(
                  postContentTextController: _postcontentTextController,
                ),
                SizedBox(height: 30),
                Postbutton(
                  postTitleTextController: _postTitleTextController,
                  postContentTextController: _postcontentTextController,
                )
              ],
            ),
            Container(
              height: 70,
              color: Colors.white,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'START',
                      style: TextStyle(
                          color: Colors.yellow[600],
                          fontFamily: 'mont',
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          height: 0.5),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('TESTIFYING',
                            style: TextStyle(
                                color: Colors.teal[800],
                                fontFamily: 'mont',
                                fontWeight: FontWeight.w900,
                                fontSize: 50,
                                height: 1)))),
              ]),
            ),
          ],
        ),
      )),
    );
  }
}

class WiteHereText extends StatelessWidget {
  const WiteHereText({
    maxLines: 5,
    @required TextEditingController postContentTextController,
    Key key,
  })  : _postContentTextController = postContentTextController,
        super(key: key);

  final TextEditingController _postContentTextController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 350),
            focusColor: Colors.grey[800],
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.black, width: 3))),
        controller: _postContentTextController,
      ),
    );
  }
}

class Writehere extends StatelessWidget {
  const Writehere({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 20, 0, 0),
      child: Text('WRITE HERE:',
          style: TextStyle(
              color: Colors.orange[800],
              fontFamily: 'mont',
              fontWeight: FontWeight.w900,
              fontSize: 35,
              height: 1.5)),
    );
  }
}

class Collegetext extends StatelessWidget {
  const Collegetext({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
      child: TextFormField(
          decoration: InputDecoration(
              focusColor: Colors.grey[800],
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.black, width: 3)))),
    );
  }
}

class College extends StatelessWidget {
  const College({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 0, 0, 0),
      child: Text('COLLEGE',
          style: TextStyle(
              fontFamily: 'mont',
              fontWeight: FontWeight.w900,
              fontSize: 20,
              height: 1.5)),
    );
  }
}

class Ttiel extends StatelessWidget {
  const Ttiel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 70, 0, 0),
      child: Text('TITLE',
          style: TextStyle(
              fontFamily: 'mont',
              fontWeight: FontWeight.w900,
              fontSize: 20,
              height: 1.5)),
    );
  }
}

class TextController extends StatelessWidget {
  const TextController({
    Key key,
    @required TextEditingController postTitleTextController,
  })  : _postTitleTextController = postTitleTextController,
        super(key: key);

  final TextEditingController _postTitleTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
      child: TextFormField(
        decoration: InputDecoration(
            focusColor: Colors.grey[800],
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.black, width: 3))),
        controller: _postTitleTextController,
      ),
    );
  }
}

class Postbutton extends StatelessWidget {
  const Postbutton({
    Key key,
    @required TextEditingController postTitleTextController,
    @required TextEditingController postContentTextController,
  })  : _postTitleTextController = postTitleTextController,
        _postContentTextController = postContentTextController,
        super(key: key);

  final TextEditingController _postTitleTextController;
  final TextEditingController _postContentTextController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(350, 10, 30, 0),
      child: ElevatedButton(
          onPressed: () async {
            print(FirebaseAuth.instance.currentUser.uid);
            Post newpost = new Post(
              authorUID: FirebaseAuth.instance.currentUser.uid,
              title: _postTitleTextController.text,
              text: _postContentTextController.text,
            );
            await Database().registerPostData(context, newpost);
          },
          child: Text('POST')),
    );
  }
}
