import 'package:buttpaintracker/src/repositories/user_repository.dart';
import 'package:buttpaintracker/src/ui/sign_up/bloc/sign_up_bloc.dart';
import 'package:buttpaintracker/src/ui/sign_up/bloc/sign_up_event.dart';
import 'package:buttpaintracker/src/ui/sign_up/bloc/sign_up_state.dart';
import 'package:buttpaintracker/src/ui/sign_up/enter_sent_code_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterByPhonePage extends StatefulWidget {
  static const String routeName = '/register';

  final String title = 'Sign in with Phone';

  @override
  State<StatefulWidget> createState() => RegisterByPhoneState();
}

class RegisterByPhoneState extends State<RegisterByPhonePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  String _message = 'So hello, try to register by your phone!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.isVerificationCodeRequested) {
            Navigator.pushNamed(context, EnterCodeSentPage.routeName);
          }
        },
        child: BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
          //ignore: close_sinks
          final SignUpBloc signUpBloc = BlocProvider.of<SignUpBloc>(context);

          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    _message,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                      labelText: 'Phone number (+375-XX-XXX-XXXX)'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Phone number (+375-XX-XXX-XXXX)';
                    }
                    return null;
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: Alignment.center,
                  child: RaisedButton(
                    onPressed: () async {
                      signUpBloc.add(SignUpWithPhoneNumberEvent(
                          phoneNumber: _phoneController.text));
                    },
                    child: const Text('Sign In'),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
