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
  String comments;
  String status;
  String startTime;
  bool checkOut;

  Visit(
      {required this.clientName,
      required this.mrName,
      required this.clientType,
      required this.placeType,
      required this.address,
      required this.contactPoint,
      required this.purpose,
      required this.date,
      required this.day,
      required this.comments,
      required this.status,
      required this.startTime,
      required this.checkOut});

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
        comments: data['Manager Comments'] ?? "",
        status: data['Approval'] ?? "Pending",
        startTime: data['Start Time'] ?? "",
        checkOut: data['Check Out']);
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
      'Manager Comments': comments,
      'Approval': status,
      'Start Time': startTime,
      'Check Out': checkOut
    };
  }
}
