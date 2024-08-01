class User {
  final String name;
  final String role;
  final List<String> mrNames;

  User({required this.name, required this.role, required this.mrNames});

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
        name: data['Name'],
        role: data["Role"],
        mrNames: List<String>.from(data["MR's"] ?? []));
  }

  Map<String, dynamic> modelTojson() {
    return {"Name": name, "Role": role, "MR's": mrNames};
  }
}
