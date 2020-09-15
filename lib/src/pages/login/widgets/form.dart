import 'package:flutter/material.dart';

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
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
            child: Column(
              children: [
                buildUsernameInput(),
                buildPasswordInput(),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
        RaisedButton(
          onPressed: () {
            //TODO
          },
          child: Text("LOGIN"),
        ),
      ],
    );
  }

  buildUsernameInput() => TextField(
    controller: _usernameController,
    decoration: InputDecoration(
      icon: Icon(Icons.person),
      hintText: "username",
    ),
  );

  buildPasswordInput() => TextField(
    controller: _passwordController,
    decoration: InputDecoration(
      icon: Icon(Icons.lock),
      hintText: "password",
    ),
  );
}
