import 'package:flutter/material.dart';
import 'package:facility_maintenance/Screens/Login_user/components/background.dart';
import 'package:facility_maintenance/Screens/Signin_employee/signin_screen.dart';
import 'package:facility_maintenance/components/already_have_an_account_acheck.dart';
import 'package:facility_maintenance/components/rounded_button.dart';
import 'package:facility_maintenance/components/rounded_input_field.dart';
import 'package:facility_maintenance/components/rounded_password_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../SharedPreferences.dart';
import '../../../constants.dart';

class Body extends StatefulWidget {

  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // final _userid;
  SharedPreference sharedPreference = SharedPreference();

  String selectedBuilding = 'Building No.01';
  String userID;
  String password;
  String parentDbName = "Users";
  // String _userName;
  //
  // String get userName=> _userName;





  // void getUserData()async{
  //   final userdata= await db.parentDbNam ;
  // }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return OrientationBuilder(builder: (context, orientation) {
      return Background(
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              Image.asset(
                "assets/images/chat02.png",
                height: size.height * 0.25,
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
                      child: Icon(
                        Icons.account_balance,
                        color: kPrimaryColor,
                      ),
                    ),
                    Text(
                      'Your Building is: ',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          color: kPrimaryColor,
                        ),
                        elevation: 0,
                        value: selectedBuilding,
                        items: [
                          DropdownMenuItem(
                              child: Text('Building No.01'),
                              value: 'Building No.01'),
                          DropdownMenuItem(
                              child: Text('Building No.02'),
                              value: 'Building No.02'),
                          DropdownMenuItem(
                              child: Text('Building No.03'),
                              value: 'Building No.03'),
                          DropdownMenuItem(
                              child: Text('Building No.04'),
                              value: 'Building No.04'),
                          DropdownMenuItem(
                              child: Text('Building No.05'),
                              value: 'Building No.05'),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedBuilding = value;
                          });
                        }),
                  ],
                ),
              ),
              RoundedInputField(
                hintText: "Your ID",
                onChanged: (value) {
                  userID=value;
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  password=value;
                },
              ),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  onLogin();

                  // Navigator.of(context).pushNamed('userhome');
                  // print(selectedBuilding);
                  // print(userID);
                  // print(password);
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignInScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],)
      );
    });
  }
  onLogin(){
   /* final  db = */FirebaseDatabase.instance.reference().child("Users").orderByChild('id').once().then((DataSnapshot snapshot) {
      //print('Data : ${snapshot.value}');
      Map _map =snapshot.value;
      Map filteredMap = Map.from(_map)..forEach((k, v) => print(v.toString()));
      Iterable _iterable =filteredMap.values;
      Map _mapItems ;
      _iterable.forEach((element) async {
        _mapItems=element;
        if(_mapItems["id"] == userID && _mapItems["password"] == password &&_mapItems["building"] == selectedBuilding)
          Navigator.of(context).pushNamed('userhome');
         await  sharedPreference.addUserId(userID);
         await  sharedPreference.addUserBldg(selectedBuilding);
        // print(_mapItems["name"]);
        // print(_mapItems["phone"]);
        // print(_mapItems["mail"]);
        // print(_mapItems["flat"]);

        //await  sharedPreference.addUserName(userName);

        //print(_mapItems["id"]);


      });
    });
   // Navigator.of(context).pushNamed('userhome');

  }
}

