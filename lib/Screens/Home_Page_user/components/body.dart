import 'package:flutter/material.dart';
import 'package:facility_maintenance/Screens/Home_Page_user/components/background.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String selectedBuilding = 'Building No.01';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return OrientationBuilder(builder: (context, orientation) {
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
              onTap: (){Navigator.of(context).pushNamed('user_personal_data');},
              child: buildButton(Icons.person, "Personal Data",
                  "Provide us with your name, email and phone number to contact you."),
            ),
            InkWell(
              onTap: (){},
              child: buildButton(Icons.settings, "General Maintenances of Your Facility",
                  "You can request maintenance for any of the public utilites in your building."),
            ),
            InkWell(
              onTap: (){Navigator.of(context).pushNamed('user_in_sections');},
              child: buildButton(Icons.store, "Internal Maintenances of Your Appartment",
                  "You can request maintenance for Plumbing, HVAC and Electricity in your appartment."),
            ),
          ],
        ),
        //orientation == Orientation.portrait ? Text('data') : Text('data'),
      );
    });
  }
}
