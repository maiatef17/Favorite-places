class User {
  final String email, name, password;

  User({required this.email, required this.name, required this.password});

  Map<String, dynamic> toMap() {
    return {"name": name, "email": email, "password": password};
  }

  factory User.fromMap(Map m) {
    return User(name: m["name"], email: m["email"], password: m["password"]);
  }
}
