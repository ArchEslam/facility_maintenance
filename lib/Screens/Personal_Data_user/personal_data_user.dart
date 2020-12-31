import 'package:facility_maintenance/Screens/Personal_Data_user/components/body.dart';
import 'package:flutter/material.dart';

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
