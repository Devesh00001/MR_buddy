class Drug {
  String name;
  String description;
  String image;
  List offers;
  String productLiterature;
  String clinicalTrialResults;
  String realWorldEffectiveness;
  String sideEffects;
  String drugInteractions;
  String recommendedDoses;
  String frequency;
  String administrationMethods;

  Drug(
      {required this.name,
      required this.description,
      required this.image,
      required this.offers,
      required this.productLiterature,
      required this.clinicalTrialResults,
      required this.realWorldEffectiveness,
      required this.sideEffects,
      required this.drugInteractions,
      required this.recommendedDoses,
      required this.frequency,
      required this.administrationMethods});

  factory Drug.fromJson(Map<String, dynamic> data) {
    return Drug(
        name: data['Name'],
        description: data['Description'] ?? "",
        image: data['Image'] ?? "",
        offers: data['Offers'] ?? [],
        productLiterature: data['Product Literature'] ?? "",
        clinicalTrialResults: data['Clinical Trial Results'] ?? "",
        realWorldEffectiveness: data['Real World Effectiveness'] ?? "",
        sideEffects: data['Side Effects'] ?? "",
        drugInteractions: data['Drug Interactions'] ?? "",
        recommendedDoses: data['Recommended Doses'] ?? "",
        frequency: data['Frequency'] ?? "",
        administrationMethods: data['Administration Methods'] ?? "");
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Description': description,
      'Image': image,
      'Offers': offers,
      'Product Literature': productLiterature,
      'Clinical Trial Results': clinicalTrialResults,
      'Real World Effectiveness': realWorldEffectiveness,
      'Side Effects': sideEffects,
      'Drug Interactions': drugInteractions,
      'Recommended Doses': recommendedDoses,
      'Frequency': frequency,
      'Administration Methods': administrationMethods
    };
  }
}
