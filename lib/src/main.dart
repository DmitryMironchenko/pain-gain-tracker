import 'package:bloc/bloc.dart';
import 'package:buttpaintracker/src/ui/sign_up/register_by_phone_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:buttpaintracker/src/blocs/auth/index.dart';
import 'package:buttpaintracker/src/blocs/block_delegate.dart';
import 'package:buttpaintracker/src/repositories/user_repository.dart';
import 'package:buttpaintracker/src/ui/welcome/welcome_page.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();

  runApp(
    RepositoryProvider(
        create: (context) => UserRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) {
                final UserRepository userRepository =
                    RepositoryProvider.of<UserRepository>(context);
                return AuthBloc(userRepository: userRepository)
                  ..add(AuthEventAppStarted());
              },
            ),
          ],
          child: App(),
        )),
  );
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => WelcomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        RegisterByPhonePage.routeName: (_) => RegisterByPhonePage(),
        // HomePage.routeName: (context) => HomePage(),
      },
    );
  }
}
