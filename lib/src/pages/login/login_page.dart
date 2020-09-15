import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_flutter/src/commons/constants.dart';
import 'package:my_flutter/src/pages/login/background.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: Background.gradient,
        ),
        child: Column(
          children: [
            SizedBox(height: 62),
            Image.asset(Constants.IMAGE_HEADER),
            _buildCard(),
            _buildForgotPassword(),
            _buildDivider(),
            SocialLogin(),
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    final divider = ({isRight = false}) {
      final colors = [Colors.white, Colors.white10];
      return Container(
        width: 120,
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
               colors: isRight ? colors : colors.reversed.toList(),
              stops: [0, 1],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
      );
    };

    return Container(
      margin: EdgeInsets.symmetric(vertical: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          divider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "or",
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
          divider(isRight: true),
        ],
      ),
    );
  }

  FlatButton _buildForgotPassword() {
    return FlatButton(
      textColor: Colors.white,
      onPressed: () {
        print("Forgot password click");
      },
      child: Text("Forgot password?"),
    );
  }

  Card _buildCard() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("username"),
            Text("password"),
          ],
        ),
      ),
    );
  }
}

class SocialLogin extends StatelessWidget {
  const SocialLogin({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(
          onPressed: () {
            print("S: 1");
          },
          icon: FontAwesomeIcons.facebookF,
          color: Colors.blue,
        ),
        buildButton(
          onPressed: () {
            print("S: 1");
          },
          icon: FontAwesomeIcons.line,
          color: Colors.green,
        ),
        buildButton(
          onPressed: () {
            print("S: 1");
          },
          icon: FontAwesomeIcons.apple,
          color: Colors.grey,
        ),
        buildButton(
          onPressed: () {
            print("S: 1");
          },
          icon: FontAwesomeIcons.twitter,
          color: Colors.blue,
        ),
        buildButton(
          onPressed: () {
            print("S: 1");
          },
          icon: FontAwesomeIcons.twitch,
          color: Colors.purple,
        ),
      ],
    );
  }

  FloatingActionButton buildButton({
    IconData icon = Icons.add,
    Color color = Colors.black,
    @required VoidCallback onPressed,
  }) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: Colors.white,
      child: FaIcon(
        icon,
        color: color,
      ),
      onPressed: onPressed,
    );
  }
}
