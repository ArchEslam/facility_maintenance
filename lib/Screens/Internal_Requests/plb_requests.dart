import 'package:facility_maintenance/constants.dart';
import 'package:facility_maintenance/data/repositories/shared_preferences.dart';
import 'package:facility_maintenance/model/plb.dart';
import 'package:facility_maintenance/widgets/list_plb_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../injection_container.dart';

class PLBRequests extends StatefulWidget {
  @override
  _PLBRequestsState createState() => _PLBRequestsState();
}

class _PLBRequestsState extends State<PLBRequests> {
  List<PLB> listPLB = [];
  MySharedPreferences _mySharedPreferences = sl<MySharedPreferences>();

  DatabaseReference requestsRef =
      FirebaseDatabase.instance.reference().child("PLB Requests");

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
          title: Text("PLB Requests", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              var nav = await Navigator.of(context).pushNamed("/employee_in_sections");
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
                listPLB.length <= 0
                    ? Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                                //plb.customer,
                                "No Requests Add yet",
                                style: Theme.of(context).textTheme.headline5),
                          ),
                        ),
                      )
                    : ListPLBWidget(
                        listPLB: listPLB,
                        getSelectedValues: ({PLB plb}) {
                          print("selected = ${plb.toMap()}");
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

      listPLB.clear();
      print("previous Id =${_mySharedPreferences.getUserData.id}");
      setState(() {
        for (var individualKey in KEYS) {
          PLB requests =
              new PLB.fromMap(key: individualKey, map: DATA[individualKey]);
          listPLB.add(requests);
        }
      });
    });
  }
}
