import 'package:buttpaintracker/src/blocs/auth/index.dart';
import 'package:buttpaintracker/src/ui/welcome/welcome_anonymous_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatefulWidget {
  static const String routeName = '/';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    // bloc.getCurrentUser();
  }

  void dispose() {
    super.dispose();
    // bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Welcome'),
      // ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateAuthenticated) {
            // Return Welcome %username page widget
            return Text('Authenticated');
          } else if (state is AuthStateUnauthenticated) {
            // Return Welcome anonymous
            return WelcomeAnonymousPage();
          } else if (state is AuthStateLoading) {
            return Text('Loading');
          }
          return Text('Wtf');
        },
      ),
    );
  }
}
