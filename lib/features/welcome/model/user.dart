class User {
  final String name;
  final String role;

  User({required this.name, required this.role});

  factory User.fromJson(Map<String, dynamic> data) {
    return User(name: data['Name'], role: data["Role"]);
  }

  Map<String, dynamic> modelTojson() {
    return {"Name": name, "Role": role};
  }
}
