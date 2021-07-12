import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_wall/Model/Post.dart';

class PostsGetter {
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("Posts");

  List<Post> feed(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Post(
          authorUID: doc["authorUID"],
          text: doc["text"],
          title: doc["title"],
          college: doc["college"]);
    }).toList();
  }

  Stream<List<Post>> get postData {
    return posts.snapshots().map(feed);
  }
}
