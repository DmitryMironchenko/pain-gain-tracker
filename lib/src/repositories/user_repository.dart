import 'package:buttpaintracker/src/ui/sign_up/bloc/sign_up_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:buttpaintracker/src/models/user.dart';
import 'package:buttpaintracker/src/repositories/firebase_api_provider.dart';

class UserRepository {
  final _firebaseAPIProvider = FirebaseAPIProvider();

  Future<User> getCurrentUser() async {
    User user = await _firebaseAPIProvider.getCurrentUser();

    return user;
  }

  Future<bool> isSignedIn() => _firebaseAPIProvider.isSignedIn();

  Future<SignInWithPhoneNumberResolution> signInWithPhoneNumber({
    @required String phoneNumber,
  }) async {
    return _firebaseAPIProvider.signInWithPhoneNumber(
      phoneNumber: phoneNumber,
    );
  }

  Future<SignInWithPhoneNumberResolution> resendTokenAndSignInWithPhoneNumber({
    @required String phoneNumber,
    @required int forceResendingToken,
  }) => _firebaseAPIProvider.resendTokenAndSignInWithPhoneNumber(
    phoneNumber: phoneNumber,
    forceResendingToken: forceResendingToken,
  );

  Future<void> signOut() => _firebaseAPIProvider.signOut();

  Future<User> signInWithSmsCode({String verificationId, String smsCode}) =>
      _firebaseAPIProvider.signInWithSmsCode(
          verificationId: verificationId, smsCode: smsCode);
}
