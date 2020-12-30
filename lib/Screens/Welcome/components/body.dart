import 'package:facility_maintenance/Screens/Login_user/login_screen.dart';
import 'package:facility_maintenance/Screens/Welcome/components/background.dart';
import 'package:facility_maintenance/components/rounded_button.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return OrientationBuilder(builder: (context, orientation) {
      return Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "WELCOME TO FIX IT",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                width: size.width * 0.95,
                child: Image.asset("assets/images/chat01.png"),
              ),
              SizedBox(height: size.height * 0.02),
              RoundedButton(
                text: "START",
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
