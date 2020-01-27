import 'dart:async';

import 'package:buttpaintracker/src/ui/sign_up/bloc/sign_up_bloc.dart';
import 'package:meta/meta.dart';
import 'package:buttpaintracker/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAPIProvider {
  final FirebaseAuth _firebaseAuth;
  final Firestore _firestore;

  FirebaseAPIProvider({
    FirebaseAuth firebaseAuth,
    Firestore firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? Firestore.instance;

  Future<User> getCurrentUser() async {
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();

    if (firebaseUser.uid == null) {
      return null;
    }

    final snapshot =
        await _firestore.collection('users').document(firebaseUser.uid).get();

    if (snapshot.exists) {
      final existingUser = User.fromJSON(snapshot.data);

      return existingUser;
    } else {
      final newUser = User(uid: firebaseUser.uid);

      await _firestore
          .collection('users')
          .document(newUser.uid)
          .setData(newUser.toJSON());

      return newUser;
    }
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  // Future<IdTokenResult> getUserToken(FirebaseUser firebaseUser) async {
  //   IdTokenResult token;

  //   if (firebaseUser != null) {
  //     token = await firebaseUser.getIdToken(refresh: true);
  //   }

  //   return token;
  // }

  Future<SignInWithPhoneNumberResolution> signInWithPhoneNumber({
    @required String phoneNumber,
  }) async {
    final Completer _completer = Completer<SignInWithPhoneNumberResolution>();

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      // setState(() {
      //   _message = 'Received phone auth credential: $phoneAuthCredential';
      // });

      // TODO: redirect to Welcome %username% page
      _completer.complete(SignInWithPhoneNumberResolution.success());
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      _completer.completeError(authException);
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      
      _completer.complete(
          SignInWithPhoneNumberResolution.codeVerificationRequested(
              verificationId: verificationId,
              forceResendingToken: forceResendingToken));
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      // setState(() {
      //   _message = 'codeAutoRetrievalTimeout, $_verificationId';
      // });
    };

    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    //.then((_) {
    // TRICKY: Should we actually complete Completer here? Or maybe complete only from callbacks.
    // _completer.complete(SignInWithPhoneNumberResolution.success());
    //});

    return _completer.future;
  }

  Future<void> signInWithPhoneCredential(
      {String verificationId, String smsCode}) async {
    AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);

    try {
      AuthResult result = await _firebaseAuth.signInWithCredential(credential);

      if (result.user.uid != null) {
        // setState(() {
        //   _message = 'Signed in successfully!';
        // });

        // _navigateToHomePage();

        return Future.value();
      }

      return Future.error(Exception('User is null'));
    } catch (e) {
      // setState(() {
      //   _message = 'Failed to sign in. Somwthing went wrong.';
      // });

      return Future.error(e);
    }
  }

  Future<bool> isSignedIn() async {
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();

    return firebaseUser != null;
  }
}
