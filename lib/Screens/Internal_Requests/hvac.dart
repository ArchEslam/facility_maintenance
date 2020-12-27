import 'package:cloud_firestore/cloud_firestore.dart';

class HVAC {
  String building;
  String customer;
  String date;
  String description;
  String employeeName;
  String flat;
  String price;
  bool isSolved;
  String phone;
  String thumbnailUrl;

  HVAC({
    this.building,
    this.customer,
    this.date,
    this.description,
    this.employeeName,
    this.flat,
    this.price,
    this.isSolved,
    this.phone,
    this.thumbnailUrl,
  });

  HVAC.fromJson(Map<String, dynamic>json, this.building, this.customer, this.date, this.description, this.employeeName, this.flat, this.price, this.isSolved, this.phone, this.thumbnailUrl){
    building = json['building'];
    customer = json['customer'];
    date = json['date'];
    description = json['description'];
    employeeName = json['employeeName'];
    flat = json['flat'];
    price = json['price'];
    isSolved = json['isSolved'];
    phone = json['phone'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson()
  {

  }
}