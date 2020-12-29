import 'package:facility_maintenance/constants.dart';
import 'package:flutter/material.dart';

class HVACRequests extends StatefulWidget {
  @override
  _HVACRequestsState createState() => _HVACRequestsState();
}

class _HVACRequestsState extends State<HVACRequests> {
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
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text("Essam"),
                  ),
                  trailing: Icon(Icons.filter_list),
                  isThreeLine: true,
                  subtitle: Text(
                      "I have a problem with the air-conditioner in the reception hall, as it is dropping water from it."),
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.5),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(border:Border(right: BorderSide(color: Colors.grey.withOpacity(0.5)))),
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                      child: Text(
                        "Cost: N/A",
                        style: TextStyle(fontSize: 15),                        
                        textAlign: TextAlign.center,
                      ),
                    )),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: CheckboxListTile(
                          title: Text(
                            "Solved?",                            
                            textAlign: TextAlign.end,
                          ),
                          //secondary: Icon(Icons.build,color: kPrimaryColor,),
                          controlAffinity: ListTileControlAffinity.platform,
                          value: checkedBoxValue,
                          activeColor: kPrimaryColor,
                          checkColor: Colors.black,
                          onChanged: (bool value) {
                            setState(() {
                              checkedBoxValue = value;
                            });
                          }),
                    )),
                  ],
                )
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text("Waleed"),
                  ),
                  trailing: Icon(Icons.filter_list),
                  isThreeLine: true,
                  subtitle: Text(
                      "My air-conditioner of the Master Bedroom, as it is work well."),
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.5),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(border:Border(right: BorderSide(color: Colors.grey.withOpacity(0.5)))),
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                          child: Text(
                            "Cost: N/A",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: CheckboxListTile(
                              title: Text(
                                "Solved?",
                                textAlign: TextAlign.end,
                              ),
                              //secondary: Icon(Icons.build,color: kPrimaryColor,),
                              controlAffinity: ListTileControlAffinity.platform,
                              value: checkedBoxValue,
                              activeColor: kPrimaryColor,
                              checkColor: Colors.black,
                              onChanged: (bool value) {
                                setState(() {
                                  checkedBoxValue = value;
                                });
                              }),
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


