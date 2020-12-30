import 'package:facility_maintenance/Screens/Login_user/login_screen.dart';
import 'package:facility_maintenance/Screens/Signin_employee/components/background.dart';
import 'package:facility_maintenance/SharedPreferences.dart';
import 'package:facility_maintenance/components/already_have_an_account_acheck.dart';
import 'package:facility_maintenance/components/rounded_button.dart';
import 'package:facility_maintenance/components/rounded_input_field.dart';
import 'package:facility_maintenance/components/rounded_password_field.dart';
import 'package:facility_maintenance/data/repository.dart';
import 'package:facility_maintenance/model/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../injection_container.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  SharedPreference sharedPreference = SharedPreference();
  String employeeID = "E001";
  String password = "qwerty";
  String parentDbName = "Employees";
  Repository _repository = sl<Repository>();

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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
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
              onChanged: (value) {
                employeeID = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "SIGN IN",
              press: () {
                onSignIn();
              },
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
          ],
        ),
      ),
    );
  }

  onSignIn() {
    /* final  db = */ FirebaseDatabase.instance
        .reference()
        .child("Employees")
        .orderByChild('id')
        .once()
        .then((DataSnapshot snapshot) {
      //print('Data : ${snapshot.value}');
      Map _map = snapshot.value;
      Map filteredMap = Map.from(_map)..forEach((k, v) => print(v.toString()));
      Iterable _iterable = filteredMap.values;
      Map _mapItems;
      _iterable.forEach((element) async {
        _mapItems = element;
        if (_mapItems["id"] == employeeID &&
            _mapItems["password"] == password) {
          Navigator.of(context).pushNamed('employeehome');
          User user = User.fromMap(_map);
          _repository.saveUserData(user.toJson());
          _repository.setLogedIn(true);
          _repository.setUserType(Constants.employee);
        } else {
          print("Error");
        }

        print(_mapItems["id"]);
      });
    });
    // Navigator.of(context).pushNamed('employeehome');
  }
}
