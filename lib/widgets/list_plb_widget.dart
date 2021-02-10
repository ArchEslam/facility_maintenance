import 'package:facility_maintenance/data/repositories/notification_handler.dart';
import 'package:facility_maintenance/data/repositories/shared_preferences.dart';
import 'package:facility_maintenance/model/fcm_notification_model.dart';
import 'package:facility_maintenance/model/plb.dart';
import 'package:facility_maintenance/model/user.dart';
import 'package:facility_maintenance/utils/date_reformate.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_dialog/material_dialog.dart';

import '../constants.dart';
import '../injection_container.dart';

class ListPLBWidget extends StatefulWidget {
  final List<PLB> listPLB;
  final int userType;
  Function({PLB plb}) getSelectedValues = ({plb}) {};
  Function(bool checked) onCheckedValue = (checked) {};

  ListPLBWidget(
      {this.listPLB,
      this.getSelectedValues,
      this.onCheckedValue,
      this.userType});

  DatabaseReference requestsRef =
      FirebaseDatabase.instance.reference().child("PLB Requests");

  @override
  _ListPLBWidgettState createState() => _ListPLBWidgettState();
}

class _ListPLBWidgettState extends State<ListPLBWidget> {
  bool isSolved;
  TextEditingController _priceController = TextEditingController();
  bool checkedValue = false;
  DateTime _now = DateTime.now();
  NotificationsHandler _notificationsHandler = sl<NotificationsHandler>();
  MySharedPreferences _mySharedPreferences = sl<MySharedPreferences>();

  @override
  void initState() {
    super.initState();
    print("listPLB befor filter = ${widget.listPLB.length}");
  }

  @override
  Widget build(BuildContext context) {
    print("listPLB befor filter = ${widget.listPLB.length}");

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
          itemCount: widget.listPLB.length,
          itemBuilder: (BuildContext context, int index) {
            final PLB plb = widget.listPLB[index];
            return itemPLB(
                context: context,
                plb: plb,
                container_item_height: _container_item_height,
                container_item_text_width: _container_item_text_width,
                onPressed: () {
                  widget.getSelectedValues(
                    plb: plb,
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

  Widget itemPLB(
      {BuildContext context,
      Function onPressed,
      PLB plb,
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
                                  "${plb.thumbnailUrl}",
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
                                  alignment: Alignment.topLeft,
                                  width: container_item_text_width / 1.3,
                                  child: Text(
                                      //plb.customer,
                                      plb.customer ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                ),
                                Container(
                                  width: container_item_text_width / 1.3,
                                  alignment: Alignment.topLeft,
                                  // width: _container_item_height,
                                  child: Text(DateReformat.reformatYMD(plb.date) ?? "",
                                      style:
                                          Theme.of(context).textTheme.subtitle1
                                      //plb.description,
                                      // plb.description??"",
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
                  child: Text(plb.description ?? "",
                      style: Theme.of(context).textTheme.subtitle1),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image(
                    image: NetworkImage("${plb.thumbnailUrl}"),
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
                                  "${plb.isSolved ? "Cost: ${plb.price} SAR " : "N/A"}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: Theme.of(context).textTheme.subtitle2),
                              Container(
                                width: container_item_text_width,
                                child: Text(
                                    "${plb.isSolved ? "Employee: ${plb.employeeName}" : ""}",
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
                                      value: plb.isSolved ?? false,
                                      onChanged: (newValue) {
                                        if (!plb.isSolved) {
                                          if (widget.userType ==
                                              Constants.employee) {
                                            _buildEditPriceDialog(context, plb);
                                          }
                                        }
                                      },
                                      // controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                    ),
                                    Text("${plb.isSolved ? "Solved" : "N/A"}",
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

  Future<void> _changeLis(PLB plb, BuildContext dialogContext) async {
    print(plb.token);
    User user = _mySharedPreferences.getUserData;
    FcmNotificationModel notify = new FcmNotificationModel(
      type: FCMpayload.user.toString(),
      messageBody: "Your request issue has been resolved",
      messageTitle: "${user.customer} Receive your request",
      customerId: user.id.toString(),
      customerName: plb.customer,
      itemId: "null",
      token: plb.token,
      senderName: user.name,
      sentAt: DateFormat('yyyy-MM-dd – kk:mm').format(_now),
    );

    print(plb.key);
    await FirebaseDatabase.instance
        .reference()
        .child("PLB Requests")
        .child(plb.key)
        .update(plb.toMap())
        .whenComplete(() {
      widget.onCheckedValue(true);
      plb.isSolved = true;
      plb.price = _priceController.text;
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

  _buildEditPriceDialog(BuildContext context, PLB plb) {
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
                    plb.price = _priceController.text.toString();
                    plb.isSolved = true;
                    plb.employeeName = _mySharedPreferences.getUserData.name;
                    _changeLis(plb, context);
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