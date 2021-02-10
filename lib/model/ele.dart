class ELE {
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
  String token;

  ELE(
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
      this.token});

  factory ELE.fromMap({key, Map<dynamic, dynamic> map}) => ELE(
        building: map["building"] ?? "",
        key: key,
        customer: map["customer"] ?? "",
        customerId: map["customerID"] ?? "",
        token: map["token"] ?? "",
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
        "token": token,
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