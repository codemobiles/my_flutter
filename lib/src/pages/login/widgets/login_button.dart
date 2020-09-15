import 'package:flutter/material.dart';
import 'package:my_flutter/src/pages/login/background.dart';

class LoginButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Background.gradientStart,
            offset: Offset(1.0, 6.0),
            blurRadius: 20.0,
          ),
          BoxShadow(
            color: Background.gradientEnd,
            offset: Offset(1.0, 6.0),
            blurRadius: 20.0,
          ),
        ],
        gradient: LinearGradient(
          colors: [
            Background.gradientEnd,
            Background.gradientStart,
          ],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 1.0),
          stops: [0.0, 1.0],
        ),
      ),
      child: FlatButton(
        highlightColor: Colors.transparent,
        child: Text(
          "LOGIN",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        onPressed: (){
          //todo
        },
      ),
    );
  }
}
