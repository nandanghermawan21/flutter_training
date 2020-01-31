import 'package:flutter/material.dart';
import 'package:pelatihan_dasar_flutter/presenter/LoginPresenter.dart';

class LoginView extends LoginPresenter {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: <Color>[
          Color(0xff00549E),
          Color(0xff008AF6),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SafeArea(
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/logo_suzuki.png"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                               "Selamat datang kembali ${"nama user"}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      height: 40,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 40,
                            margin: EdgeInsets.only(right: 10),
                            child: Image.asset(
                              "assets/icon_user.png",
                              alignment: Alignment.bottomCenter,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: userNameController,
                              cursorColor: Colors.white,
                              focusNode: usernameFocusNode,
                              onSubmitted: (res) {
                                FocusScope.of(context)
                                    .requestFocus(passwordFocusNode);
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                hintText: "Nama Pengguna",
                                hintStyle: TextStyle(
                                  color: Colors.white30,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: borderUsernameColor,
                                )),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: borderUsernameColor,
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      height: 40,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 40,
                            margin: EdgeInsets.only(right: 10),
                            child: Image.asset(
                              "assets/icon_keys.png",
                              alignment: Alignment.bottomCenter,
                            ),
                          ),
                          Expanded(
                              child: TextField(
                            controller: passwordController,
                            cursorColor: Colors.white,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            focusNode: passwordFocusNode,
                            obscureText: obscureText,
                            decoration: InputDecoration(
                                focusColor: Colors.white,
                                hintText: "Nama Pengguna",
                                hintStyle: TextStyle(
                                  color: Colors.white30,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: borderPasswordColor,
                                )),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: borderPasswordColor,
                                )),
                                suffixIcon: GestureDetector(
                                  onLongPressStart: (a) {
                                    openObscureText();
                                  },
                                  onLongPressEnd: (a) {
                                    closeObscureText();
                                  },
                                  child: Container(
                                    width: 20,
                                    child: Image.asset(
                                      "assets/icon_close_eyes.png",
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                )),
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: submit,
                      child: Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xff008AF6),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                            child: Text(
                          "Masuk",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            onLoading == true
                ? Container(
                    color: Colors.white.withOpacity(0.1),
                    padding: EdgeInsets.only(bottom: 50),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                : Container(
                    height: 0,
                    width: 0,
                  )
          ],
        ),
      ),
    );
  }
}
