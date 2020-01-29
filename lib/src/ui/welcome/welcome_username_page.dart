import 'package:buttpaintracker/src/blocs/auth/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:buttpaintracker/src/utils/string_apis.dart';

class WelcomeUserNamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthStateAuthenticated) {
        final String userDisplayName =
            !state.user.displayName.isNullEmptyOrWhitespace ??
                state.user.displayName;
        final String phoneNumber =
            !state.user.phoneNumber.isNullEmptyOrWhitespace ??
                state.user.phoneNumber;
        final String uid =
            !state.user.phoneNumber.isNullEmptyOrWhitespace ?? state.user.uid;

        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background-images/running-bgr.jpg"),
              fit: BoxFit.cover,
              // centerSlice: new Rect.fromLTWH(50.0, 20.0, 100.0, 300.0),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      Text('Hello ${userDisplayName ?? phoneNumber ?? uid}!'),
                      Text(
                          'Hope You had enough rest to continue your workout.'),
                      Text('Just tap "Go to workout" button!'),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () => {},
                        child: Text('Go to workout',
                            style: TextStyle(fontSize: 20)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Text('Terms of service'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        return Text('Not Authenticated');
      }
    });
  }
}
