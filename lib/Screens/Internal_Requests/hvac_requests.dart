import 'package:facility_maintenance/constants.dart';
import 'package:facility_maintenance/model/hvac.dart';
import 'package:facility_maintenance/widgets/list_hvac_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HVACRequests extends StatefulWidget {
  @override
  _HVACRequestsState createState() => _HVACRequestsState();
}

class _HVACRequestsState extends State<HVACRequests> {

  List<HVAC> listHVAC=[];
 int _customerID=1;
  DatabaseReference requestsRef = FirebaseDatabase.instance.reference().child("HVAC Requests");
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
              listHVAC.length==0?
              Container():
              ListHVACWidget(
                listHVAC:listHVAC,
                getSelectedValues:({HVAC hvac}){
                  print("selected = ${hvac.toMap()}");
                },
                onCheckedValue: (bool value){

                },
                userType: Constants.employee,
              ),
              // hcvDataSnapshot(context)
            ],
          ),
        ),
      ));
  }

  getData(){
    requestsRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      print("KEYS ============ ${snap.toString()}");

      listHVAC.clear();
      for (var individualKey in KEYS) {

         // HVAC requests = new HVAC.fromMap(DATA[individualKey]);
        HVAC requests = new HVAC(
          key:individualKey,
          building:DATA[individualKey]['building'],
          customer: DATA[individualKey]['customer'],
          customerId: DATA[individualKey]['customerID'],
          date: DATA[individualKey]['date'],
          description: DATA[individualKey]['description'],
          employeeName: DATA[individualKey]['employeeName'],
          flat:DATA[individualKey]['flat'],
          isSolved: DATA[individualKey]['isSolved'],
          phone: DATA[individualKey]['phone'],
          price:DATA[individualKey]['price'],
          thumbnailUrl:  DATA[individualKey]['thumbnailUrl'],);
          setState(() {
            listHVAC.add(requests);

          });
       // }

      }
      print("listHVAC.length =${listHVAC.length}");
    });
  }
}


