//import 'dart:html';


import 'package:flutter/material.dart';
import 'package:facility_maintenance/Screens/Login_user/login_screen.dart';
import 'package:facility_maintenance/Screens/Welcome/components/background.dart';
import 'package:facility_maintenance/components/rounded_button.dart';

//import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return OrientationBuilder(builder: (context, orientation) {
      return Background(
        child: orientation == Orientation.portrait
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "WELCOME TO FIX IT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
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
              )
            : SingleChildScrollView(
                child: Row(                  
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[                        
                        SizedBox(
                          width: size.width*0.5,
                          height: size.height * 0.07),
                        Container(
                            width: size.width*0.5,
                            height: size.height*0.85,
                            child: Image.asset("assets/images/chat.png"),
                          ),
                        //SizedBox(height: size.height * 0.02),                        
                      ],
                    ),
                    Column(                      
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "WELCOME TO FIX IT",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Container(
                          width: size.width*0.5,
                          height: size.height*0.5,
                          child: Image.asset("assets/images/chat02.png"),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Container(
                          width: size.width*0.3,
                          child: RoundedButton(
                            text: "LOGIN",
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
                  ],
                ),
              ),
      );
    });
  }
}
