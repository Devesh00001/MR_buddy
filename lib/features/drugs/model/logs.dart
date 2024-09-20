class Logs {
  String date;
  int total;
  int promotionalDetail;
  int efficacyData;
  int safetyData;
  int dosageInfo;

  Logs({
    required this.date,
    required this.total,
    required this.promotionalDetail,
    required this.efficacyData,
    required this.safetyData,
    required this.dosageInfo,
  });

  factory Logs.fromMap(String date, Map<String, dynamic> data) {
    return Logs(
      date: date,
      total: data['total'] ?? 0,
      promotionalDetail: data['promotionalDetail'] ?? 0,
      efficacyData: data['efficacyData'] ?? 0,
      safetyData: data['safetyData'] ?? 0,
      dosageInfo: data['dosageInfo'] ?? 0,
    );
  }
}
