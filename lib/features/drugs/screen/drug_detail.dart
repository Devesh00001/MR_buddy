import 'package:flutter/material.dart';
import 'package:mr_buddy/utils.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../model/drug.dart';
import '../widget/drug_detail_card.dart';

class DrugDetails extends StatelessWidget {
  const DrugDetails({super.key, required this.drug});
  final Drug drug;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Drug Detail"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GradientText(
                drug.name,
                style: const TextStyle(fontSize: 24),
                colors: [
                  HexColor("00AE4D"),
                  HexColor("2F52AC"),
                ],
              ),
            ),
            Hero(
              tag: drug.name,
              child: SizedBox(
                height: Utils.deviceHeight * 0.4,
                child: Center(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/image/placeholder_image.jpg',
                    image: drug.image,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(drug.description),
            ),
            const SizedBox(height: 10),
            ExpansionTile(
              collapsedBackgroundColor:
                  const Color.fromARGB(255, 226, 241, 255),
              collapsedIconColor: Colors.black,
              iconColor: Colors.black,
              shape: const Border(top: BorderSide(color: Colors.grey)),
              collapsedShape: const Border(top: BorderSide(color: Colors.grey)),
              title: const Text(
                "Promotional Detail",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              children: [
                PromotionalDetail(drug: drug),
              ],
            ),
            ExpansionTile(
              collapsedBackgroundColor:
                  const Color.fromARGB(255, 226, 241, 255),
              collapsedIconColor: Colors.black,
              iconColor: Colors.black,
              shape: const Border(top: BorderSide(color: Colors.grey)),
              collapsedShape: const Border(top: BorderSide(color: Colors.grey)),
              title: const Text(
                "Efficacy Data",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              children: [
                DrugDetailCard(
                  heading: "Clinical Trial Results",
                  value: drug.clinicalTrialResults,
                ),
                const SizedBox(height: 10),
                DrugDetailCard(
                  heading: "Real World Effectiveness",
                  value: drug.realWorldEffectiveness,
                ),
              ],
            ),
            ExpansionTile(
              collapsedBackgroundColor:
                  const Color.fromARGB(255, 226, 241, 255),
              collapsedIconColor: Colors.black,
              iconColor: Colors.black,
              shape: const Border(top: BorderSide(color: Colors.grey)),
              collapsedShape: const Border(top: BorderSide(color: Colors.grey)),
              title: const Text(
                "Safety Data",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              children: [
                DrugDetailCard(
                  heading: "Side Effects",
                  value: drug.sideEffects,
                ),
                const SizedBox(height: 10),
                DrugDetailCard(
                  heading: "Drug Interactions",
                  value: drug.drugInteractions,
                ),
              ],
            ),
            ExpansionTile(
              collapsedBackgroundColor:
                  const Color.fromARGB(255, 226, 241, 255),
              collapsedIconColor: Colors.black,
              iconColor: Colors.black,
              shape: const Border(top: BorderSide(color: Colors.grey)),
              collapsedShape: const Border(top: BorderSide(color: Colors.grey)),
              title: const Text(
                "Dosage Information",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              children: [
                DrugDetailCard(
                  heading: "Side Effects",
                  value: drug.sideEffects,
                ),
                const SizedBox(height: 10),
                DrugDetailCard(
                  heading: "Drug Interactions",
                  value: drug.drugInteractions,
                ),
              ],
            ),
          ],
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
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Offers and Discount",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
                          SizedBox(
                            width: 30,
                            child: Text(
                              drug.offers[index]['Discount'] ?? "",
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 14),
                            ),
                          ),
                          const VerticalDivider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                          Text(
                            drug.offers[index]['Summary'] ?? "",
                            style: const TextStyle(fontSize: 13),
                          )
                        ],
                      ));
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Product Literature",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              TextButton(onPressed: () {}, child: const Text("Download PDF"))
            ],
          ),
        ],
      ),
    );
  }
}
