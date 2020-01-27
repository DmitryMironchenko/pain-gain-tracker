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

class VerifyCode extends SignUpEvent {
  final String code;

  VerifyCode({
    @required this.code,
  }) : assert(code != null);

  @override
  String toString() {
    return 'VerifyCode';
  }
}

class ResendCode extends SignUpEvent {
  @override
  String toString() {
    return 'ResendCode';
  }
}
