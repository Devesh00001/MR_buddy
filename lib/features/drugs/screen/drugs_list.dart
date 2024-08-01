import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import '../provider/drugs_provider.dart';
import 'drug_detail.dart';

class DrugsList extends StatefulWidget {
  const DrugsList({super.key});

  @override
  State<DrugsList> createState() => _DrugsListState();
}

class _DrugsListState extends State<DrugsList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DrugsProvider>(context, listen: false);
      provider.getDrugName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DrugsProvider>(builder: (context, drugsProvider, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                drugsProvider.getSearchList(value);
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                isCollapsed: true,
                contentPadding: EdgeInsets.all(10),
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: drugsProvider.isLoading
                ? Center(
                    child:
                        Lottie.asset("assets/lottie/loading.json", height: 200))
                : ListView.builder(
                    itemCount: drugsProvider.displayDrugList.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        height: Utils.deviceHeight * 0.1,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: HexColor("2F52AC"),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: ListTile(
                            trailing: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    minimumSize: Size.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: HexColor("00AE4D")),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DrugDetails(
                                          drug: drugsProvider
                                              .displayDrugList[0])));
                                },
                                child: const Text(
                                  "View",
                                  style: TextStyle(color: Colors.white),
                                )),
                            title: Text(
                              drugsProvider.displayDrugList[index].name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            subtitleTextStyle: const TextStyle(
                                color: Colors.white, fontSize: 12, height: 2),
                          ),
                        ),
                      );
                    }),
          ),
        ],
      );
    });
  }
}
