import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:my_flutter/src/commons/constants.dart';
import 'package:my_flutter/src/utils/StringValidator.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  @override
  void onTransition(Transition<LoginState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  void login(String username, String password) async {
    try {
      String errorUsername;
      String errorPassword;

      if (username.isEmpty) {
        errorUsername = 'The Email is Empty';
      } else if (!EmailSubmitRegexValidator().isValid(username)) {
        errorUsername = "The Email must be a valid email.";
      }

      if (password.length < 8) {
        errorPassword = 'The Password must be at least 8 characters.';
      }

      if (errorUsername == null && errorPassword == null) {
        emit(LoginInProgress());
        await Future.delayed(Duration(seconds: 2));
        authen(username, password);
      } else {
        emit(LoginInValid(errorUsername: errorUsername, errorPassword: errorPassword));
      }
    } catch (error) {
      emit(LoginFailure(error: error));
    }
  }

  Future<void> authen(String username, String password) async {
    if (username == "admin@gmail.com" && password == "12345678") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(Constants.PREF_USERNAME, username);
      prefs.setString(Constants.PREF_TOKEN, "sf124124sfasfsaf");
      emit(LoginSuccess());
    } else {
      emit(LoginFailure(error: "Username or Password incorrect"));
    }
  }
}

class EmailSubmitRegexValidator extends RegexValidator {
  EmailSubmitRegexValidator()
      : super(
      regexSource: "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-]+\$)");
}
