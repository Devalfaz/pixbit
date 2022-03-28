import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pixbit/src/network/api.dart';
import 'package:pixbit/src/settings/settings_controller.dart';
import 'package:pixbit/src/utils/constants.dart';
import 'package:provider/provider.dart';

import '../models/response_data.dart';
import '../models/user_model.dart';
import '../utils/router.dart';
import '../utils/theme.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _protected = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode _f1 = FocusNode();
  FocusNode _f2 = FocusNode();
  bool _loadStat = false;

  login() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      primarySnackBar(
          context: context,
          text: 'Enter username/password!',
          priority: CustomSnack.WARNING);
      return;
    }
    setState(() {
      _loadStat = true;
    });
    try {
      LoginData response = await pixBitAPI.login(
          _usernameController.text, _passwordController.text);
      context
          .read<SettingsController>()
          .updateUserToken(response.data?.accessToken);
      Navigator.pushReplacementNamed(
        context,
        RouterHelper.homeRoute,
      );
      // UserModel? user = response.data;

      // if (response.status == "ERROR") {
      //   primarySnackBar(
      //       context: context,
      //       text: 'Invalid username/password!',
      //       priority: CustomSnack.ERROR);
      //   if (mounted) {
      //     setState(() {
      //       _loadStat = false;
      //     });
      //   }
      //   return;
      // } else {
      //   if (mounted) {
      //     setState(() {
      //       _loadStat = false;
      //     });
      //   }
      // }
    } on Exception catch (e) {
      log(e.toString());
      primarySnackBar(
          context: context,
          text: 'Invalid username/password!',
          priority: CustomSnack.ERROR);
      setState(() {
        _loadStat = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign in ',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: _usernameController,
                    focusNode: _f1,
                    decoration: InputDecoration(
                      labelText: 'email',
                    ),
                    onSubmitted: (value) {
                      _f1.unfocus();
                      FocusScope.of(context).requestFocus(_f2);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _passwordController,
                    focusNode: _f2,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    onSubmitted: (value) {
                      _f2.unfocus();
                      login();
                    },
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(primary_color),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(primary_color)),
                            onPressed: () {
                              login();
                            },
                            child: _loadStat
                                ? CircularProgressIndicator()
                                : Text('Login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ])));
  }
}
