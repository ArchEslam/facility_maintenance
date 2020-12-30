import 'package:facility_maintenance/components/rounded_button.dart';
import 'package:facility_maintenance/data/repository.dart';
import 'package:facility_maintenance/model/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../injection_container.dart';

GlobalKey<FormState> formstate = new GlobalKey<FormState>();

// final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
// _showSnackBar(){
//   final snackBar = new SnackBar(
//       content: Row(
//         children: [
//           Icon(Icons.thumb_up),
//           SizedBox(width: 20,),
//           Text('Your data has been saved successfully'),
//         ],
//       ),
//     duration: Duration(seconds: 3),
//     backgroundColor: Colors.green,
//   );
//   _scaffoldKey.currentState.showSnackBar(snackBar);
// }

String validglobal(String val) {
  if (val.trim().isEmpty) {
    return "This field can't be empty";
  }
}

String validusername(String val) {
  if (val.trim().isEmpty) {
    return "This field can't be empty";
  }
}

String validmail(String val) {
  if (val.trim().isEmpty) {
    return "This field can't be empty";
  }
  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(val)) {
    return 'Please provide a valid Email';
  }
}
// bool validmail (bool val) val => ! EmailValidator.validate(val, true)
//     ? 'Please provide a valid email'
//     : null,

String validphone(String val) {
  if (val.trim().isEmpty) {
    return "This field can't be empty";
  }
  if (val.trim().length != 11) {
    return "Your phone must have 11 numbers";
  }
}

class Body extends StatelessWidget {

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  Repository _repository = sl<Repository>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.04),
                Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Provide us with your name, email and phone number to contact you.",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                PersonalDataForm(
                    nameController, emailController, phoneController),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 15),
                //   child: Text(
                //     "You must fill all the previous fields",
                //     style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                SizedBox(height: size.height * 0.08),
                RoundedButton(
                  text: "Save Data",
                  press: () {
                    saveData(context);
                    // Navigator.of(context).pushNamed('userhome');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  saveData(BuildContext context) {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      onChangePersonalData(
          nameController.text, emailController.text, phoneController.text);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.thumb_up),
              SizedBox(
                width: 20,
              ),
              Text('Your data has been saved successfully'),
            ],
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
      // Navigator.of(context).pushNamed('userhome');
    } else {
      print('Not Valid');
    }
  }

  onChangePersonalData(String name, String email, String phone) async {
    User user = _repository.getUserData;
    var updatedItem = FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(user.id.toString());
    updatedItem.update({
      'name': name,
      'mail': email,
      'phone': phone,
    });
  }
}

class PersonalDataForm extends StatefulWidget {
  TextEditingController phoneController;
  TextEditingController emailController;
  TextEditingController nameController;

  PersonalDataForm(
      this.nameController, this.emailController, this.phoneController);

  @override
  _PersonalDataFormState createState() => _PersonalDataFormState();
}

class _PersonalDataFormState extends State<PersonalDataForm> {
  String _phoneHintText = "Enter your phone number";
  String _emailHintText = "Enter your email address";
  String _nameHintText = "Enter your full name";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: formstate,
      child: Column(
        children: [
          buildNameFormField(validusername),
          SizedBox(height: size.height * 0.04),
          buildEmailFormField(validmail),
          SizedBox(height: size.height * 0.04),
          buildPhoneFormField(validphone)
        ],
      ),
    );
  }

  TextFormField buildPhoneFormField(myvalid) {
    return TextFormField(
      controller: widget.phoneController,
      keyboardType: TextInputType.phone,
      validator: myvalid,
      decoration: InputDecoration(
        labelText: "Phone",
        hintText: "$_phoneHintText" /*SharedPreference().getUserPhone()*/,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 42,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        suffixIcon: Icon(Icons.phone_in_talk),
      ),
    );
  }

  TextFormField buildEmailFormField(myvalid) {
    return TextFormField(
      controller: widget.emailController,
      keyboardType: TextInputType.emailAddress,
      validator: myvalid,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "$_emailHintText" /*SharedPreference().getUserMail()*/,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 42,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        suffixIcon: Icon(Icons.mail_outline),
      ),
    );
  }

  TextFormField buildNameFormField(myvalid) {
    return TextFormField(
      controller: widget.nameController,
      keyboardType: TextInputType.name,
      validator: myvalid,
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "$_nameHintText" /*SharedPreference().getUserName()*/,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 42,
          vertical: 20,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: kTextColor)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        suffixIcon: Icon(Icons.insert_emoticon),
      ),
    );
  }
}
