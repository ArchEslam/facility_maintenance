class HVAC {
  String building;
  String customer;
  String customerId;
  String date;
  String description;
  String flat;
  String phone;
  String price;
  bool isSolved;
  String thumbnailUrl;

  HVAC(
      {this.building,
      this.customer,
      this.customerId,
      this.date,
      this.description,
      this.flat,
      this.phone,
      this.price,
      this.isSolved,
      this.thumbnailUrl});

  factory HVAC.fromMap(Map<String, dynamic> json) => HVAC(
        building: json["building"],
        customer: json["customer"],
        customerId: json["customerId"],
        date: json["date"],
        description: json["description"],
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
        "flat": flat,
        "phone": phone,
        "price": price,
    "isSolved": isSolved,
    "thumbnailUrl": thumbnailUrl,
      };
}

final List<HVAC> demoHVACLis = [
  HVAC(
    building: 'Building No.01',
    customer: 'null',
    customerId: '00101B01',
    date: "1.png",
    description: "test",
    flat: "null",
    phone: "null",
    price: "null",
    thumbnailUrl:
        "https://firebasestorage.googleapis.com/v0/b/facility-maintenance-29629.appspot.com/o/HVAC%20Items%2Frequest_1609196547643.jpg?alt=media&token=6946468a-fa97-44c3-b53a-e9e73f90f4e8",
  ),
  HVAC(
    building: 'Building No.01',
    customer: 'null',
    customerId: '00101B01',
    date: "1.png",
    description: "test",
    flat: "null",
    phone: "null",
    price: "null",
    isSolved: false,
    thumbnailUrl:
    "https://firebasestorage.googleapis.com/v0/b/facility-maintenance-29629.appspot.com/o/HVAC%20Items%2Frequest_1609196547643.jpg?alt=media&token=6946468a-fa97-44c3-b53a-e9e73f90f4e8",
  ),
  HVAC(
    building: 'Building No.01',
    customer: 'null',
    customerId: '00101B01',
    date: "1.png",
    description: "test",
    flat: "null",
    phone: "null",
    price: "null",
    isSolved: true,

    thumbnailUrl:
    "https://firebasestorage.googleapis.com/v0/b/facility-maintenance-29629.appspot.com/o/HVAC%20Items%2Frequest_1609196547643.jpg?alt=media&token=6946468a-fa97-44c3-b53a-e9e73f90f4e8",
  ),
  HVAC(
    building: 'Building No.01',
    customer: 'null',
    customerId: '00101B01',
    date: "1.png",
    description: "test",
    flat: "null",
    phone: "null",
    price: "The price has not yet been determined",
    isSolved: true,

    thumbnailUrl:
    "https://firebasestorage.googleapis.com/v0/b/facility-maintenance-29629.appspot.com/o/HVAC%20Items%2Frequest_1609196547643.jpg?alt=media&token=6946468a-fa97-44c3-b53a-e9e73f90f4e8",
  ),
  HVAC(
    building: 'Building No.01',
    customer: 'null',
    customerId: '00101B01',
    date: "1.png",
    description: "test",
    flat: "null",
    phone: "null",
    price: "null",
    isSolved: false,
    thumbnailUrl:
    "https://firebasestorage.googleapis.com/v0/b/facility-maintenance-29629.appspot.com/o/HVAC%20Items%2Frequest_1609196547643.jpg?alt=media&token=6946468a-fa97-44c3-b53a-e9e73f90f4e8",
  ),
];
