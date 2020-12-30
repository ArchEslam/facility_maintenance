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
      this.thumbnailUrl});

  factory HVAC.fromMap(Map<dynamic, dynamic> json) => HVAC(
        building: json["building"],
        customer: json["customer"],
        customerId: json["customerId"],
        date: json["date"],
        description: json["description"],
        employeeName: json["employeeName"],
        flat: json["flat"],
        phone: json["phone"],
        price: json["price"],
        isSolved: json["isSolved"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toMap() => {
        "building": building,
        "customer": customer,
        "customerId": customerId,
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
