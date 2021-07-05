import 'package:flutter/material.dart';
import 'package:flutter_wall/Screens/alumni_register_screen.dart';
import 'package:flutter_wall/Screens/student_register_screen.dart';

class ChooseScreen extends StatefulWidget {
  const ChooseScreen({ Key key }) : super(key: key);
  
  static const routeName = "/choose";

  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        
      
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 150,),
            Text(
              "ARE YOU A: ",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),

            ),
            SizedBox(height: 80,),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xff0b5c5d)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(70),
                          bottomRight: Radius.circular(70)
                        )
                      ))
                    ),
                    onPressed: (){
                      Navigator.of(context).pushNamed(StudentRegisterScreen.routeName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(110, 30, 10, 30),
                      child: Icon(
                        Icons.account_circle_sharp,
                        size: 70,
                      ),
                    )
                  ),
                  SizedBox(width: 60,),
                  Text('STUDENT',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xfffe4f00)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50)
                        )
                      ))
                      ),
                      onPressed: (){
                      Navigator.of(context).pushNamed(AlumniRegisterScreen.routeName);},
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(110, 30, 10, 20),
                        child: Icon(
                          Icons.business_center_rounded,
                          size: 70,
                        ),
                      )
            ),
                    ],
                  ),
                  SizedBox(width: 60,),
                  Text('ALUMNI',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}