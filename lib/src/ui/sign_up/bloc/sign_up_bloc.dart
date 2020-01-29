import 'package:bloc/bloc.dart';
import 'package:buttpaintracker/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'package:buttpaintracker/src/repositories/user_repository.dart';
import 'package:buttpaintracker/src/ui/sign_up/bloc/sign_up_event.dart';
import 'package:buttpaintracker/src/ui/sign_up/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository userRepository;

  SignUpBloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  SignUpState get initialState => SignUpState.initial();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpWithPhoneNumberEvent) {
      yield* _mapSignInWithPhoneNumber(event);
    } else if (event is VerifyCodeEvent) {
      yield* _mapVerifyCodeEvent(event);
    } else if (event is ResendCodeEvent) {
      yield* _mapResendCodeEvent(event);
    }
  }

  Stream<SignUpState> _mapSignInWithPhoneNumber(event) async* {
    yield SignUpState.isLoading();

    try {
      SignInWithPhoneNumberResolution result =
          await userRepository.signInWithPhoneNumber(
        phoneNumber: event.phoneNumber,
      );
      if (!result.isCodeVerificationRequested) {
        yield SignUpState.signUpSucceded(null);
      } else if (result.isCodeVerificationRequested) {
        yield SignUpState.codeVerificationRequested(
            result.verificationId, result.forceResendingToken);
      }
    } catch (e) {
      yield SignUpState.signUpFailed(e.toString());
    }
  }

  Stream<SignUpState> _mapResendCodeEvent(event) async* {
    yield SignUpState.isLoading();

    try {
      SignInWithPhoneNumberResolution result =
          await userRepository.resendTokenAndSignInWithPhoneNumber(
        phoneNumber: event.phoneNumber,
        forceResendingToken: event.forceResendingToken,
      );
      if (!result.isCodeVerificationRequested) {
        yield SignUpState.signUpSucceded(null);
      } else if (result.isCodeVerificationRequested) {
        yield SignUpState.codeVerificationRequested(
            result.verificationId, result.forceResendingToken);
      }
    } catch (e) {
      yield SignUpState.signUpFailed(e.toString());
    }
  }

  Stream<SignUpState> _mapVerifyCodeEvent(VerifyCodeEvent event) async* {
    yield SignUpState.isLoading();

    try {
      final User user = await userRepository.signInWithSmsCode(
          smsCode: event.smsCode, verificationId: event.verificationId);
      yield SignUpState.signUpSucceded(user);
    } catch (e) {
      yield SignUpState.signUpFailed(e.toString());
    }
  }
}

class SignInWithPhoneNumberResolution {
  final bool isCodeVerificationRequested;
  final String verificationId;
  final int forceResendingToken;

  SignInWithPhoneNumberResolution(
      {this.isCodeVerificationRequested = false,
      this.verificationId,
      this.forceResendingToken});

  factory SignInWithPhoneNumberResolution.success() =>
      SignInWithPhoneNumberResolution();

  factory SignInWithPhoneNumberResolution.codeVerificationRequested(
          {String verificationId, int forceResendingToken}) =>
      SignInWithPhoneNumberResolution(
        verificationId: verificationId,
        forceResendingToken: forceResendingToken,
        isCodeVerificationRequested: true,
      );
}
