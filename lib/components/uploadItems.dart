// import 'dart:io';
// import 'package:facility_maintenance/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
//
// class UploadPage extends StatefulWidget {
//   @override
//   _UploadPageState createState() => _UploadPageState();
// }
//
// class _UploadPageState extends State<UploadPage> with AutomaticKeepAliveClientMixin<UploadPage>
// {
//   bool get wantKeepAlive => throw UnimplementedError();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
//
//   displayUserRequestScreen()
//   {
//     return Scaffold(
//       appBar: AppBar(
//         title:Text("Create a request", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: kPrimaryColor,
//         elevation: 0,
//         leading: IconButton(
//             icon: Icon(Icons.border_color,color: Colors.white),
//             onPressed: ()
//             {
//
//             }
//         ),
//       ),
//     )
//   }
//
// }


///////////////////////////////// BACK UP OF create_hvac_request //////////////////////////////////////

import 'dart:io';
import 'dart:async';
import 'package:facility_maintenance/components/loadingWidget.dart';
import 'package:facility_maintenance/constants.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:facility_maintenance/SharedPreferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

SharedPreference sharedPreference =SharedPreference();

class CreateHVACRequest extends StatefulWidget {
  @override
  _CreateHVACRequestState createState() => _CreateHVACRequestState();
}

class _CreateHVACRequestState extends State<CreateHVACRequest> {

  File file;

  TextEditingController _detailsTextEditingController =TextEditingController();
  TextEditingController _priceTextEditingController =TextEditingController();
  String _requestId = DateTime.now().millisecondsSinceEpoch.toString();
  String _requestDate = DateTime.now().toString();
  String _documentId = "HVAC";
  String _price = "The price has not yet been determined";
  bool uploading = false;

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
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: clearInfo),
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
                  child: Column(
                    children: [
                      // uploading ? linearProgress() : Text(""),
                      // Container(
                      //   height: 230,
                      //   width: size.width*0.8,
                      //   child: Center(
                      //     child: AspectRatio(
                      //       aspectRatio: 16/9,
                      //       child: Container(
                      //         decoration: BoxDecoration(image: DecorationImage(image: FileImage(file),fit: BoxFit.cover)),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
                        padding: EdgeInsets.fromLTRB(5, 7, 5, 0),
                        height: 65,
                        width: size.width,
                        child: Container(
                          child: TextFormField(
                            controller: _detailsTextEditingController,
                            decoration: InputDecoration(
                                hintText: "Write your Request here",
                                filled: true,
                                fillColor: Colors.grey[200],
                                prefixIcon: IconButton(icon:Icon(Icons.camera_alt),onPressed: (){takeImage(context);},),
                                suffixIcon: IconButton(icon:Icon(Icons.send),
                                  onPressed:uploading ? null : ()=> uploadImageAndSaveItemInfo(),
                                  //{Navigator.of(context).pushNamed('userhome');},
                                ),
                                contentPadding: EdgeInsets.all(5),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                        ),
                      ),
                    ],
                  )),
              Positioned(
                  child: Container(
                    width: MediaQuery.of(context).size.width-20,
                    height: MediaQuery.of(context).size.height-150,
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                title:Row(
                                  children: [
                                    Icon(Icons.person,color: kPrimaryColor,),
                                    SizedBox(width: 8,),
                                    Text('Eslam El Sherif',style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                subtitle: Container(
                                  margin: EdgeInsets.only(top: 8),
                                  padding: const EdgeInsets.all(10),
                                  color: Colors.grey[100],
                                  child: Text("Request Description",style: TextStyle(color: Colors.black),),
                                ),
                              ),

                            ],
                          )
                      ),
                    ),
                  ))

            ],
          ),
        ));
  }

  takeImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (con)
        {
          return SimpleDialog(
            title: Text("Image of your request",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            children: [
              SimpleDialogOption(
                child: Text("Capture with Camera",style: TextStyle(color: kPrimaryColor),),
                onPressed: capturePhotoWithCamera,
              ),
              SimpleDialogOption(
                child: Text("Select from Gallery",style: TextStyle(color: kPrimaryColor),),
                onPressed: pickPhotoFromGallery,
              ),
              SimpleDialogOption(
                child: Text("Cancel",style: TextStyle(color: kPrimaryColor),),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
  }

  capturePhotoWithCamera() async
  {
    Navigator.pop(context);
    final imagefile = await ImagePicker().getImage(source: ImageSource.camera,maxHeight: 680.0,maxWidth: 970.0);

    setState(() {
      file = File (imagefile.path);
    });
  }

  pickPhotoFromGallery() async
  {
    Navigator.pop(context);
    final imagefile = await ImagePicker().getImage(source: ImageSource.gallery,);

    setState(() {
      file = File(imagefile.path);
    });
  }

  clearInfo()
  {
    setState(() {
      file = null;
      _detailsTextEditingController.clear();
    });
  }

  uploadImageAndSaveItemInfo() async
  {
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl = await uploadItemImage(file);

    saveItemInfo(imageDownloadUrl);
  }
  Future<String> uploadItemImage(mFileImage) async
  {
    final Reference  reference = FirebaseStorage.instance.ref().child("$_documentId Items");
    UploadTask uploadTask = reference.child("request_$_requestId.jpg").putFile(mFileImage);
    String downloadUrl = await (await uploadTask).ref.getDownloadURL();
    return downloadUrl;
  }

  saveItemInfo(String downloadUrl)
  async {
    String customerName = await sharedPreference.getUserName();
    String customerBuilding = await sharedPreference.getUserBldg();
    String customerFlat = await sharedPreference.getUserFlat();
    String customerPhone = await sharedPreference.getUserPhone();


    final itemsRef = FirebaseFirestore.instance.collection("$_documentId Items");
    itemsRef.doc(_requestId).set({
      "description": _detailsTextEditingController.text.trim(),
      "date": _requestDate.trim(),
      // "customer": customerName,
      // "phone":customerPhone,
      // "building": customerBuilding.trim(),
      // "flat": customerFlat.trim(),
      // "price": _price.trim(),
    });

    setState(() {
      file = null;
      uploading = false;
      _requestId = DateTime.now().millisecondsSinceEpoch.toString();
      _detailsTextEditingController.clear();
    });
  }
}


