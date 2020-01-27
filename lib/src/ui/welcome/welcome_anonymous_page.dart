import 'package:buttpaintracker/src/ui/sign_up/register_by_phone_page.dart';
import 'package:flutter/material.dart';

class WelcomeAnonymousPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  Text('Hello you little fatty!'),
                  Text('This all will help you to track your'),
                  Text('fitness activity & dynamically tweak them'),
                  Text('to achieve your goal as fast as you can.'),
                  Text('Just register and start!'),
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
                    onPressed: () => Navigator.pushNamed(
                        context, RegisterByPhonePage.routeName),
                    child: Text('Sign in with phone number',
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
  }
}
