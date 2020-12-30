import 'package:facility_maintenance/Screens/Internal_Sections_user/components/background.dart';
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
      Widget buildButton2(String imagePath, String buttonTitle) {
        final Color tintColor = Colors.white;

        return ClipRRect(
          borderRadius: BorderRadius.circular(29),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            color: kPrimaryColor,
            height: size.height,
            child: Column(
              children: [
                Expanded(flex: 15, child: Image.asset(imagePath)),
                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                    flex: 4,
                    child: Text(
                      buttonTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: tintColor,
                        fontSize: 25,
                      ),
                    )),
              ],
            ),
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: Text("Choose the relevant department",
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushNamed('userhome');
              }),
        ),
        body: Background(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ListView(
              children: [
                Container(
                  height: orientation == Orientation.portrait
                      ? size.height * .88
                      : size.width * .73,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 20,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () {},
                                  child: buildButton2(
                                      "assets/images/elec.png", "Electricity"),
                                )),
                            Expanded(flex: 2, child: Container()),
                          ],
                        ),
                      ),
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 20,
                        child: Row(
                          children: [
                            Expanded(flex: 2, child: Container()),
                            Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('create_hvac_request');
                                  },
                                  child: buildButton2(
                                      "assets/images/hvac.png", "HVAC"),
                                )),
                          ],
                        ),
                      ),
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 20,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () {},
                                  child: buildButton2(
                                      "assets/images/plumbing.png", "Plumbing"),
                                )),
                            Expanded(flex: 2, child: Container()),
                          ],
                        ),
                      ),
                      Expanded(flex: 1, child: SizedBox()),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //orientation == Orientation.portrait ? Text('data') : Text('data'),
        ),
      );
    });
  }
}
