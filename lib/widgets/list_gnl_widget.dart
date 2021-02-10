import 'package:facility_maintenance/data/repositories/notification_handler.dart';
import 'package:facility_maintenance/data/repositories/shared_preferences.dart';
import 'package:facility_maintenance/model/fcm_notification_model.dart';
import 'package:facility_maintenance/model/gnl.dart';
import 'package:facility_maintenance/model/user.dart';
import 'package:facility_maintenance/utils/date_reformate.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_dialog/material_dialog.dart';

import '../constants.dart';
import '../injection_container.dart';

class ListGNLWidget extends StatefulWidget {
  final List<GNL> listGNL;
  final int userType;
  Function({GNL gnl}) getSelectedValues = ({gnl}) {};
  Function(bool checked) onCheckedValue = (checked) {};

  ListGNLWidget(
      {this.listGNL,
      this.getSelectedValues,
      this.onCheckedValue,
      this.userType});

  DatabaseReference requestsRef =
      FirebaseDatabase.instance.reference().child("GNL Requests");

  @override
  _ListGNLWidgettState createState() => _ListGNLWidgettState();
}

class _ListGNLWidgettState extends State<ListGNLWidget> {
  bool isSolved;
  TextEditingController _priceController = TextEditingController();
  bool checkedValue = false;
  DateTime _now = DateTime.now();
  NotificationsHandler _notificationsHandler = sl<NotificationsHandler>();
  MySharedPreferences _mySharedPreferences = sl<MySharedPreferences>();

  @override
  void initState() {
    super.initState();
    print("listGNL befor filter = ${widget.listGNL.length}");
  }

  @override
  Widget build(BuildContext context) {
    print("listGNL befor filter = ${widget.listGNL.length}");

    return _cardListItem(context);
  }

  Widget _cardListItem(BuildContext context) {
    double _containe_width;
    double _container_lis_height;
    double _container_item_height;
    double _container_item_text_width;

    final mediaQueryData = MediaQuery.of(context);
    if (mediaQueryData.orientation == Orientation.landscape) {
      _container_lis_height = MediaQuery.of(context).size.width / 3.0;
      _container_item_height = MediaQuery.of(context).size.width / 5.5;
      _container_item_text_width = MediaQuery.of(context).size.width / 3;
    } else {
      _container_lis_height = MediaQuery.of(context).size.height / 5.0;
      _container_item_height = MediaQuery.of(context).size.height / 5.5;
      _container_item_text_width = MediaQuery.of(context).size.height / 3;
    }
    // if(_sections !=null){

    return new Flexible(
      child: Container(
        // height: _container_lis_height,
        color: Colors.transparent,
        child: SizedBox.expand(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.listGNL.length,
          itemBuilder: (BuildContext context, int index) {
            final GNL gnl = widget.listGNL[index];
            return itemGNL(
                context: context,
                gnl: gnl,
                container_item_height: _container_item_height,
                container_item_text_width: _container_item_text_width,
                onPressed: () {
                  widget.getSelectedValues(
                    gnl: gnl,
                  );
                  Navigator.pop(context);
                  // getData(null, specailty.id);
                });
          },
          //  scrollDirection: Axis.horizontal,
        )
            //),
            ),
      ),
    );
  }

  Widget itemGNL(
      {BuildContext context,
      Function onPressed,
      GNL gnl,
      double container_item_height,
      double container_item_text_width}) {
    return InkWell(
        onTap: () {
          onPressed();
        },
        child: Padding(
          padding:
              const EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0, bottom: 6),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //------------------------------------------------------------
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: Container(
                            child: CircleAvatar(
                                maxRadius: 30,
                                backgroundImage: new NetworkImage(
                                  "${gnl.thumbnailUrl}",
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: container_item_text_width / 1.3,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                      //gnl.customer,
                                      gnl.customer ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                ),
                                Container(
                                  width: container_item_text_width / 1.3,
                                  alignment: Alignment.topLeft,
                                  // width: _container_item_height,
                                  child: Text(DateReformat.reformatYMD(gnl.date) ?? "",
                                      style:
                                          Theme.of(context).textTheme.subtitle1
                                      //gnl.description,
                                      // gnl.description??"",
                                      //   style: Theme.of(context).textTheme.subtitle1

                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
                //------------------------------------------------------------
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Text(gnl.description ?? "",
                      style: Theme.of(context).textTheme.subtitle1),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image(
                    image: NetworkImage("${gnl.thumbnailUrl}"),
                    fit: BoxFit.fill,
                  ),
                ),
                //------------------------------------------------------------
                Container(
                  height: 2,
                  color: Colors.grey[200],
                ),
                //------------------------------------------------------------
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: container_item_text_width,
                          child: Column(
                            children: [
                              Text(
                                  "${gnl.isSolved ? "Cost: ${gnl.price} SAR " : "N/A"}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: Theme.of(context).textTheme.subtitle2),
                              Container(
                                width: container_item_text_width,
                                child: Text(
                                    "${gnl.isSolved ? "Employee: ${gnl.employeeName}" : ""}",
                                    maxLines: 3,
                                    softWrap: false,
                                    style:
                                        Theme.of(context).textTheme.subtitle2),
                              ),
                            ],
                          ),
                        ),
                        widget.userType == Constants.employee
                            ? Container(
                                height: 50,
                                width: 2,
                                color: Colors.grey[200],
                              )
                            : Container(),
                        widget.userType == Constants.employee
                            ? Container(
                                // width: _container_item_height,
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: gnl.isSolved ?? false,
                                      onChanged: (newValue) {
                                        if (!gnl.isSolved) {
                                          if (widget.userType ==
                                              Constants.employee) {
                                            _buildEditPriceDialog(context, gnl);
                                          }
                                        }
                                      },
                                      // controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                    ),
                                    Text("${gnl.isSolved ? "Solved" : "N/A"}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
                                  ],
                                ),
                              )
                            : Container(),
                      ]),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _changeLis(GNL gnl, BuildContext dialogContext) async {
    print(gnl.token);
    User user = _mySharedPreferences.getUserData;
    FcmNotificationModel notify = new FcmNotificationModel(
      type: FCMpayload.user.toString(),
      messageBody: "Your request issue has been resolved",
      messageTitle: "${user.customer} Receive your request",
      customerId: user.id.toString(),
      customerName: gnl.customer,
      itemId: "null",
      token: gnl.token,
      senderName: user.name,
      sentAt: DateFormat('yyyy-MM-dd – kk:mm').format(_now),
    );

    print(gnl.key);
    await FirebaseDatabase.instance
        .reference()
        .child("GNL Requests")
        .child(gnl.key)
        .update(gnl.toMap())
        .whenComplete(() {
      widget.onCheckedValue(true);
      gnl.isSolved = true;
      gnl.price = _priceController.text;
      _priceController.text = "";
      Navigator.of(dialogContext).pop();
    }).whenComplete(() {
      _notificationsHandler
          .sendAndRetrieveMessage(notify, notify.token)
          .then((value) {
        print("value on sendAndRetrieveMessage = ${value}");
      });
    });
  }

  _buildEditPriceDialog(BuildContext context, GNL gnl) {
    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        title: Text(
          "Add price",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        headerColor: Colors.blueGrey,
        backgroundColor: Colors.grey[200],
        closeButtonColor: Colors.white,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(context).pop();
        },
        content: Container(
          //height: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                cursorColor: kPrimaryColor,
              ),
              new FlatButton(
                color: Colors.grey[700],
                onPressed: () {
                  setState(() {
                    gnl.price = _priceController.text.toString();
                    gnl.isSolved = true;
                    gnl.employeeName = _mySharedPreferences.getUserData.name;
                    _changeLis(gnl, context);
                  });
                },
                child: new Text("Confirm change",
                    style: new TextStyle(fontSize: 18.0, color: Colors.white)),
              ),
            ],
          ),
        ),
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
