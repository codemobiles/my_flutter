import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_flutter/src/bloc/login/login_cubit.dart';
import 'package:my_flutter/src/commons/constants.dart';
import 'package:my_flutter/src/pages/home/home_page.dart';
import 'package:my_flutter/src/pages/login/widgets/login_button.dart';
import 'package:my_flutter/src/utils/StringValidator.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  LoginCubit _loginCubit;

  @override
  void initState() {
    _showPassword = true;
    _loginCubit = LoginCubit();
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
    return CubitBuilder<LoginCubit, LoginState>(
      buildWhen: (previousState, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, Constants.HOME_ROUTE);
        }

        if (state is LoginFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              barrierDismissible: false,
              context: context,
              child: AlertDialog(
                title: Text("Login"),
                content: Text("Username or Password incorrect!!"),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("ยกเลิก"),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("ตกลง"),
                  )
                ],
              ),
            );
          });
        }
        return true;
      },
      cubit: _loginCubit,
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Card(
              margin: EdgeInsets.only(top: 28, bottom: 23, left: 22, right: 22),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 22),
                child: Column(
                  children: [
                    buildUsernameInput(state),
                    Divider(
                      height: 16,
                      indent: 20,
                      endIndent: 20,
                      thickness: 1,
                    ),
                    buildPasswordInput(state),
                    if (state is LoginInProgress) CircularProgressIndicator(),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            LoginButton(
              onPressed: () {
                _loginCubit.login(
                    _usernameController.text, _passwordController.text);
              },
            ),
          ],
        );
      },
    );
  }

  buildUsernameInput(LoginState state) => TextField(
        controller: _usernameController,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: "username",
          errorText: state is LoginInValid ? state.errorUsername : null,
          icon: Icon(Icons.person),
          hintText: "username",
        ),
      );

  buildPasswordInput(LoginState state) => TextField(
        obscureText: _showPassword,
        controller: _passwordController,
        decoration: InputDecoration(
          border: InputBorder.none,
          errorText: state is LoginInValid ? state.errorPassword : null,
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
