import 'dart:io';

import 'package:facility_maintenance/components/loadingWidget.dart';
import 'package:facility_maintenance/components/rounded_button.dart';
import 'package:facility_maintenance/constants.dart';
import 'package:facility_maintenance/data/repositories/notification_handler.dart';
import 'package:facility_maintenance/data/repositories/shared_preferences.dart';
import 'package:facility_maintenance/model/fcm_notification_model.dart';
import 'package:facility_maintenance/model/gnl.dart';
import 'package:facility_maintenance/model/user.dart';
import 'package:facility_maintenance/widgets/list_gnl_widget.dart';
import 'package:facility_maintenance/widgets/progress_indicator_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../injection_container.dart';

class CreateGNLRequest extends StatefulWidget {
  @override
  _CreateGNLRequestState createState() => _CreateGNLRequestState();
}

class _CreateGNLRequestState extends State<CreateGNLRequest>
    with AutomaticKeepAliveClientMixin<CreateGNLRequest> {
  MySharedPreferences _mySharedPreferences = sl<MySharedPreferences>();
  NotificationsHandler _notificationsHandler = sl<NotificationsHandler>();
  DateTime _now = DateTime.now();

  bool get wantKeepAlive => true;
  List<GNL> listGNL = [];
  File file;
  var dbRef = FirebaseDatabase.instance.reference().child("GNL Requests");

  TextEditingController _detailsTextEditingController = TextEditingController();
  TextEditingController _priceTextEditingController = TextEditingController();
  String _requestId = DateTime.now().millisecondsSinceEpoch.toString();
  String _requestDate = DateTime.now().toString();
  String _documentId = "GNL";
  String _price = "The price has not yet been determined";
  bool uploading = false;

  @override
  void initState() {
    super.initState();
    print("previous Id =${_mySharedPreferences.getUserData.id}");

    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: dbRef.onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            listGNL.clear();
            DataSnapshot dataValues = snapshot.data.snapshot;
            var val = dataValues.value;
            if (val != null) {
              val.forEach((individualKey, values) {
                GNL requests = new GNL.fromMap(
                    key: individualKey, map: val[individualKey]);
                print(
                    "get requests id =>${requests.customerId} | ${_mySharedPreferences.getUserData.id} <==my id");

                if (requests.customerId
                    .contains(_mySharedPreferences.getUserData.id)) {
                  //  print("get list data in condition =${values[individualKey]["customerID"]}");
                  // setState(() {
                  listGNL.add(requests);

                  // });
                }
              });
            }

            print("listGNL length = ${listGNL.length}");

            return Container(
                child: file == null
                    ? displayUserRequestScreen()
                    : displayRequestCreationScreen());
          } else {
            return Container(
              child: CustomProgressIndicatorWidget(),
            );
          }
        });
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
            onPressed: () async {
              var nav =
                  await Navigator.of(context).pushNamed("/user_in_sections");
              if (nav == true || nav == null) {
                //change the state
              }
            },
          ),
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
                      _showGNLrequets(context);
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
      print("Uploading exception =${e.toString()}");
    }
  }

  saveItemInfo(String downloadUrl) async {
    User user = _mySharedPreferences.getUserData;
    FcmNotificationModel notify = new FcmNotificationModel(
      messageBody: "new request",
      messageTitle: "from ${user.customer}",
      customerId: user.id.toString(),
      customerName: user.customer,
      itemId: "null",
      token: user.token,
      senderName: user.customer,
      type: FCMpayload.employee.toString(),
      sentAt: DateFormat('yyyy-MM-dd – kk:mm').format(_now),
    );

    var setItem = FirebaseDatabase.instance
        .reference()
        .child("$_documentId Requests")
        .child(_requestId)
        .set({
      "customerID": user.id.toString(),
      "description": _detailsTextEditingController.text.trim(),
      "date": _requestDate.trim(),
      "customer": user.name,
      "phone": user.phone,
      "token": _mySharedPreferences.getToken,
      "building": user.building,
      "flat": user.flat,
      "price": _price.trim(),
      "employeeName": "N/A",
      "isSolved": false,
      "thumbnailUrl": downloadUrl,
    }).whenComplete(() {
      //TODO to push notification to employees now is canceled because want complex logic
      //_notificationsHandler.sendAndRetrieveMessage(notify);
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

  Future<Null> _showGNLrequets(BuildContext context) async {
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
                  listGNL.length <= 0
                      ? Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                  //gnl.customer,
                                  "No Requests Add yet",
                                  style: Theme.of(context).textTheme.headline5),
                            ),
                          ),
                        )
                      : ListGNLWidget(
                          listGNL: listGNL,
                          getSelectedValues: ({GNL gnl}) {
                            print("selected = ${gnl.toMap()}");
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
    var KEYS;
    var DATA;

    var dbRef = FirebaseDatabase.instance.reference().child("GNL Requests");

    dbRef
        .orderByKey()
        .equalTo(_mySharedPreferences.getUserData.id)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != "") {
        var ref = FirebaseDatabase.instance.reference();
        ref.child("GNL Requests").once().then((DataSnapshot snap) {
          print(snap.value);
          KEYS = snap.value.keys;
          DATA = snap.value;
          setState(() {
            for (var individualKey in KEYS) {
              GNL requests =
                  new GNL.fromMap(key: individualKey, map: DATA[individualKey]);
              print(
                  "get requests id =>${requests.customerId} | ${_mySharedPreferences.getUserData.id} <==my id");

              if (requests.customerId
                  .contains(_mySharedPreferences.getUserData.id)) {
                print(
                    "get list data in condition =${DATA[individualKey]["customerID"]}");
                listGNL.add(requests);
              }
            }
          });
        });
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
