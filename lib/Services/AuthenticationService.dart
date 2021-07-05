import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class AuthenticationService{
  final FirebaseAuth firebaseAuth;

  AuthenticationService(this.firebaseAuth);

  Stream<User> get authStateChanges => firebaseAuth.idTokenChanges();

  Future<String> signIn({@required String email, @required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return 'Signed in';
    } on FirebaseAuthException catch (e){
      throw e;
    }
  }
  Future<String> signOut() async {
    try {
      await firebaseAuth.signOut();
      return "Signed out.";
    } on FirebaseAuthException catch (e){
      throw e;
    }
  }

  Future<String> signInAnon() async {
    try{
      await firebaseAuth.signInAnonymously();
      return "Guest sign in";
    } on FirebaseAuthException catch (e){
      throw e;
    }
  }
}