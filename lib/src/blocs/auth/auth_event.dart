import 'package:equatable/equatable.dart';

import 'package:buttpaintracker/src/models/user.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthEventAppStarted extends AuthEvent {
  @override
  String toString() => "AuthEventAppStarted";
}

class AuthEventSignedIn extends AuthEvent {
  final User user;
  final bool isNew;

  AuthEventSignedIn({
    this.isNew = false,
    this.user,
  });

  @override
  String toString() => "AuthEventSignedIn";
}

class AuthEventSignedOut extends AuthEvent {
  @override
  String toString() => "AuthEventSignedOut";
}
