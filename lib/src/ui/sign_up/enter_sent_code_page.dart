import 'package:buttpaintracker/src/ui/sign_up/bloc/sign_up_bloc.dart';
import 'package:buttpaintracker/src/ui/sign_up/bloc/sign_up_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterCodeSentPage extends StatefulWidget {
  static const String routeName = '/enter-code-sent';

  final String title = 'Verify Code';

  // String verificationId;
  // int forceResendingToken;

  // EnterCodeSentPage(
  //     {Key key, @required this.verificationId, this.forceResendingToken})
  //     : super(key: key);

  @override
  State<StatefulWidget> createState() => EnterCodeSentPageState();
}

class EnterCodeSentPageState extends State<EnterCodeSentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

  String _message = 'Enter code received by SMS';

  @override
  Widget build(BuildContext context) {
    final SignUpBloc bloc = BlocProvider.of<SignUpBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                  bloc.add(VerifyCode(code: _codeController.text));
                },
                child: const Text('Verify Code'),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: () async {
                  bloc.add(ResendCode());
                },
                child: const Text('Re-send Code'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _startSignIn() async {
    // AuthCredential credential = PhoneAuthProvider.getCredential(
    //     verificationId: widget.verificationId, smsCode: _codeController.text);

    // try {
    //   AuthResult result = await _auth.signInWithCredential(credential);

    //   if (result.user.uid != null) {
    //     setState(() {
    //       _message = 'Signed in successfully!';
    //     });

    //     _navigateToHomePage();
    //   }
    // } catch (e) {
    //   setState(() {
    //     _message = 'Failed to sign in. Somwthing went wrong.';
    //   });
    // }
  }

  void _navigateToHomePage() {
    print('Foooo');
    // Navigator.pushNamed(context, HomePage.routeName);
  }
}
