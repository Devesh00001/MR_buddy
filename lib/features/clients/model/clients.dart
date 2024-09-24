class Client {
  String name;
  String address;
  String hospital;
  String specialization;

  Client(
      {required this.name,
      required this.address,
      required this.hospital,
      required this.specialization});

  factory Client.fromJson(Map<String, dynamic> data) {
    return Client(
        name: data['Name'],
        address: data['Address'],
        hospital: data['Hospital'],
        specialization: data['Specialization'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Address': address,
      'Hospital': hospital,
      'Specialization': specialization
    };
  }
}
