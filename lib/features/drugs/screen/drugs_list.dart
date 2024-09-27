import 'package:figma_squircle/figma_squircle.dart';
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
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 0),
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
                                    child: Text(
                                      drugsProvider.displayDrugList[index].name,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 16 * Utils.fontSizeModifer),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: Utils.deviceHeight * 0.05,
                                      width: Utils.deviceWidth * 0.7,
                                      child: Text(
                                        drugsProvider
                                            .displayDrugList[0].description,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize:
                                                10 * Utils.fontSizeModifer),
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
