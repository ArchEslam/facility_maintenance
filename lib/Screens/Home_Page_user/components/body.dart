import 'package:facility_maintenance/Screens/Home_Page_user/components/background.dart';
import 'package:facility_maintenance/Screens/Login_user/login_screen.dart';
import 'package:facility_maintenance/components/InfoPage.dart';
import 'package:facility_maintenance/data/repositories/shared_preferences.dart';
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
  String selectedBuilding = 'Building No.01';
  MySharedPreferences _mySharedPreferences = sl<MySharedPreferences>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "log out",
          style: Theme.of(context).textTheme.button,
        ),
        icon: Icon(
          Icons.logout,
          color: Colors.black,
        ),
        backgroundColor: kPrimaryLightColor,
        onPressed: () async {
          showAlertDialog(context);
        },
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        Widget buildButton(
            IconData icon, String buttonTitle, String buttonSubTitle) {
          final Color tintColor = Colors.white;
          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  color: kPrimaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Icon(
                            icon,
                            color: tintColor,
                            size: 50.0,
                          )),
                      Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                            child: Column(
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: buttonTitle,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: tintColor)),
                                ),
                                SizedBox(height: size.height * 0.03),
                                RichText(
                                  text: TextSpan(
                                      text: buttonSubTitle,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryLightColor)),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return InfoPage();
                      },
                    ),
                  );
                }, //{Navigator.of(context).pushNamed('user_personal_data');},
                child: buildButton(Icons.person, "Personal Data",
                    "Provide us with your name, email and phone number to contact you."),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/create_gnl_request');
                },
                child: buildButton(
                    Icons.settings,
                    "General Maintenance of Your Facility",
                    "You can request maintenance for any of the public utilities in your building."),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/user_in_sections');
                },
                child: buildButton(
                    Icons.store,
                    "Internal Maintenance of Your Apartment",
                    "You can request maintenance for Plumbing, HVAC and Electricity in your apartment."),
              ),
            ],
          ),
          //orientation == Orientation.portrait ? Text('data') : Text('data'),
        );
      }),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        User user = _mySharedPreferences.getUserData;
        user.token = "";
        Map _lastMapItem = user.toMap();
        Map<String, dynamic> stringQueryParameters =
            _lastMapItem.map((key, value) => MapEntry(key, value?.toString()));
        FirebaseDatabase.instance
            .reference()
            .child("Users")
            .child(_lastMapItem["id"])
            .update(stringQueryParameters)
            .whenComplete(() {
          _mySharedPreferences.setLogedIn(false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return LoginScreen();
              },
            ),
          );
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log out"),
      content: Text("Are you sure you want to log out?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
