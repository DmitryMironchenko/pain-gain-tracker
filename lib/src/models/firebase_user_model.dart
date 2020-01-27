import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserModel {
  FirebaseUser firebaseUser;
  IdTokenResult token;

  FirebaseUserModel(this.firebaseUser, this.token);
}
