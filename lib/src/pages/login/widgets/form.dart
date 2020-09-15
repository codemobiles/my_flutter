import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_flutter/src/pages/login/widgets/login_button.dart';

class Form extends StatefulWidget {
  Form({
    Key key,
  }) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showPassword;

  @override
  void initState() {
    _showPassword = true;
    super.initState();
  }

  @override
  void dispose() {
    _usernameController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Card(
          margin: EdgeInsets.only(top: 28, bottom: 23, left: 22, right: 22),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 22),
            child: Column(
              children: [
                buildUsernameInput(),
                Divider(
                  height: 16,
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                ),
                buildPasswordInput(),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
        LoginButton(
          onPressed: () {
            //TODO
          },
        ),
      ],
    );
  }

  buildUsernameInput() => TextField(
        controller: _usernameController,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: "username",
          icon: Icon(Icons.person),
          hintText: "username",
        ),
      );

  buildPasswordInput() => TextField(
        obscureText: _showPassword,
        controller: _passwordController,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.lock),
          labelText: "password",
          hintText: "password",
          suffixIcon: IconButton(
            icon: Icon(
              _showPassword ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
              size: 14,
            ),
            onPressed: () {
                _showPassword = !_showPassword;
                setState(() {

                });
            },
          ),
        ),
      );
}
