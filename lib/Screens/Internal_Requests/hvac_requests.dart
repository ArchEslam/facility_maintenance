import 'package:facility_maintenance/constants.dart';
import 'package:facility_maintenance/data/repositories/shared_preferences.dart';
import 'package:facility_maintenance/model/hvac.dart';
import 'package:facility_maintenance/widgets/list_hvac_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../injection_container.dart';

class HVACRequests extends StatefulWidget {
  @override
  _HVACRequestsState createState() => _HVACRequestsState();
}

class _HVACRequestsState extends State<HVACRequests> {
  List<HVAC> listHVAC = [];
  MySharedPreferences _mySharedPreferences = sl<MySharedPreferences>();

  DatabaseReference requestsRef =
      FirebaseDatabase.instance.reference().child("HVAC Requests");

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool checkedBoxValue = false;
    return Scaffold(
        appBar: AppBar(
          title: Text("HVAC Requests", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              var nav = await Navigator.of(context)
                  .pushNamed("/employee_in_sections");
              if (nav == true || nav == null) {
                //change the state
              }
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                listHVAC.length <= 0
                    ? Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                                //hvac.customer,
                                "No Requests Add yet",
                                style: Theme.of(context).textTheme.headline5),
                          ),
                        ),
                      )
                    : ListHVACWidget(
                        listHVAC: listHVAC,
                        getSelectedValues: ({HVAC hvac}) {
                          print("selected = ${hvac.toMap()}");
                        },
                        onCheckedValue: (bool value) {},
                        userType: Constants.employee,
                      ),
                // hcvDataSnapshot(context)
              ],
            ),
          ),
        ));
  }

  getData() {
    requestsRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      listHVAC.clear();
      print("previous Id =${_mySharedPreferences.getUserData.id}");
      setState(() {
        for (var individualKey in KEYS) {
          HVAC requests =
              new HVAC.fromMap(key: individualKey, map: DATA[individualKey]);
          listHVAC.add(requests);
        }
      });
    });
  }
}
