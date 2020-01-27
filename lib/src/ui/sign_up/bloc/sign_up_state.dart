import 'package:buttpaintracker/src/models/user.dart';

class SignUpState {
  final User user;
  final bool isLoading;
  final String error;
  final String verificationId;
  final int forceResendingToken;
  final bool isVerificationCodeRequested;

  SignUpState({
    this.user,
    this.isLoading = false,
    this.error,
    this.verificationId,
    this.forceResendingToken,
    this.isVerificationCodeRequested = false,
  });

  factory SignUpState.initial() => SignUpState();

  factory SignUpState.isLoading() => SignUpState(
        isLoading: true,
      );

  factory SignUpState.signUpSucceded(User user) => SignUpState(
        isLoading: false,
        user: user,
      );

  factory SignUpState.signUpFailed(String error) => SignUpState(
        isLoading: false,
        error: error,
      );

  factory SignUpState.codeVerificationRequested(String verificationId,
          [int forceResendingToken]) =>
      SignUpState(
        forceResendingToken: forceResendingToken,
        verificationId: verificationId,
        isVerificationCodeRequested: true,
      );
}
