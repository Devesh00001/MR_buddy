import 'package:auto_size_text/auto_size_text.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mr_buddy/utils.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../../welcome/model/user.dart';
import '../../welcome/provider/welcome_provider.dart';
import '../model/drug.dart';
import '../provider/drugs_provider.dart';
import '../widget/drug_detail_card.dart';
import 'drug_log_screen.dart';

class DrugDetails extends StatefulWidget {
  const DrugDetails({super.key, required this.drug});
  final Drug drug;

  @override
  State<DrugDetails> createState() => _DrugDetailsState();
}

class _DrugDetailsState extends State<DrugDetails> {
  @override
  void initState() {
    super.initState();
    User? user = Provider.of<WelcomeProvider>(context, listen: false).user;
    final provider = Provider.of<DrugsProvider>(context, listen: false);
    provider.updateLog(widget.drug.name, 'total', user!.name);
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<WelcomeProvider>(context, listen: false).user;

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        final provider = Provider.of<DrugsProvider>(context, listen: false);
        provider.resetProvider();
      },
      child: Scaffold(
          appBar: const CustomAppBar(title: "Drug Detail"),
          body:
              Consumer<DrugsProvider>(builder: (context, drugProvider, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GradientText(
                          widget.drug.name,
                          style: const TextStyle(fontSize: 24),
                          colors: [
                            HexColor("00AE4D"),
                            HexColor("2F52AC"),
                          ],
                        ),
                        Visibility(
                          visible: user!.role != 'MR',
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const DrugLogScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: HexColor("00AE4D"),
                                  padding: const EdgeInsets.all(0),
                                  visualDensity:
                                      const VisualDensity(vertical: -2),
                                  elevation: 0,
                                  shape: SmoothRectangleBorder(
                                      side:
                                          BorderSide(color: HexColor("00AE4D")),
                                      borderRadius:
                                          const SmoothBorderRadius.all(
                                              SmoothRadius(
                                                  cornerRadius: 5,
                                                  cornerSmoothing: 1))),
                                  textStyle: const TextStyle(fontSize: 16)),
                              child: const Text("Logs")),
                        )
                      ],
                    ),
                  ),
                  Hero(
                    tag: widget.drug.name,
                    child: SizedBox(
                      height: Utils.deviceHeight * 0.4,
                      child: Center(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/image/placeholder_image.jpg',
                          image: widget.drug.image,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(widget.drug.description),
                  ),
                  const SizedBox(height: 10),
                  ExpansionTile(
                    collapsedBackgroundColor:
                        const Color.fromARGB(255, 226, 241, 255),
                    collapsedIconColor: Colors.black,
                    iconColor: Colors.black,
                    shape: const Border(top: BorderSide(color: Colors.grey)),
                    collapsedShape:
                        const Border(top: BorderSide(color: Colors.grey)),
                    onExpansionChanged: (value) {
                      if (drugProvider.getPromotionalDetailFlag() == true) {
                        drugProvider.updateLog(
                            widget.drug.name, 'promotionalDetail', user.name);
                      }
                      drugProvider.changeStatusPromotionalDetailFlag();
                    },
                    title: const Text(
                      "Promotional Detail",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    children: [
                      PromotionalDetail(drug: widget.drug),
                    ],
                  ),
                  ExpansionTile(
                    collapsedBackgroundColor:
                        const Color.fromARGB(255, 226, 241, 255),
                    collapsedIconColor: Colors.black,
                    iconColor: Colors.black,
                    shape: const Border(top: BorderSide(color: Colors.grey)),
                    collapsedShape:
                        const Border(top: BorderSide(color: Colors.grey)),
                    onExpansionChanged: (value) {
                      if (drugProvider.getEfficacyDataFlag() == true) {
                        drugProvider.updateLog(
                            widget.drug.name, 'efficacyData', user.name);
                      }
                      drugProvider.changeStatusEfficacyDataFlag();
                    },
                    title: const Text(
                      "Efficacy Data",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    children: [
                      DrugDetailCard(
                        heading: "Clinical Trial Results",
                        value: widget.drug.clinicalTrialResults,
                      ),
                      const SizedBox(height: 10),
                      DrugDetailCard(
                        heading: "Real World Effectiveness",
                        value: widget.drug.realWorldEffectiveness,
                      ),
                    ],
                  ),
                  ExpansionTile(
                    collapsedBackgroundColor:
                        const Color.fromARGB(255, 226, 241, 255),
                    collapsedIconColor: Colors.black,
                    iconColor: Colors.black,
                    shape: const Border(top: BorderSide(color: Colors.grey)),
                    collapsedShape:
                        const Border(top: BorderSide(color: Colors.grey)),
                    onExpansionChanged: (value) {
                      if (drugProvider.getSafetyDataFlag() == true) {
                        drugProvider.updateLog(
                            widget.drug.name, 'safetyData', user.name);
                      }
                      drugProvider.changeStatusSafetyDataFlag();
                    },
                    title: const Text(
                      "Safety Data",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    children: [
                      DrugDetailCard(
                        heading: "Side Effects",
                        value: widget.drug.sideEffects,
                      ),
                      const SizedBox(height: 10),
                      DrugDetailCard(
                        heading: "Drug Interactions",
                        value: widget.drug.drugInteractions,
                      ),
                    ],
                  ),
                  ExpansionTile(
                    collapsedBackgroundColor:
                        const Color.fromARGB(255, 226, 241, 255),
                    collapsedIconColor: Colors.black,
                    iconColor: Colors.black,
                    shape: const Border(top: BorderSide(color: Colors.grey)),
                    collapsedShape:
                        const Border(top: BorderSide(color: Colors.grey)),
                    onExpansionChanged: (value) {
                      if (drugProvider.getdosageInfoFlag() == true) {
                        drugProvider.updateLog(
                            widget.drug.name, 'dosageInfo', user.name);
                      }
                      drugProvider.changeStatusDosageInfoFlag();
                    },
                    title: const Text(
                      "Dosage Information",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    children: [
                      DrugDetailCard(
                        heading: "Side Effects",
                        value: widget.drug.sideEffects,
                      ),
                      const SizedBox(height: 10),
                      DrugDetailCard(
                        heading: "Drug Interactions",
                        value: widget.drug.drugInteractions,
                      ),
                    ],
                  ),
                ],
              ),
            );
          })),
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
                          Expanded(
                            child: AutoSizeText(
                              drug.offers[index]['Summary'] ?? "",
                              maxFontSize: 13,
                              minFontSize: 10,
                              // style: const TextStyle(fontSize: 13),
                            ),
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
