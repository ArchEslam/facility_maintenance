import 'package:facility_maintenance/constants.dart';
import 'package:flutter/material.dart';

circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12),
    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(kPrimaryColor),),
  );
}

linearProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12),
    child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation(kPrimaryColor),),
  );
}