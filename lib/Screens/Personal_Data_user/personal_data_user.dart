import 'package:flutter/material.dart';
import 'package:facility_maintenance/Screens/Personal_Data_user/components/body.dart';

class PersonalDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Data"),
      ),
      body: Body(),
    );
  }
}
