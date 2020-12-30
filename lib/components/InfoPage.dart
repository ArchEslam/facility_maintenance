import 'dart:async';

import 'package:facility_maintenance/Screens/Personal_Data_user/components/body.dart';
import 'package:facility_maintenance/SharedPreferences.dart';
import 'package:facility_maintenance/components/rounded_button.dart';
import 'package:facility_maintenance/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreference sharedPreference = SharedPreference();

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => new _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  savePref()async{
    await  sharedPreference.addUserName(_infoName);
    await  sharedPreference.addUserPhone(_infoPhone);
    await  sharedPreference.addUserMail(_infoMail);
    await  sharedPreference.addUserFlat(_infoFlat);
  }

  StreamSubscription __subscriptionInfo;

  String _infoName = "Display the info name here";
  String _infoPhone = "Display the info phone here";
  String _infoMail = "Display the info mail here";
  String _infoBuilding = "Display the info building here";
  String _infoFlat = "Display the info flat here";

  @override
  void initState() {
    //FirebaseInfos.getInfo("-KriJ8Sg4lWIoNswKWc4").then(_updateInfo);

    FirebaseInfos.getInfoStream("-KriJ8Sg4lWIoNswKWc4", _updateInfo)
        .then((StreamSubscription s) => __subscriptionInfo = s);
    super.initState();
  }

  @override
  void dispose() {
    if (__subscriptionInfo != null) {
      __subscriptionInfo.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var nameItemTile = new ListTile(
      title: Center(child: new Text("$_infoName",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
    );
    var phoneItemTile = new ListTile(
      title: Center(child: new Text("$_infoPhone",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
    );
    var mailItemTile = new ListTile(
      title: Center(child: new Text("$_infoMail",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
    );
    var buildingItemTile = new ListTile(
      title: Center(child: new Text("$_infoBuilding",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
    );
    var flatItemTile = new ListTile(
      title: Center(child: new Text("$_infoFlat",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),)),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Personal Data"),
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0,15.0,15.0,0),
            child: Text('Your name is:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kPrimaryColor),),
          ),
          nameItemTile,
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0,15.0,15.0,0),
            child: Text('Your phone number is:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kPrimaryColor),),
          ),
          phoneItemTile,
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0,15.0,15.0,0),
            child: Text('Your mail address is:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kPrimaryColor),),
          ),
          mailItemTile,
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0,15.0,15.0,0),
            child: Text('Your building number is:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kPrimaryColor),),
          ),
          buildingItemTile,
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0,15.0,15.0,0),
            child: Text('Your apartment number is:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kPrimaryColor),),
          ),
          flatItemTile,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RoundedButton(
              text: "Edit Your Data",
              press: () {
                Navigator.of(context).pushNamed('user_personal_data');
              },
            ),
          )
        ],
      ),
    );
  }


  _updateInfo(Info value) {
    var name = value.name;
    var phone = value.phone;
    var mail = value.mail;
    var building = value.building;
    var flat = value.flat;
    setState((){
      _infoName = name ;
      _infoPhone = phone;
      _infoMail = mail;
      _infoBuilding = building;
      _infoFlat = flat;
    });
  }
}


class Info {
  final String key;
  String name;
  String phone;
  String mail;
  String building;
  String flat;

  Info.fromJson(this.key, Map data) {
    name = data['name'];
    if (name == null) {
      name = '';
    }
    phone = data['phone'];
    if (phone == null) {
      phone = '';
    }
    mail = data['mail'];
    if (mail == null) {
      mail = '';
    }
    building = data['building'];
    if (building == null) {
      building = '';
    }
    flat = data['flat'];
    if (flat == null) {
      flat = '';
    }

  }
}



class FirebaseInfos {
  /// FirebaseInfos.getInfoStream("-KriJ8Sg4lWIoNswKWc4", _updateInfo)
  /// .then((StreamSubscription s) => __subscriptionInfo = s);
  static Future<StreamSubscription<Event>> getInfoStream(String UserKey,
      void onData(Info info)) async {
    //String UserKey = await Preferences.getUserKey();
    var id = await sharedPreference.getUserId();


    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(id.toString())
        .onValue
        .listen((Event event) {
      var info = new Info.fromJson(event.snapshot.key, event.snapshot.value);
      onData(info);
    });

    return subscription;
  }


  static Future<Info> getInfo(String UserKey) async {
    Completer<Info> completer = new Completer<Info>();

    //String UserKey = await Preferences.getUserKey();
    var id = await sharedPreference.getUserId();

    FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(id.toString())
        .once()
        .then((DataSnapshot snapshot) {
      var info = new Info.fromJson(snapshot.key, snapshot.value);
      completer.complete(info);
    });

    return completer.future;
  }
}



// class Preferences {
//   static const String USER_KEY = "UserKey";
//
//   static Future<bool> setUserKey(String UserKey) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString(USER_KEY, UserKey);
//     return prefs.commit();
//   }
//
//   static Future<String> getUserKey() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String UserKey = prefs.getString(USER_KEY);
//
//     // workaround - simulate a login setting this
//     if (UserKey == null) {
//       UserKey = "00101B01";
//     }
//
//     return UserKey;
//   }
// }

