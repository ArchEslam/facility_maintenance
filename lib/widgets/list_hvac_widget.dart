
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facility_maintenance/model/hvac.dart';
import 'package:facility_maintenance/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';


class ListHVACWidget extends StatefulWidget {
  final List<HVAC> listHVAC;
  bool checkedValue=false;
  ListHVACWidget(
      {this.listHVAC,this.getSelectedValues,this.onCheckedValue});
  Function({HVAC hvac})
  getSelectedValues = ({hvac}) {};
  Function(bool checked)
  onCheckedValue = (checked) {};

  @override
  _ListHVACWidgettState createState() => _ListHVACWidgettState();
}

class _ListHVACWidgettState extends State<ListHVACWidget>
{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('HVAC Requests').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // <3> Retrieve `List<DocumentSnapshot>` from snapshot
            final List<DocumentSnapshot> documents = snapshot.data.docs;
            return ListView(
                children: documents
                    .map((doc) => Card(
                  child: ListTile(
                    title: Text(doc['text']),
                    subtitle: Text(doc['email']),
                  ),
                ))
                    .toList());
          } else if (snapshot.hasError) {
            return CustomProgressIndicatorWidget();
            }
            });
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
                        hvac: hvac,);
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
  Widget itemHVAC({ BuildContext context, Function onPressed, HVAC hvac, double container_item_height, double container_item_text_width}) {


    return
      InkWell(
          onTap: () {
            onPressed();

          },
          child: Padding(
            padding:
            const EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
            child: Container(

              // margin: EdgeInsets.symmetric(horizontal: 4),
              // padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.white,
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
                            padding:
                            const EdgeInsets.only(left: 4.0, right: 4.0),
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
                                    "eslam",
                                  ),
                                ),
                                Container(
                                  width: container_item_text_width,
                                  alignment: Alignment.topLeft,
                                  // width: _container_item_height,
                                  child: Text(
                                    //hvac.description,
                                    " test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),

                  ),

                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image(
                      image: NetworkImage("${hvac.thumbnailUrl}"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(height: 2,color: Colors.grey[200],),
                  //------------------------------------------------------------
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                                //hvac.customer,
                                "Cost ${hvac.price=="null"?"N/A":hvac.price}",
                          ),
                          Container(height:50,width: 2,color: Colors.grey[200],),
                          Container(
                            // width: _container_item_height,
                            child: Checkbox(
                              value: hvac.isSolved??false,
                              onChanged: (newValue) {
                                setState(() {
                                  widget.onCheckedValue(newValue);
                                  hvac.isSolved=newValue;
                                });
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
}
