class User {
  String id;
  String mail;
  String name;
  String password;
  String phone;
  String building;
  String dicipline;


  User(
      {this.id,
        this.mail,
        this.name,
        this.password,
        this.phone,
        this.building,
        this.dicipline});

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
      id: json["id"],
      mail: json["mail"],
      name: json["name"],
      password: json["password"],
      phone: json["phone"],
      building: json["building"],
      dicipline: json["dicipline"],
    );
  }
  factory User.fromMap(Map<dynamic, dynamic> json) => User(
    id: json["id"],
    mail: json["mail"],
    name: json["name"],
    password: json["password"],
    phone: json["phone"],
    building: json["building"],
    dicipline: json["dicipline"],
  );
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'mail': mail,
    'mail': mail,
    'phone': phone,
    'building': building,
    'dicipline': dicipline,
  };
}
