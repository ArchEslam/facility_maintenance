import 'package:facility_maintenance/test_Screens/Requests.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ViewRequests extends StatefulWidget {
  @override
  _ViewRequestsState createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests>
{
  List<Requests> requestsList = [];

  @override
  void initState()
  {
    super.initState();

    DatabaseReference requestsRef = FirebaseDatabase.instance.reference().child("HVAC Requests");
    requestsRef.once().then((DataSnapshot snap)
    {
      var KEYS =snap.value.keys;
      var DATA =snap.value;

      requestsList.clear();
      print(DATA);

      for(var individualKey in KEYS)
        {
          Requests requests = new Requests
            (
              DATA[individualKey]['building'],
              DATA[individualKey]['customer'],
              DATA[individualKey]['customerID'],
              DATA[individualKey]['date'],
              DATA[individualKey]['description'],
              DATA[individualKey]['employeeName'],
              DATA[individualKey]['flat'],
              DATA[individualKey]['isSolved'],
              DATA[individualKey]['phone'],
              DATA[individualKey]['price'],
              DATA[individualKey]['thumbnailUrl'],
            );

          requestsList.add(requests);
        }

      setState(()
      {
        print('Length : $requestsList.length');
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar
        (title: new Text("Requests List"),),

      body: new Container(
        child: requestsList.length == 0 ? new Text("No Requests availabe") : new ListView.builder
          (
            itemCount: requestsList.length,
            itemBuilder: (_, index)
          {
            return RequestsUI(requestsList[index].building, requestsList[index].customer, requestsList[index].customerID, requestsList[index].date, requestsList[index].description, requestsList[index].employeeName, requestsList[index].flat, requestsList[index].isSolved, requestsList[index].phone, requestsList[index].price, requestsList[index].thumbnailUrl);
          },
        ),

      ),
    );
  }

  Widget RequestsUI(String building, String customer, String customerID, String date, String description, String employeeName, String flat, bool isSolved, String phone, String price, String thumbnailUrl)
  {
    return new Card(
      elevation: 10,
      margin: EdgeInsets.all(15),

      child: new Container(
        padding: new EdgeInsets.all(14),

        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: <Widget>
          [
            new Text(
              date,
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
            Row(
              children: [
                new Text(
                  building,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 10,),
                new Text(
                  "Customer ID: $customerID",
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 10,),
            new Image.network(thumbnailUrl, fit: BoxFit.cover),
            SizedBox(height: 10,),
            Row(
              children: [
                new Text(
                  "Customer Name :$customer",
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 15,),
                new Text(
                  "Customer Phone :$phone",
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            SizedBox(height: 10,),
            new Text(
              description,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            new Text(
              "Price: $price",
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            new Text(
              "Employee Name: $employeeName",
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            new Text(
              "Is Solved: $isSolved",
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),

          ],
        ),
      ),
    );
  }
}
