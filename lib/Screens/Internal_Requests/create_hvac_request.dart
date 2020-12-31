import 'dart:io';

import 'package:facility_maintenance/components/loadingWidget.dart';
import 'package:facility_maintenance/components/rounded_button.dart';
import 'package:facility_maintenance/constants.dart';
import 'package:facility_maintenance/data/repository.dart';
import 'package:facility_maintenance/model/hvac.dart';
import 'package:facility_maintenance/model/user.dart';
import 'package:facility_maintenance/widgets/list_hvac_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../injection_container.dart';

class CreateHVACRequest extends StatefulWidget {
  @override
  _CreateHVACRequestState createState() => _CreateHVACRequestState();
}

class _CreateHVACRequestState extends State<CreateHVACRequest>
    with AutomaticKeepAliveClientMixin<CreateHVACRequest> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  Repository _repository = sl<Repository>();

  bool get wantKeepAlive => true;
  List<HVAC> listHVAC = [];
  DatabaseReference requestsRef =
      FirebaseDatabase.instance.reference().child("HVAC Requests");

  File file;

  TextEditingController _detailsTextEditingController = TextEditingController();
  TextEditingController _priceTextEditingController = TextEditingController();
  String _requestId = DateTime.now().millisecondsSinceEpoch.toString();
  String _requestDate = DateTime.now().toString();
  String _documentId = "HVAC";
  String _price = "The price has not yet been determined";
  bool uploading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return file == null
        ? displayUserRequestScreen()
        : displayRequestCreationScreen();
  }

  displayUserRequestScreen() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Requests", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushNamed('user_in_sections');
              }),
        ),
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .05,
                  ),
                  SizedBox(
                    width: size.width,
                    child: Image.asset("assets/images/flame.png"),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  RoundedButton(
                    text: "Add New Request",
                    press: () {
                      takeImage(context);
                    },
                  ),
                  RoundedButton(
                    text: "Your Previous Requests",
                    press: () async {
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
        builder: (con) {
          return SimpleDialog(
            title: Text(
              "Image of your request",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                child: Text(
                  "Capture with Camera",
                  style: TextStyle(color: kPrimaryColor),
                ),
                onPressed: capturePhotoWithCamera,
              ),
              SimpleDialogOption(
                child: Text(
                  "Select from Gallery",
                  style: TextStyle(color: kPrimaryColor),
                ),
                onPressed: pickPhotoFromGallery,
              ),
              SimpleDialogOption(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: kPrimaryColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  capturePhotoWithCamera() async {
    Navigator.pop(context);
    final imagefile = await ImagePicker().getImage(
        source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0);

    setState(() {
      file = File(imagefile.path);
    });
  }

  pickPhotoFromGallery() async {
    Navigator.pop(context);
    final imagefile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      file = File(imagefile.path);
    });
  }

  displayRequestCreationScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Request", style: TextStyle(color: Colors.white)),
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
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(file), fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 12)),
          ListTile(
            leading: Icon(
              Icons.add_comment,
              color: kPrimaryColor,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                controller: _detailsTextEditingController,
                decoration: InputDecoration(
                  hintText: 'Request Details',
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: kPrimaryColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: RoundedButton(
              text: "Add",
              press: uploading ? null : () => uploadImageAndSaveItemInfo(),
            ),
          ),
          // SizedBox(height: MediaQuery.of(context).size.width*0.2,),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'Thank You! After leaving the request, our team will contact you shortly.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
          )
        ],
      ),
    );
  }

  clearInfo() {
    setState(() {
      file = null;
      uploading = false;
      _requestId = DateTime.now().millisecondsSinceEpoch.toString();
      _detailsTextEditingController.clear();
    });
  }

  uploadImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl = await uploadItemImage(file);

    saveItemInfo(imageDownloadUrl);
  }

  Future<String> uploadItemImage(mFileImage) async {
    try {
      final Reference reference =
          FirebaseStorage.instance.ref().child("$_documentId Items");
      UploadTask uploadTask =
          reference.child("request_$_requestId.jpg").putFile(mFileImage);
      String downloadUrl = await (await uploadTask).ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Uploading xception =${e.toString()}");
    }
  }

  saveItemInfo(String downloadUrl) async {
    User user = _repository.getUserData;

    var setItem = FirebaseDatabase.instance
        .reference()
        .child("$_documentId Requests")
        .child(_requestId)
        .set({
      "customerID": user.id.toString(),
      "description": _detailsTextEditingController.text.trim(),
      "date": _requestDate.trim(),
      "customer": user.customer,
      "phone": user.phone,
      "building": user.building,
      "flat": user.flat,
      "price": _price.trim(),
      "employeeName": "N/A",
      "isSolved": false,
      "thumbnailUrl": downloadUrl,
      "customerID": user.id,
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
    //     "customerID": customerID.toString(),
    //     "description": _detailsTextEditingController.text.trim(),
    //     "date": _requestDate.trim(),
    //     "customer": customerName,
    //     "phone":customerPhone,
    //     "building": customerBuilding.trim(),
    //     "flat": customerFlat.trim(),
    //     "price": _price.trim(),
    //     "employeeName":"N/A",
    //     "isSolved":false,
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
              child: Dialog(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  listHVAC.length == 0
                      ? Container()
                      : ListHVACWidget(
                          listHVAC: listHVAC,
                          getSelectedValues: ({HVAC hvac}) {
                            print("selected = ${hvac.toMap()}");
                          },
                          onCheckedValue: (bool value) {},
                          userType: Constants.user,
                        ),
                  // hcvDataSnapshot(context) ,
                  ClipOval(
                    child: Material(
                      color: Colors.blue, // button color
                      child: InkWell(
                        splashColor: Colors.grey, // inkwell color
                        child: SizedBox(
                            width: 56, height: 56, child: Icon(Icons.close)),
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

  getData() {
    requestsRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;
      listHVAC.clear();

      print("previous Id =${_repository.getUserData}");
      for (var individualKey in KEYS) {
        print("customerID =${DATA[individualKey]['customerID']}");

        if (DATA[individualKey]['customerID'] == _repository.getUserData.id) {
          HVAC requests =
              new HVAC.fromMap(key: individualKey, map: DATA[individualKey]);
          setState(() {
            listHVAC.add(requests);
          });
        }
      }
    });
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
