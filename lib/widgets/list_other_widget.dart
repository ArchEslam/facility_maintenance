import 'package:facility_maintenance/data/repositories/notification_handler.dart';
import 'package:facility_maintenance/data/repositories/shared_preferences.dart';
import 'package:facility_maintenance/model/fcm_notification_model.dart';
import 'package:facility_maintenance/model/other.dart';
import 'package:facility_maintenance/model/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_dialog/material_dialog.dart';

import '../constants.dart';
import '../injection_container.dart';

class ListOTHERWidget extends StatefulWidget {
  final List<OTHER> listOTHER;
  final int userType;
  Function({OTHER other}) getSelectedValues = ({other}) {};
  Function(bool checked) onCheckedValue = (checked) {};

  ListOTHERWidget(
      {this.listOTHER,
      this.getSelectedValues,
      this.onCheckedValue,
      this.userType});

  DatabaseReference requestsRef =
      FirebaseDatabase.instance.reference().child("OTHER Requests");

  @override
  _ListOTHERWidgettState createState() => _ListOTHERWidgettState();
}

class _ListOTHERWidgettState extends State<ListOTHERWidget> {
  bool isSolved;
  TextEditingController _priceController = TextEditingController();
  bool checkedValue = false;
  DateTime _now = DateTime.now();
  NotificationsHandler _notificationsHandler = sl<NotificationsHandler>();
  MySharedPreferences _mySharedPreferences = sl<MySharedPreferences>();

  @override
  void initState() {
    super.initState();
    print("listOTHER befor filter = ${widget.listOTHER.length}");
  }

  @override
  Widget build(BuildContext context) {
    print("listOTHER befor filter = ${widget.listOTHER.length}");

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
      _container_item_text_width = MediaQuery.of(context).size.width / 4.5;
    } else {
      _container_lis_height = MediaQuery.of(context).size.height / 5.0;
      _container_item_height = MediaQuery.of(context).size.height / 5.5;
      _container_item_text_width = MediaQuery.of(context).size.height / 4.5;
    }
    // if(_sections !=null){

    return new Flexible(
      child: Container(
        // height: _container_lis_height,
        color: Colors.transparent,
        child: SizedBox.expand(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.listOTHER.length,
          itemBuilder: (BuildContext context, int index) {
            final OTHER other = widget.listOTHER[index];
            return itemOTHER(
                context: context,
                other: other,
                container_item_height: _container_item_height,
                container_item_text_width: _container_item_text_width,
                onPressed: () {
                  widget.getSelectedValues(
                    other: other,
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

  Widget itemOTHER(
      {BuildContext context,
      Function onPressed,
      OTHER other,
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
                                  "${other.thumbnailUrl}",
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: 210,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  width: 210,//container_item_text_width,
                                  child: Text(
                                    //other.customer,
                                      other.customer ?? "",
                                      style: Theme.of(context).textTheme.headline6
                                  ),
                                ),
                                Container(
                                  width: 210,//container_item_text_width,
                                  alignment: Alignment.topLeft,
                                  // width: _container_item_height,
                                  child: Text(
                                      other.date??"",
                                      style: Theme.of(context).textTheme.subtitle1
                                    //other.description,
                                    // other.description??"",
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                  child: Text(other.description??"",
                      style: Theme.of(context).textTheme.subtitle1),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image(
                    image: NetworkImage("${other.thumbnailUrl}"),
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
                                  "${other.isSolved ? "Cost: ${other.price} SAR " : "N/A"}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: Theme.of(context).textTheme.subtitle2),
                              Container(
                                width: container_item_text_width,
                                child: Text(
                                    "${other.isSolved ? "Employee: ${other.employeeName}" : ""}",
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
                                      value: other.isSolved ?? false,
                                      onChanged: (newValue) {
                                        if (!other.isSolved) {
                                          if (widget.userType == Constants.employee) {
                                            _buildEditPriceDialog(
                                                context, other);
                                         }
                                        }
                                      },
                                      // controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                    ),
                                    Text("${other.isSolved ? "Solved" : "N/A"}",
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

  Future<void> _changeLis(OTHER other, BuildContext dialogContext) async {
    print(other.token);
    User user = _mySharedPreferences.getUserData;
    FcmNotificationModel notify = new FcmNotificationModel(
      type: FCMpayload.user.toString(),
      messageBody: "Your request issue has been resolved",
      messageTitle: "${user.customer} Receive your request",
      customerId: user.id.toString(),
      customerName: other.customer,
      itemId: "null",
      token: other.token,
      senderName: user.name,
      sentAt: DateFormat('yyyy-MM-dd – kk:mm').format(_now),
    );

    print(other.key);
    await FirebaseDatabase.instance
        .reference()
        .child("OTHER Requests")
        .child(other.key)
        .update(other.toMap())
        .whenComplete(() {
      widget.onCheckedValue(true);
      other.isSolved = true;
      other.price = _priceController.text;
      _priceController.text = "";
      Navigator.of(dialogContext).pop();
    }).whenComplete(() {
      _notificationsHandler.sendAndRetrieveMessage(notify,notify.token).then((value) {
        print("value on sendAndRetrieveMessage = ${value}");
      });
    });
  }

  _buildEditPriceDialog(BuildContext context, OTHER other) {
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
                    other.price = _priceController.text.toString();
                    other.isSolved = true;
                    other.employeeName = _mySharedPreferences.getUserData.name;
                    _changeLis(other, context);
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
