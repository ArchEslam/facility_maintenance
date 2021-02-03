class User {
  final String key;
  dynamic id;
  dynamic mail;
  dynamic name;
  dynamic password;
  dynamic phone;
  dynamic building;
  dynamic dicipline;
  dynamic customer;
  dynamic flat;
  dynamic token;

  User(
      {this.key,
      this.id,
      this.mail,
      this.name,
      this.password,
      this.phone,
      this.building,
      this.dicipline,
      this.customer,
      this.flat,
      this.token});

  factory User.fromJson({key, Map<dynamic, dynamic> map}) {
    return new User(
      key: key,
      id: map["id"],
      //token: map["token"],
      mail: map["mail"],
      name: map["name"],
      password: map["password"],
      phone: map["phone"],
      building: map["building"],
      dicipline: map["dicipline"],
      customer: map["customer"],
      flat: map["flat"],
    );
  }

  factory User.fromMap(Map<dynamic, dynamic> map) => User(
        id: map["id"] ?? "",
        // token: map["token"]??"",
        mail: map["mail"] ?? "",
        name: map["name"] ?? "",
        password: map["password"] ?? "",
        phone: map["phone"] ?? "",
        building: map["building"] ?? "",
        dicipline: map["dicipline"] ?? "",
        customer: map["customer"] ?? "",
        flat: map["flat"] ?? "",
      );

  Map<dynamic, dynamic> toJson() => <String, dynamic>{
        'id': id,
        "token": token,
        'mail': mail,
        'phone': phone,
        'building': building,
        'dicipline': dicipline,
        'customer': customer,
        'flat': flat,
      };

  Map<dynamic, dynamic> toMap() => {
        'id': id,
        "token": token,
        'mail': mail,
        'phone': phone,
        'building': building,
        'dicipline': dicipline,
        'customer': customer,
        'flat': flat,
      };
}
