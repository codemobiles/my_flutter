import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      heroTag: GlobalKey(),
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
