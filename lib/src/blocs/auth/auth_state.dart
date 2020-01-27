import 'package:buttpaintracker/src/models/user.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthStateUninitalized extends AuthState {}

class AuthStateAuthenticated extends AuthState {
  final User user;
  final bool isNew, isAutoLogIn;

  AuthStateAuthenticated({
    this.user,
    this.isNew,
    this.isAutoLogIn = false,
  });
}

class AuthStateUnauthenticated extends AuthState {}

class AuthStateLoading extends AuthState {}
