class User {
  final String name;
  final String role;
  final String password;
  final List<String> mrNames;

  User({required this.name, required this.role,required this.password, required this.mrNames});

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
        name: data['Name'],
        role: data["Role"],
        password: data['Password'],
        mrNames: List<String>.from(data["MR's"] ?? []));
  }

  Map<String, dynamic> modelTojson() {
    return {"Name": name, "Role": role,'Password':password, "MR's": mrNames};
  }
}
