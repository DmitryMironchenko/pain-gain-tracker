import 'package:buttpaintracker/src/blocs/auth/index.dart';
import 'package:buttpaintracker/src/ui/sign_up/bloc/sign_up_bloc.dart';
import 'package:buttpaintracker/src/ui/sign_up/bloc/sign_up_event.dart';
import 'package:buttpaintracker/src/ui/sign_up/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterCodeSentPage extends StatelessWidget {
  static const String routeName = '/enter-code-sent';

  final String phoneNumber;

  EnterCodeSentPage({
    @required this.phoneNumber,
  });

  final String title = 'Verify Code';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

  final String _message = 'Enter code received by SMS';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.user != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/', ModalRoute.withName('/'));

          BlocProvider.of<AuthBloc>(context).add(AuthEventAppStarted());
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Form(
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
                controller: _codeController,
                decoration: const InputDecoration(labelText: 'Enter Code'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Code';
                  }
                  return null;
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: RaisedButton(
                  onPressed: () async {
                    BlocProvider.of<SignUpBloc>(context).add(VerifyCodeEvent(
                        smsCode: _codeController.text,
                        verificationId: state.verificationId));
                  },
                  child: const Text('Verify Code'),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                alignment: Alignment.center,
                child: RaisedButton(
                  onPressed: () async {
                    BlocProvider.of<SignUpBloc>(context).add(ResendCodeEvent(
                        phoneNumber: phoneNumber,
                        forceResendingToken: state.forceResendingToken));
                  },
                  child: const Text('Re-send Code'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
