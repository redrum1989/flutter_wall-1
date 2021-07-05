import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wall/Model/AlumniData.dart';
import 'package:flutter_wall/Model/PermissionSet.dart';
import 'package:flutter_wall/Model/Post.dart';
import 'package:flutter_wall/Model/StudentData.dart';

class Database{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final CollectionReference studentInfo = FirebaseFirestore.instance.collection("Students Info");
  final CollectionReference alumniInfo = FirebaseFirestore.instance.collection("Alumni Info");
  final CollectionReference permission = FirebaseFirestore.instance.collection("Permission");
  final CollectionReference posts = FirebaseFirestore.instance.collection("Posts");

  Future registerStudentData(BuildContext context, StudentData user) async {
    try{
      await firebaseAuth.createUserWithEmailAndPassword(email: user.email, password: user.password);
      User firebaseUser = FirebaseAuth.instance.currentUser;
      await studentInfo.doc(firebaseUser.uid).set(user.returnStudentData());
      await permission.doc(firebaseUser.uid).set(PermissionData(permission: "Student").returnPermissionData());
    } catch (e){
      return showDialog(context: context, builder: (context){
        return AlertDialog(content: Text(e.toString()));
      });
    }
  }

  Future registerAlumniData(BuildContext context, AlumniData user) async {
    try{
      await firebaseAuth.createUserWithEmailAndPassword(email: user.email, password: user.password);
      User firebaseUser = FirebaseAuth.instance.currentUser;
      await alumniInfo.doc(firebaseUser.uid).set(user.returnAlumniData());
      await permission.doc(firebaseUser.uid).set(PermissionData(permission: "Alumni").returnPermissionData());
    } catch (e){
      return showDialog(context: context, builder: (context){
        return AlertDialog(content: Text(e.toString()));
      });
    }
  }

  Future registerPostData(BuildContext context, Post post) async {
    try{
      User firebaseUser = FirebaseAuth.instance.currentUser;
      await posts.doc(firebaseUser.uid).set(post.returnPostData());
    } catch (e){
      return showDialog(context: context, builder: (context){
        return AlertDialog(content: Text(e.toString()));
      });
    }
  }


}