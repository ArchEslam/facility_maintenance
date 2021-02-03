import 'package:facility_maintenance/constants.dart';
import 'package:facility_maintenance/data/repositories/shared_preferences.dart';
import 'package:facility_maintenance/model/gnl.dart';
import 'package:facility_maintenance/widgets/list_gnl_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../injection_container.dart';

class GNLRequests extends StatefulWidget {
  @override
  _GNLRequestsState createState() => _GNLRequestsState();
}

class _GNLRequestsState extends State<GNLRequests> {
  List<GNL> listGNL = [];
  MySharedPreferences _mySharedPreferences = sl<MySharedPreferences>();

  DatabaseReference requestsRef =
      FirebaseDatabase.instance.reference().child("GNL Requests");

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
          title: Text("GNL Requests", style: TextStyle(color: Colors.white)),
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
                listGNL.length <= 0
                    ? Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                                //gnl.customer,
                                "No Requests Add yet",
                                style: Theme.of(context).textTheme.headline5),
                          ),
                        ),
                      )
                    : ListGNLWidget(
                        listGNL: listGNL,
                        getSelectedValues: ({GNL gnl}) {
                          print("selected = ${gnl.toMap()}");
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

      listGNL.clear();
      print("previous Id =${_mySharedPreferences.getUserData.id}");
      setState(() {
        for (var individualKey in KEYS) {
          GNL requests =
              new GNL.fromMap(key: individualKey, map: DATA[individualKey]);
          listGNL.add(requests);
        }
      });
    });
  }
}
