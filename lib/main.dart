import 'package:facility_maintenance/Screens/Personal_Data_user/personal_data_user.dart';
import 'package:facility_maintenance/constants.dart';
import 'package:flutter/material.dart';
import 'Screens/Home_Page_employee/home_employee.dart';
import 'Screens/Home_Page_user/home_user.dart';
import 'Screens/Internal_Requests/create_hvac_request.dart';
import 'Screens/Internal_Requests/hvac_requests.dart';
import 'Screens/Internal_Sections_employee/internal_sections_employee.dart';
import 'Screens/Internal_Sections_user/internal_sections_user.dart';
import 'Screens/Welcome/welcome_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FIX IT',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        
      ),
      home: WelcomeScreen(),
      routes: {
            'userhome': (context) {
              return HomeUserScreen();
            },
            'employeehome': (context) {
              return HomeEmployeeScreen();
            },
            'employee_in_sections': (context) {
              return InternalSectionsEmployee();
            },
            'user_in_sections': (context) {
              return InternalSectionsUser();
            },
            'user_personal_data': (context) {
              return PersonalDataScreen();
            },
            'hvac_requests': (context) {
              return HVACRequests();
            },
            'create_hvac_request': (context) {
              return CreateHVACRequest();
            },
            /*'plumbing_requests': (context) {
              return PlumbingRequests();
            },
            'electricity_requests': (context) {
              return ElectricityRequests();
            },*/
            
          },
    );
  }
}
