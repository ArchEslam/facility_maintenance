import 'package:facility_maintenance/constants.dart';
import 'package:flutter/material.dart';

class CreateHVACRequest extends StatefulWidget {
  @override
  _CreateHVACRequestState createState() => _CreateHVACRequestState();
}

class _CreateHVACRequestState extends State<CreateHVACRequest> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title:
              Text("Create a Request", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          elevation: 0,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                height: size.height,
                width: size.width,
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
                    padding: EdgeInsets.fromLTRB(5, 7, 5, 0),
                    height: 65,
                    width: size.width,
                    child: Container(                      
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Write your Request here",
                          filled: true,
                          fillColor: Colors.grey[200],
                            prefixIcon: IconButton(icon:Icon(Icons.camera_alt),onPressed: (){},),
                            suffixIcon: IconButton(icon:Icon(Icons.send),onPressed: (){},),
                            contentPadding: EdgeInsets.all(5),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
