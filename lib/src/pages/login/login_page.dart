import 'package:flutter/material.dart';
import 'package:my_flutter/src/commons/constants.dart';
import 'package:my_flutter/src/pages/login/background.dart';
import 'package:my_flutter/src/pages/login/widgets/social_login.dart';
import 'package:my_flutter/src/pages/login/widgets/form.dart' as myForm;

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: Background.gradient,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 62),
              Image.asset(Constants.IMAGE_HEADER),
              myForm.Form(),
              _buildForgotPassword(),
              _buildDivider(),
              SocialLogin(),
              SizedBox(height: 90),
            ],
          ),
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

  Container _buildForgotPassword() {
    return Container(
      margin: EdgeInsets.only(top: 18),
      child: FlatButton(
        textColor: Colors.white,
        onPressed: () {
          print("Forgot password click");
        },
        child: Text("Forgot password?"),
      ),
    );
  }
}
