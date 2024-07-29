class Visit {
  String clientName;
  String mrName;
  String clientType;
  String placeType;
  String address;
  String purpose;
  String contactPoint;
  String date;
  String day;

  Visit(
      {required this.clientName,
      required this.mrName,
      required this.clientType,
      required this.placeType,
      required this.address,
      required this.contactPoint,
      required this.purpose,
      required this.date,
      required this.day});

  factory Visit.fromJson(Map<String, dynamic> data) {
    return Visit(
      clientName: data['Client'],
      mrName: data["MR Name"],
      clientType: data["Client Type"],
      placeType: data["Place"],
      address: data["Address"],
      contactPoint: data['Contact Point'],
      purpose: data['Purpose'],
      date: data['Date'],
      day: data['Day'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Client': clientName,
      'MR Name': mrName,
      'Client Type': clientType,
      'Place': placeType,
      'Address': address,
      'Contact Point': contactPoint,
      'Purpose': purpose,
      'Date': date,
      'Day': day,
    };
  }
}
