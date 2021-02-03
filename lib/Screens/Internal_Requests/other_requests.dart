import 'package:facility_maintenance/constants.dart';
import 'package:facility_maintenance/data/repositories/shared_preferences.dart';
import 'package:facility_maintenance/model/other.dart';
import 'package:facility_maintenance/widgets/list_other_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../injection_container.dart';

class OTHERRequests extends StatefulWidget {
  @override
  _OTHERRequestsState createState() => _OTHERRequestsState();
}

class _OTHERRequestsState extends State<OTHERRequests> {
  List<OTHER> listOTHER = [];
  MySharedPreferences _mySharedPreferences = sl<MySharedPreferences>();

  DatabaseReference requestsRef =
      FirebaseDatabase.instance.reference().child("OTHER Requests");

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
          title: Text("OTHER Requests", style: TextStyle(color: Colors.white)),
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
                listOTHER.length <= 0
                    ? Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                                //other.customer,
                                "No Requests Add yet",
                                style: Theme.of(context).textTheme.headline5),
                          ),
                        ),
                      )
                    : ListOTHERWidget(
                        listOTHER: listOTHER,
                        getSelectedValues: ({OTHER other}) {
                          print("selected = ${other.toMap()}");
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

      listOTHER.clear();
      print("previous Id =${_mySharedPreferences.getUserData.id}");
      setState(() {
        for (var individualKey in KEYS) {
          OTHER requests =
              new OTHER.fromMap(key: individualKey, map: DATA[individualKey]);
          listOTHER.add(requests);
        }
      });
    });
  }
}
