import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils.dart';
import '../../drugs/screen/drug_detail.dart';
import '../../weekly plan/model/visit.dart';
import '../../weekly plan/widgets/custom_dropdown.dart';
import '../provider/visitdetail_provider.dart';
import 'visit_status.dart';
import '../screen/visit_detail.dart';

class DrugInfo extends StatefulWidget {
  const DrugInfo({super.key, required this.visit});
  final Visit visit;

  @override
  State<DrugInfo> createState() => _DrugInfoState();
}

class _DrugInfoState extends State<DrugInfo> {
  @override
  Widget build(BuildContext context) {
    return Consumer<VisitDetailProvider>(
        builder: (context, visitDetailProvider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VisitStatus(visit: widget.visit),
          const SizedBox(height: 20),
          Form(
            key: formKeys[visitDetailProvider.getCurrectStep()],
            child: CustomDropdown(
              hintText: "Visit Type",
              placeHolder: "Select visit type",
              values: visitDetailProvider.visitTypes,
              selectedValue: visitDetailProvider.selectedVisitType,
              setFunction: visitDetailProvider.setVisitType,
              validateFunction: visitDetailProvider.validateInput,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Suggested Medication",
            style: TextStyle(color: HexColor("1F1F1F").withOpacity(0.5)),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: Utils.deviceHeight * 0.4,
            child: ListView(
              children: visitDetailProvider.drugs.map((item) {
                return Column(
                  children: [
                    CheckboxListTile(
                      title: Row(
                        children: [
                          Hero(
                            tag: item.name,
                            child: SizedBox(
                              height: 40,
                              child: Center(
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                      'assets/image/placeholder_image.jpg',
                                  image:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTK7_sxxNSHR3PuZwILx0tQMu-YfiRNWInW5A&s',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                item.newDrug
                                    ? const BlinkText(
                                        "New",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.red),
                                      )
                                    : SizedBox.shrink()
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DrugDetails(drug: item)));
                            },
                            child: const Text('View'),
                          ),
                        ],
                      ),
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      value: visitDetailProvider.selectedDrugs.contains(item),
                      onChanged: (isSelected) {
                        setState(() {
                          if (isSelected!) {
                            visitDetailProvider.addDrugs(item);
                          } else {
                            visitDetailProvider.removeDrugs(item);
                          }
                        });
                      },
                    ),
                    const Divider()
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      );
    });
  }
}
