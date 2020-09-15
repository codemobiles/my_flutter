import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_flutter/src/commons/constants.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          SizedBox(height: 62),
          Image.asset(Constants.IMAGE_HEADER),
          _buildCard(),
          _buildForgotPassword(),
          _buildDivider(),
          SocialLogin(),
        ],
      ),
    );
  }

  Row _buildDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.white,
          width: 120,
          height: 1,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Text("or"),
        ),
        Container(
          color: Colors.white,
          width: 120,
          height: 1,
        )
      ],
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
