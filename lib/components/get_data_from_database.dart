import 'package:facility_maintenance/SharedPreferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Data.dart';

class GetPersonalData extends StatefulWidget {
  @override
  _GetPersonalDataState createState() => _GetPersonalDataState();
}

class _GetPersonalDataState extends State<GetPersonalData> {
  List<Data> dataList = [];
  SharedPreference sharedPreference = SharedPreference();

  @override
  void initState() {
    super.initState();
    //var id = sharedPreference.getUserId();
    DatabaseReference refrenceData = FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child('00101B01'); //id.toString()
    refrenceData.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
      dataList.clear();
      var keys = snapshot.value.keys;
      var values = snapshot.value;

      for (var key in keys) {
        Data data = new Data(
          values[key]["name"],
          values[key]["phone"],
          values[key]["mail"],
          values[key]["building"],
          values[key]["flat"],
        );
        dataList.add(data);
      }
      setState(() {
        //
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: dataList.length == 0
            ? Center(
                child: Text(
                "No Data Available",
                style: TextStyle(fontSize: 30),
              ))
            : ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (_, index) {
                  return CardUI(
                      dataList[index].name,
                      dataList[index].phone,
                      dataList[index].mail,
                      dataList[index].building,
                      dataList[index].flat);
                }));
  }

  Widget CardUI(
      String name, String phone, String mail, String building, String flat) {
    return Card(
      margin: EdgeInsets.all(15),
      color: Colors.black,
      child: Container(
        color: Colors.grey,
        margin: EdgeInsets.all(1.5),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 2,
            ),
            Text(
              "Your Name is: $name",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Your Name is: $phone",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Your Name is: $mail",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Your Name is: $building",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Your Name is: $flat",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}
