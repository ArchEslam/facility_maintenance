import 'dart:io';
import 'package:facility_maintenance/components/loadingWidget.dart';
import 'package:facility_maintenance/components/rounded_button.dart';
import 'package:facility_maintenance/constants.dart';
import 'package:facility_maintenance/model/hvac.dart';
import 'package:facility_maintenance/widgets/listHVACWidget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:facility_maintenance/SharedPreferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:material_dialog/material_dialog.dart';

SharedPreference sharedPreference =SharedPreference();

class CreateHVACRequest extends StatefulWidget {
  @override
  _CreateHVACRequestState createState() => _CreateHVACRequestState();
}

class _CreateHVACRequestState extends State<CreateHVACRequest> with AutomaticKeepAliveClientMixin<CreateHVACRequest>
{
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  bool get wantKeepAlive => true;

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
    return file == null ? displayUserRequestScreen() : displayRequestCreationScreen();
  }

  displayUserRequestScreen()
  {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title:
          Text("Your Requests", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.of(context).pushNamed('user_in_sections');}),
        ),
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height*.05,
                  ),
                  SizedBox(
                    width: size.width,
                    child: Image.asset("assets/images/flame.png"),
                  ),
                  SizedBox(
                    height: size.height*.05,
                  ),
                  RoundedButton(
                    text: "Add New Request",
                    press: () {takeImage(context);},
                  ),
                  RoundedButton(
                    text: "Your Previous Requests",
                    press: () async{
                      _showHVACrequets(context);

                    },
                  ),
                ],
              ),
            ),
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

  displayRequestCreationScreen()
  {
    return Scaffold(
      appBar: AppBar(
        title:
        Text("New Request", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        elevation: 0,
        // leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: displayUserRequestScreen),
      ),
      body: ListView(
        children: [
          uploading ? linearProgress() : Text(""),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width*0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(image: DecorationImage(image: FileImage(file),fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 12)),
          ListTile(
            leading: Icon(Icons.add_comment,color: kPrimaryColor,),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(color: Colors.black,),
                controller: _detailsTextEditingController,
                decoration: InputDecoration(
                  hintText: 'Request Details',
                  hintStyle: TextStyle(color: Colors.grey[700],),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(color: kPrimaryColor,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: RoundedButton(
              text: "Add",
              press:  uploading ? null : ()=> uploadImageAndSaveItemInfo(),
            ),
          ),
          // SizedBox(height: MediaQuery.of(context).size.width*0.2,),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  child: Text('Thank You! After leaving the request, our team will contact you shortly.',style: TextStyle(fontWeight: FontWeight.bold),)),),
          )
        ],
      ),


    );
  }

  clearInfo()
  {
    setState(() {
      file = null;
      uploading = false;
      _requestId = DateTime.now().millisecondsSinceEpoch.toString();
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
    try{
      final Reference  reference = FirebaseStorage.instance.ref().child("$_documentId Items");
      UploadTask uploadTask = reference.child("request_$_requestId.jpg").putFile(mFileImage);
      String downloadUrl = await (await uploadTask).ref.getDownloadURL();
      return downloadUrl;

    }catch(e){
      print("Uploading xception =${e.toString()}");
    }

  }

  saveItemInfo(String downloadUrl) async {
    var customerID = await sharedPreference.getUserId();
    var customerName = await sharedPreference.getUserName();
    var customerBuilding = await sharedPreference.getUserBldg();
    var customerFlat = await sharedPreference.getUserFlat();
    var customerPhone = await sharedPreference.getUserPhone();

    var setItem = FirebaseDatabase.instance
        .reference()
        .child("$_documentId Requests")
        .child(_requestId).set({
          "customer ID": customerID.toString(),
          "description": _detailsTextEditingController.text.trim(),
          "date": _requestDate.trim(),
          "customer": customerName,
          "phone":customerPhone,
          "building": customerBuilding.trim(),
          "flat": customerFlat.trim(),
          "price": _price.trim(),
          "employeeName":"N/A",
          "is solved":false,
          "thumbnailUrl": downloadUrl,
    });
    setState(() {
      file = null;
      uploading = false;
      _requestId = DateTime.now().millisecondsSinceEpoch.toString();
      _detailsTextEditingController.clear();
    });

  // saveItemInfo(String downloadUrl)
  // async {

  //   String customerName = await sharedPreference.getUserName();
  //   String customerBuilding = await sharedPreference.getUserBldg();
  //   String customerFlat = await sharedPreference.getUserFlat();
  //   String customerPhone = await sharedPreference.getUserPhone();
  //   final itemsRef = FirebaseFirestore.instance.collection("$_documentId Requests");
  //   itemsRef.doc(_requestId).set({
  //     "customer ID": customerID.toString(),
  //     "description": _detailsTextEditingController.text.trim(),
  //     "date": _requestDate.trim(),
  //     "customer": customerName,
  //     "phone":customerPhone,
  //     "building": customerBuilding.trim(),
  //     "flat": customerFlat.trim(),
  //     "price": _price.trim(),
  //     "employeeName":"N/A",
  //     "is solved":false,
  //     "thumbnailUrl": downloadUrl,
  //   });
  //
  //   setState(() {
  //     file = null;
  //     uploading = false;
  //     _requestId = DateTime.now().millisecondsSinceEpoch.toString();
  //     _detailsTextEditingController.clear();
  //   });
  //
  }

  Future<Null> _showHVACrequets(BuildContext context) async {
    await showDialog<int>(
        context: context,
        builder: (BuildContext dialogContext) {
          return Theme(
              data: Theme.of(context)
                  .copyWith(dialogBackgroundColor: Colors.transparent),
              child: Dialog(child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListHVACWidget(
                      listHVAC: demoHVACLis,
                      getSelectedValues:({HVAC hvac}){
                        print("selected = ${hvac.toMap()}");
                      },
                      onCheckedValue: (bool value){

                      },
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors.blue, // button color
                      child: InkWell(
                        splashColor: Colors.grey, // inkwell color
                        child: SizedBox(width: 56, height: 56, child: Icon(Icons.close)),
                        onTap: () {
                          Navigator.pop(dialogContext);

                        },
                      ),
                    ),
                  )
                ],
              )));
        });
  }
  _previousrequestsDialog(BuildContext context) {

    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        title: Text(
          "Previous Requests",
          style: TextStyle(
              color:Colors.white),
        ),
        headerColor:Colors.amber,
        backgroundColor:  Colors.white,
        closeButtonColor:Colors.red,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(context).pop();
        },
        content:
        Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
//------------------------------------------------------------------------------
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: Text("Previous Requests"),
              ),
              ListHVACWidget(
                  listHVAC: demoHVACLis,
                  getSelectedValues:({HVAC hvac}){
                    print("selected = ${hvac.toMap()}");
                  },
                onCheckedValue: (checked){
                  print("checked value = ${checked}");

                },
              ),
//------------------------------------------------------------------------------
            ],
          ),
        )
      ),
    );
  }

  _showDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
    });
  }
}
