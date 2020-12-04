import 'package:facility_maintenance/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:facility_maintenance/components/rounded_button.dart';
import '../../../constants.dart';
import 'package:firebase_database/firebase_database.dart';

class Body extends StatelessWidget {
  SharedPreference sharedPreference = SharedPreference();
  TextEditingController phoneController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController nameController=TextEditingController();

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
                PersonalDataForm(nameController,emailController,phoneController),
                SizedBox(height: size.height * 0.08),
                RoundedButton(
                  text: "Save Data",
                  press: () {
                    onChangePersonalData(nameController.text,emailController.text,phoneController.text);
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

  onChangePersonalData(String name,String email,String phone) async {
    var id = await sharedPreference.getUserId();
    var updatedItem = FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(id.toString());
    updatedItem.update({'name': name ,'mail': email,'phone':phone,});
  }
}

class PersonalDataForm extends StatefulWidget {
  TextEditingController phoneController;
  TextEditingController emailController;
  TextEditingController nameController;
  PersonalDataForm(this.nameController,this.emailController,this.phoneController);
  @override
  _PersonalDataFormState createState() => _PersonalDataFormState();
}

class _PersonalDataFormState extends State<PersonalDataForm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Form(
      child: Column(
        children: [
          buildNameFormField(),
          SizedBox(height: size.height * 0.04),
          buildEmailFormField(),
          SizedBox(height: size.height * 0.04),
          buildPhoneFormField()
        ],
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(controller: widget.phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Phone",
        hintText: "Enter your phone number",
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

  TextFormField buildEmailFormField() {
    return TextFormField(controller: widget.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email address",
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

  TextFormField buildNameFormField() {
    return TextFormField(controller: widget.nameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter your full name",
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

/*class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({
    Key key,
    @required this.icon,
  }) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(icon);
  }
}


"Name"
"Enter your full name"
Icons.insert_emoticon


final String labeltext,
    final String hinttext,
    final IconData icon,
*/
