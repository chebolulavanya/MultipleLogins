import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

// abstract class BaseAuth {
//   Future<String> signIn(String email, String password);

//   Future<String> signUp(String email, String password);

//   Future<FirebaseUser> getCurrentUser();

//   Future<void> sendEmailVerification();

//   Future<void> signOut();

//   Future<bool> isEmailVerified();
// }

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
   UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password
  );
  return userCredential.user.uid;
  }

  Future<String> signUp(String email, String password) async {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password
  );
  return userCredential.user.uid;
  }


  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
  
}
