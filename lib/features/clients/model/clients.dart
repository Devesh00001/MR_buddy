class Client {
  String name;
  String address;
  String hospital;

  Client({
    required this.name,
    required this.address,
    required this.hospital,
  });

  factory Client.fromJson(Map<String, dynamic> data) {
    return Client(
        name: data['Name'],
        address: data['Address'],
        hospital: data['Hospital']);
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Address': address,
      'Hospital': hospital,
    };
  }
}
