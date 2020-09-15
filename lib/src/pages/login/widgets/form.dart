import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_flutter/src/pages/login/widgets/login_button.dart';
import 'package:my_flutter/src/utils/StringValidator.dart';

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

  String _usernameErrorMessage;
  String _passwordErrorMessage;

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
            print(_usernameController.text);
            print(_passwordController.text);

            var username = _usernameController.text;
            if (username.isEmpty) {
              _usernameErrorMessage = "not empty";
              setState(() {});
            }

            if (!EmailSubmitRegexValidator().isValid(username)) {
              _usernameErrorMessage = "not empty";
              setState(() {});
            }

            var password = _passwordController.text;
            if (password.length < 8) {
              _passwordController.text = "";
              _passwordErrorMessage =
                  "The Password must be at least 8 characters.";
              setState(() {});
            } else {
              _passwordErrorMessage = null;
              setState(() {});
            }

            if (username == "admin" && password == "12345678") {
              //TODO
            } else {
              showDialog(
                barrierDismissible: false,
                context: context,
                child: AlertDialog(
                  title: Text("Login"),
                  content: Text("Username or Password incorrect!!"),
                  actions: [
                    FlatButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("ยกเลิก"),
                    ),
                    FlatButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("ตกลง"),
                    )
                  ],
                ),
              );
            }
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
          errorText: _usernameErrorMessage,
          icon: Icon(Icons.person),
          hintText: "username",
        ),
      );

  buildPasswordInput() => TextField(
        obscureText: _showPassword,
        controller: _passwordController,
        decoration: InputDecoration(
          border: InputBorder.none,
          errorText: _passwordErrorMessage,
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
              setState(() {});
            },
          ),
        ),
      );
}

class EmailSubmitRegexValidator extends RegexValidator {
  EmailSubmitRegexValidator()
      : super(
            regexSource: "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-]+\$)");
}
