import 'package:flutter/material.dart';
import 'package:facility_maintenance/Screens/Login_user/login_screen.dart';
import 'package:facility_maintenance/Screens/Signin_employee/components/background.dart';
import 'package:facility_maintenance/components/already_have_an_account_acheck.dart';
import 'package:facility_maintenance/components/rounded_button.dart';
import 'package:facility_maintenance/components/rounded_input_field.dart';
import 'package:facility_maintenance/components/rounded_password_field.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.08),
            Text(
              "FIX IT TEAM",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              "SIGN IN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/chat02.png",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your ID",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGN IN",
              press: () {Navigator.of(context).pushNamed('employeehome');},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.08),
            /*OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )*/
          ],
        ),
      ),
    );
  }
}
