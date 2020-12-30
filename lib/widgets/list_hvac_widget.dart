import 'dart:ffi';

import 'package:facility_maintenance/data/repository.dart';
import 'package:facility_maintenance/model/hvac.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:material_dialog/material_dialog.dart';

import '../constants.dart';
import '../injection_container.dart';

class ListHVACWidget extends StatefulWidget {
  final List<HVAC> listHVAC;
  bool checkedValue = false;
  final int userType;
  Function({HVAC hvac}) getSelectedValues = ({hvac}) {};
  Function(bool checked) onCheckedValue = (checked) {};

  ListHVACWidget(
      {this.listHVAC,
      this.getSelectedValues,
      this.onCheckedValue,
      this.userType});

  DatabaseReference requestsRef =
      FirebaseDatabase.instance.reference().child("HVAC Requests");

  @override
  _ListHVACWidgettState createState() => _ListHVACWidgettState();
}

class _ListHVACWidgettState extends State<ListHVACWidget> {
  Repository _repository = sl<Repository>();
  int userType = 0;
  TextEditingController _priceController = TextEditingController();

  Future<Void> _getUserType() async {
    userType = await _repository.getUserType;
    print(
        "userType value ListHVACWidget ================================ ${userType}");
  }

  @override
  void initState() {
    _getUserType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          itemCount: widget.listHVAC.length,
          itemBuilder: (BuildContext context, int index) {
            final HVAC hvac = widget.listHVAC[index];
            return itemHVAC(
                context: context,
                hvac: hvac,
                container_item_height: _container_item_height,
                container_item_text_width: _container_item_text_width,
                onPressed: () {
                  widget.getSelectedValues(
                    hvac: hvac,
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

  Widget itemHVAC(
      {BuildContext context,
      Function onPressed,
      HVAC hvac,
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
            // margin: EdgeInsets.symmetric(horizontal: 4),
            // padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8)),
            // height: container_item_height,
            // _container_lis_height,
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
                                  "${hvac.thumbnailUrl}",
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                // width: _container_item_height,
                                child: Text(
                                  //hvac.customer,
                                  hvac.customer ?? "",
                                ),
                              ),
                              Container(
                                width: container_item_text_width,
                                alignment: Alignment.topLeft,
                                // width: _container_item_height,
                                child: Text(
                                  //hvac.description,
                                  hvac.description,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
                //------------------------------------------------------------
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image(
                    image: NetworkImage("${hvac.thumbnailUrl}"),
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
                        InkWell(
                          onTap: () {
                            _buildEditPriceDialog(context, hvac);
                          },
                          child: Container(
                            width: container_item_text_width / 3,
                            child: Text(
                                "Cost ${hvac.price == "null" ? "N/A" : hvac.price}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: Theme.of(context).textTheme.subtitle2),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 2,
                          color: Colors.grey[200],
                        ),
                        Container(
                          // width: _container_item_height,
                          child: Checkbox(
                            value: hvac.isSolved ?? false,
                            onChanged: (newValue) {
                              setState(() {
                                widget.onCheckedValue(newValue);
                                hvac.isSolved = newValue;
                              });
                              _changeLis(hvac);
                            },
                            // controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _changeLis(HVAC hvac) async {
    try {
      print(hvac.key);
      await FirebaseDatabase.instance
          .reference()
          .child("HVAC Requests")
          .child(hvac.key)
          .update(hvac.toMap());
    } catch (e) {
      print("update request error =${e.toString()}");
    }
  }

  _buildEditPriceDialog(BuildContext context, HVAC hvac) {
    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        title: Text(
          "Add price",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
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
                    hvac.price = _priceController.text.toString();
                    _changeLis(hvac);
                  });
                },
                child: new Text("confirm change",
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
