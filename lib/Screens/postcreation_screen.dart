import 'package:flutter/material.dart';

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({ Key key }) : super(key: key);

  static const routeName = "/postcreation";

  @override
  _PostCreationScreenState createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(23, 70, 0, 0),
                  child: Text('TITLE',
                  style: TextStyle(
                    fontFamily: 'mont',
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    height: 1.5
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                    focusColor: Colors.grey[800],
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 3)))
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(23, 0, 0, 0),
                  child: Text('COLLEGE',
                  style: TextStyle(
                    fontFamily: 'mont',
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    height: 1.5
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                    focusColor: Colors.grey[800],
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 3)))
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(23, 20, 0, 0),
                  child: Text('WRITE HERE:',
                  style: TextStyle(
                    color: Colors.orange[800],
                    fontFamily: 'mont',
                    fontWeight: FontWeight.w900,
                    fontSize: 35,
                    height: 1.5
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 350),
                    focusColor: Colors.grey[800],
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 3)))
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(350, 10, 30, 0),
                  child: ElevatedButton(onPressed: (){}, child: Text(
                      'POST'
                    )),
                )
              ],
            ),
            Container(
              height: 70,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('START',
                      style: TextStyle(
                        color: Colors.yellow[600],
                        fontFamily: 'mont',
                        fontWeight: FontWeight.w900,
                        fontSize: 30,   
                        height: 0.5
                      ),),
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
        )
      ),
    );
  }
}