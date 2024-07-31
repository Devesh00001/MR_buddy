import 'package:flutter/material.dart';
import 'package:mr_buddy/utils.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../../widgets/custome_appbar.dart';
import '../model/drug.dart';
import '../widget/drug_detail_card.dart';

class DrugDetails extends StatelessWidget {
  const DrugDetails({super.key, required this.drug});
  final Drug drug;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Drug Detail"),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                drug.name,
                style: const TextStyle(fontSize: 24),
                colors: [
                  HexColor("00AE4D"),
                  HexColor("2F52AC"),
                ],
              ),
              SizedBox(
                height: Utils.deviceHeight * 0.4,
                child: Center(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/image/placeholder_image.jpg',
                    image: drug.image,
                  ),
                ),
              ),
              Text(drug.description),
              const Divider(height: 20),
              const Text(
                "Promotional Detail",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              PromotionalDetail(drug: drug),
              const Divider(height: 20),
              const Text(
                "Efficacy Data",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              DrugDetailCard(
                heading: "Clinical Trial Results",
                value: drug.clinicalTrialResults,
              ),
              const SizedBox(height: 10),
              DrugDetailCard(
                heading: "Real World Effectiveness",
                value: drug.realWorldEffectiveness,
              ),
              Divider(height: 20),
              const Text(
                "Safety Data",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              DrugDetailCard(
                heading: "Side Effects",
                value: drug.sideEffects,
              ),
              const SizedBox(height: 10),
              DrugDetailCard(
                heading: "Drug Interactions",
                value: drug.drugInteractions,
              ),
              Divider(height: 20),
              const Text(
                "Dosage Information",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              DrugDetailCard(
                heading: "Recommended Doses",
                value: drug.recommendedDoses,
              ),
              const SizedBox(height: 10),
              DrugDetailCard(
                heading: "Frequency",
                value: drug.frequency,
              ),
              const SizedBox(height: 10),
              DrugDetailCard(
                heading: "Administration Methods",
                value: drug.administrationMethods,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PromotionalDetail extends StatelessWidget {
  const PromotionalDetail({super.key, required this.drug});

  final Drug drug;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Offers and Discount",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: Utils.deviceHeight * 0.2,
            child: ListView.builder(
                itemCount: drug.offers.length,
                itemBuilder: (ctx, index) {
                  return Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(0, 0))
                          ]),
                      child: Row(
                        children: [
                          Text(drug.offers[index]['Discount']),
                          const VerticalDivider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                          Text(drug.offers[index]['Summary'])
                        ],
                      ));
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Product Literature",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              TextButton(onPressed: () {}, child: const Text("Download PDF"))
            ],
          ),
        ],
      ),
    );
  }
}
