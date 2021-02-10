import 'package:facility_maintenance/Screens/Login_user/login_screen.dart';
import 'package:facility_maintenance/Screens/Welcome/components/background.dart';
import 'package:facility_maintenance/components/rounded_button.dart';
import 'package:facility_maintenance/data/repositories/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../injection_container.dart';

//import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MySharedPreferences _mySharedPreferences = sl<MySharedPreferences>();

    double height;
    double width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return OrientationBuilder(builder: (context, orientation) {
      return Container(
        height: height,
        width: width,
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "WELCOME TO FIX IT",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * 0.85,
                  child: Image.asset("assets/images/chat01.png"),
                ),
                SizedBox(height: height * 0.02),
                RoundedButton(
                  text: "START",
                  press: () {
                    if (_mySharedPreferences.isLogedIn) {
                      if (_mySharedPreferences.getUserType == Constants.user) {
                        Navigator.of(context).pushNamed('/userhome');
                      } else {
                        Navigator.of(context).pushNamed('/employeehome');
                      }
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    }
                  },
                ),
                /*RoundedButton(
                  text: "SIGN UP",
                  color: kPrimaryLightColor,
                  textColor: Colors.black,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                ),*/
              ],
            ),
          ),
        ),
      );
    });
  }
/*onNavigate(BuildContext context) async {
    var id = await sharedPreference.getUserId();
    print(id.toString() + "iddd");
    if(id.toString() == null || id.toString() == ""|| id.toString() == "null"){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    }else{
      Navigator.of(context).pushNamed('userhome');
    }
  }*/
}
