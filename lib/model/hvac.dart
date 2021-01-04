class HVAC {
  String building;
  final key;
  String customer;
  String customerId;
  String date;
  String description;
  String employeeName;
  String flat;
  bool isSolved;
  String phone;
  String price;
  String thumbnailUrl;
  String deviceRegId;

  HVAC(
      {this.building,
      this.key,
      this.customer,
      this.customerId,
      this.date,
      this.description,
      this.employeeName,
      this.flat,
      this.phone,
      this.price,
      this.isSolved,
      this.thumbnailUrl,
      this.deviceRegId});

  factory HVAC.fromMap({key, Map<dynamic, dynamic> map}) => HVAC(
        building: map["building"] ?? "",
        key: key,
        customer: map["customer"] ?? "",
        customerId: map["customerID"] ?? "",
        deviceRegId: map["deviceRegId"] ?? "",
        date: map["date"] ?? "",
        description: map["description"] ?? "",
        employeeName: map["employeeName"] ?? "",
        flat: map["flat"] ?? "",
        phone: map["phone"] ?? "",
        price: map["price"],
        isSolved: map["isSolved"],
        thumbnailUrl: map["thumbnailUrl"],
      );

  Map<String, dynamic> toMap() => {
        "building": building,
        "customer": customer,
        "customerID": customerId,
        "deviceRegId": deviceRegId,
        "date": date,
        "description": description,
        "employeeName": employeeName,
        "flat": flat,
        "phone": phone,
        "price": price,
        "isSolved": isSolved,
        "thumbnailUrl": thumbnailUrl,
      };
}
