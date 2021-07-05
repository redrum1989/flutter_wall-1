// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_wall/Model/PermissionSet.dart';

// class PermissionGetter{
//   User user;
//   PermissionGetter(this.user);
//   final CollectionReference permission = FirebaseFirestore.instance.collection("Permission");

//   PermissionData perm(DocumentSnapshot snapshot){
//     return PermissionData(permission: snapshot["permission"]);
//   }

//   Stream<PermissionData> get perms{
//     return FirebaseFirestore.instance.collection("Permission")
//       .doc(this.user.uid)
//       .snapshots()
//       .map(perm);
//   }
// }