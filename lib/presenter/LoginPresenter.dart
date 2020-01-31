import 'package:flutter/material.dart';
import 'package:pelatihan_dasar_flutter/view/LoginView.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginView();
  }
}

abstract class LoginPresenter extends State<Login> {
  bool obscureText = true;
  Color borderUsernameColor = Colors.white;
  Color borderPasswordColor = Colors.white;
  bool onLoading = false;

  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    //get user from pref
  }

  void openObscureText() {
    setState(() {
      obscureText = false;
    });
  }

  void closeObscureText() {
    setState(() {
      obscureText = true;
    });
  }

  bool validateUserName() {
    if (userNameController.text.isEmpty || userNameController.text == null) {
      setState(() {
        borderUsernameColor = Colors.red;
      });
      return false;
    } else {
      setState(() {
        borderUsernameColor = Colors.white;
      });
      return null;
    }
  }

  bool validatePassword() {
    if (passwordController.text.isEmpty || passwordController.text == null) {
      setState(() {
        borderPasswordColor = Colors.red;
      });
      return false;
    } else {
      setState(() {
        borderPasswordColor = Colors.white;
      });
      return null;
    }
  }

  bool validate() {
    bool isValid = true;
    isValid = validateUserName() ?? isValid;
    isValid = validatePassword() ?? isValid;
    return isValid;
  }

  void startLoading() {
    setState(() {
      onLoading = true;
    });
  }

  void stopLoading() {
    setState(() {
      onLoading = false;
    });
  }

  void submit() {
    if (!validate()) return;
  }
}
