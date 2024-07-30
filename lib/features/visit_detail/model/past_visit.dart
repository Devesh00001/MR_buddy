class PastVisit {
  String mrName;
  String clientName;
  String date;
  String drugsPrescribed;
  String queriesEncountered;
  String additionalNotes;
  String leadScore;
  String leadSuggestion;
  String physicalVisit;
  String callSupport;
  String messageSupport;

  PastVisit(
      {required this.mrName,
      required this.clientName,
      required this.date,
      required this.drugsPrescribed,
      required this.queriesEncountered,
      required this.additionalNotes,
      required this.leadScore,
      required this.leadSuggestion,
      required this.physicalVisit,
      required this.callSupport,
      required this.messageSupport});

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
        physicalVisit: data['Physical Visit'] ?? "",
        callSupport: data['Call Support'] ?? "",
        messageSupport: data['Message Support'] ?? "");
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
      'Call Support': callSupport,
      'Message Support': messageSupport
    };
  }
}
