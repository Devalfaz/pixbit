import 'package:flutter/material.dart';
import 'package:pixbit/src/utils/constants.dart';
import 'package:pixbit/src/utils/router.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 180,
          width: 180,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'DriverEx',
          style: TextStyle(
            fontSize: 30,
            color: Color(primary_color),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(primary_color),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, RouterHelper.loginRoute);
                      },
                      child: Text('Sign in'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(primary_color),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, RouterHelper.registerRoute);
                      },
                      child: Text('Register'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Take Tour',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    ));
  }
}
