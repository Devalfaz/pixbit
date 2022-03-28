import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:pixbit/src/network/api.dart';
import 'package:pixbit/src/utils/constants.dart';

import '../models/response_data.dart';
import '../models/user_model.dart';
import '../utils/router.dart';
import '../utils/theme.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _protected = true;
  final TextEditingController _emailnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  FocusNode _f1 = FocusNode();
  FocusNode _f2 = FocusNode();
  FocusNode _f3 = FocusNode();
  FocusNode _f4 = FocusNode();
  bool _loadStat = false;

  register() async {
    if (_emailnameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      primarySnackBar(
          context: context,
          text: 'Enter valid data!',
          priority: CustomSnack.WARNING);
      return;
    }
    setState(() {
      _loadStat = true;
    });
    try {
      // ResponseData response = await pixBitAPI.register(
      //     _emailnameController.text,
      //     _passwordController.text,
      //     _nameController.text,
      //     _phoneController.text);

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
      //   primarySnackBar(
      //       context: context,
      //       text: 'Registration successful!',
      //       priority: CustomSnack.SUCCESS);
      //   Navigator.pushReplacementNamed(context, RouterHelper.loginRoute);
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
                    'Register',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _emailnameController,
                    focusNode: _f1,
                    decoration: InputDecoration(
                      labelText: 'Email',
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
                      FocusScope.of(context).requestFocus(_f3);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _nameController,
                    focusNode: _f3,
                    decoration: InputDecoration(
                      labelText: 'name',
                    ),
                    onSubmitted: (value) {
                      _f3.unfocus();
                      FocusScope.of(context).requestFocus(_f4);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _phoneController,
                    focusNode: _f4,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                    ),
                    onSubmitted: (value) {
                      _f4.unfocus();
                      register();
                    },
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
                              register();
                            },
                            child: _loadStat
                                ? CircularProgressIndicator()
                                : Text('Register'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, RouterHelper.loginRoute);
                    },
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ])));
  }
}
