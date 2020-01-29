import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpWithPhoneNumberEvent extends SignUpEvent {
  final String phoneNumber;

  SignUpWithPhoneNumberEvent({
    @required this.phoneNumber,
  }) : assert(phoneNumber != null);

  @override
  String toString() {
    return 'SignUpWithPhoneNumberEvent';
  }
}

class VerifyCodeEvent extends SignUpEvent {
  final String verificationId;
  final String smsCode;

  VerifyCodeEvent({
    @required this.smsCode,
    @required this.verificationId,
  }) : assert(smsCode != null && verificationId != null);

  @override
  String toString() {
    return 'VerifyCodeEvent';
  }
}

class ResendCodeEvent extends SignUpEvent {
  final String phoneNumber;
  final int forceResendingToken;

  ResendCodeEvent({
    @required this.phoneNumber,
    @required this.forceResendingToken,
  });

  @override
  String toString() {
    return 'ResendCodeEvent';
  }
}
