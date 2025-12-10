

class UserModel {
  String? id;
  String? email;
  String? password;
  String? name;
  String? phone;
  int? age;


  UserModel(
      {this.id, this.email, this.password, this.name, this.phone, this.age});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["accountId"],
      email: json["email"],
      password: json["password"],
      name: json["name"],
      phone: json["phone"],
      age: json["age"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "accountId": id,
      "email": email,
      "password": password,
      "name": name,
      "phone": phone,
      "age": age,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
    String? phone,
    int? age,
  }) => UserModel(
    id: id ?? this.id,
    email: email ?? this.email,
    password: password ?? this.password,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    age: age ?? this.age,
  );

  @override
  String toString() {
    return toJson().toString();
  }
}
