class PastVisit {
  String mrName;
  String clientName;
  String date;
  String drugsPrescribed;
  String queriesEncountered;
  String additionalNotes;
  String leadScore;
  String leadSuggestion;
  String visitType;
  String time;
  String imageUrl;

  PastVisit(
      {required this.mrName,
      required this.clientName,
      required this.date,
      required this.drugsPrescribed,
      required this.queriesEncountered,
      required this.additionalNotes,
      required this.leadScore,
      required this.leadSuggestion,
      required this.visitType,
      required this.time,
      required this.imageUrl});

  factory PastVisit.fromJson(Map<String, dynamic> data) {
    return PastVisit(
        clientName: data['Client'],
        mrName: data["MR Name"],
        date: data['Date'],
        drugsPrescribed: data["Drugs Prescribed"],
        queriesEncountered: data["Queries Encountered"],
        additionalNotes: data["Additional Notes"],
        leadScore: data['Lead Score'],
        leadSuggestion: data['Lead Suggestion'],
        visitType: data['Visit Type'] ?? "",
        time: data['Time'] ?? '',
        imageUrl: data['image URL'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'Client': clientName,
      'MR Name': mrName,
      'Date': date,
      'Drugs Prescribed': drugsPrescribed,
      'Queries Encountered': queriesEncountered,
      'Additional Notes': additionalNotes,
      'Lead Score': leadScore,
      'Lead Suggestion': leadSuggestion,
      'Physical Visit': leadSuggestion,
      'Visit Type': visitType,
      'Time': time,
      'image URL': imageUrl
    };
  }
}
