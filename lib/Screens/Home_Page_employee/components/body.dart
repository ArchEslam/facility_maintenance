import 'package:facility_maintenance/Screens/Home_Page_employee/components/background.dart';
import 'package:facility_maintenance/test_Screens/ViewRequests.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
              onTap: () {
                Navigator.of(context).pushNamed('/gnl_requests');
              },
              child: buildButton(
                  Icons.settings,
                  "General Maintenance of All Facilities",
                  "View all costumers' maintenance requests for any of the public utilities in all buildings."),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/employee_in_sections');
              },
              child: buildButton(
                  Icons.store,
                  "Internal Maintenance of All Apartments",
                  "View all costumers' maintenance requests for Plumbing, HVAC and Electricity in all apartments."),
            ),
          ],
        ),
        //orientation == Orientation.portrait ? Text('data') : Text('data'),
      );
    });
  }
}
