import 'package:auto_size_text/auto_size_text.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DrugDetails(
                                  drug: drugsProvider.displayDrugList[0])));
                        },
                        child: Container(
                          height: Utils.deviceHeight * 0.1,
                          width: Utils.deviceWidth * 0.9,
                          constraints: BoxConstraints(minHeight: 70),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: SmoothRectangleBorder(
                              borderRadius: SmoothBorderRadius(
                                cornerRadius: 15,
                                cornerSmoothing: 1,
                              ),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Hero(
                                tag: drugsProvider.displayDrugList[index].name,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        'assets/image/placeholder_image.jpg',
                                    image:
                                        drugsProvider.displayDrugList[0].image,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      drugsProvider.displayDrugList[index].name,
                                      minFontSize: 16,
                                      maxFontSize: 20,
                                      maxLines: 1,
                                      // style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: Utils.deviceHeight * 0.05,
                                      width: Utils.deviceWidth * 0.7,
                                      child: AutoSizeText(
                                        drugsProvider
                                            .displayDrugList[0].description,
                                        overflow: TextOverflow.clip,
                                        minFontSize: 12,
                                        maxFontSize: 16,
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
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
