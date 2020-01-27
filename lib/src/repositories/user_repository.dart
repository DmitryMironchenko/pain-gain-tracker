import 'package:buttpaintracker/src/ui/sign_up/bloc/sign_up_bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:buttpaintracker/src/models/user.dart';
import 'package:buttpaintracker/src/repositories/firebase_api_provider.dart';

class UserRepository {
  final _firebaseAPIProvider = FirebaseAPIProvider();

  Future<User> getCurrentUser() async {
    User user = await _firebaseAPIProvider.getCurrentUser();

    return user;
  }

  Future<bool> isSignedIn() async {
    return _firebaseAPIProvider.isSignedIn();
  }

  Future<SignInWithPhoneNumberResolution> signInWithPhoneNumber({
    @required String phoneNumber,
  }) async {
    return _firebaseAPIProvider.signInWithPhoneNumber(
      phoneNumber: phoneNumber,
    );
  }

  Future<void> signOut() async {
    return await _firebaseAPIProvider.signOut();
  }
}
