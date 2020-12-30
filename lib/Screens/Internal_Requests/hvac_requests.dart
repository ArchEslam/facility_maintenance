import 'package:facility_maintenance/constants.dart';
import 'package:facility_maintenance/data/repository.dart';
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
  int _customerID = 1;
  Repository _repository = sl<Repository>();

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
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                listHVAC.length == 0
                    ? Container()
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
      print("KEYS ============ ${snap.toString()}");

      listHVAC.clear();
      for (var individualKey in KEYS) {
        if (DATA[individualKey]['customerID'] == _repository.getUserData.id) {
          HVAC requests =
              new HVAC.fromMap(key: individualKey, map: DATA[individualKey]);
          setState(() {
            listHVAC.add(requests);
          });
        }

        // }

      }
      print("listHVAC.length =${listHVAC.length}");
    });
  }
}
