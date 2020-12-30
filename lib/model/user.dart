class User {

  final String key;
  String id;
  String mail;
  String name;
  String password;
  String phone;
  String building;
  String dicipline;
  String customer;
  String flat;

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
      this.flat});

  factory User.fromJson({key, Map<dynamic, dynamic> map}) {
    return new User(
      key: key,
      id: map["id"],
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
        mail: map["mail"] ?? "",
        name: map["name"] ?? "",
        password: map["password"] ?? "",
        phone: map["phone"] ?? "",
        building: map["building"] ?? "",
        dicipline: map["dicipline"] ?? "",
        customer: map["customer"] ?? "",
        flat: map["flat"] ?? "",
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'mail': mail,
        'mail': mail,
        'phone': phone,
        'building': building,
        'dicipline': dicipline,
        'customer': customer,
        'flat': flat,
      };

  Map<dynamic, dynamic> toMap() => {
        'id': id,
        'mail': mail,
        'mail': mail,
        'phone': phone,
        'building': building,
        'dicipline': dicipline,
        'customer': customer,
        'flat': flat,
      };
}
