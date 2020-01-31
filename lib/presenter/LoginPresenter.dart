import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pelatihan_dasar_flutter/model/userModel.dart';
import 'package:pelatihan_dasar_flutter/view/LoginView.dart';

import '../main.dart';

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

  UserModel user;

  @override
  void initState() {
    super.initState();
    //get user from pref
    String _user = (prefs.getString(PrefsKey.user));
    print(_user);
    user = _user == null ? null : UserModel.fromJson(json.decode(_user));
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

  Future<void> safeUser(UserModel user) async {
    await prefs.setString(PrefsKey.user, json.encode(user.toJson()));
    return;
  }

  void submit() {
    if (!validate()) return;
    startLoading();
    UserModel.login(
      password: passwordController.text,
      username: userNameController.text,
    ).then((onValue) {
      stopLoading();
      safeUser(onValue).then((res) {
        String _user = (prefs.getString(PrefsKey.user));
        print(_user);
        Navigator.of(context).pushReplacementNamed("home");
        //   return showModalBottomSheet(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return Container(
        //         height: 100,
        //         color: Colors.white,
        //         child: Center(
        //           child: Text("Selamat Datang ${onValue.name}"),
        //         ),
        //       );
        //     },
        //   );
      });
    }).catchError((onError) {
      stopLoading();
      return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 100,
            color: Colors.white,
            child: Center(
              child: Text("login gagal $onError"),
            ),
          );
        },
      );
    });
  }
}
