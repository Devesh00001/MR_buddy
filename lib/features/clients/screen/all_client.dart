import 'package:auto_size_text/auto_size_text.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mr_buddy/features/clients/screen/client_detail.dart';
import 'package:mr_buddy/utils.dart';
import 'package:provider/provider.dart';
import '../provider/client_provider.dart';

class AllClientScreen extends StatefulWidget {
  const AllClientScreen({super.key});

  @override
  State<AllClientScreen> createState() => _AllClientScreenState();
}

class _AllClientScreenState extends State<AllClientScreen> {
  @override
  void initState() {
    final provider = Provider.of<ClinetProvider>(context, listen: false);
    provider.getClientName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bool isTab = Utils.deviceWidth > 600 ? true : false;
    return Consumer<ClinetProvider>(builder: (context, clinetProvider, child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                clinetProvider.filterItems(value);
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
            child: ListView.builder(
                itemCount: clinetProvider.displayClientList.length,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ClientDetail(
                              client:
                                  clinetProvider.displayClientList[index])));
                    },
                    child: Container(
                      height: Utils.deviceHeight * 0.09,
                      constraints: BoxConstraints(minHeight: 70),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: ShapeDecoration(
                        color: HexColor("F6F5F5"),
                        shadows: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        shape: SmoothRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                            cornerRadius: 15,
                            cornerSmoothing: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(FontAwesomeIcons.userMd, size: 25),
                              const SizedBox(width: 10),
                              AutoSizeText(
                                clinetProvider.displayClientList[index].name,
                                style: TextStyle(
                                    fontSize: 14 * Utils.fontSizeModifer,
                                    fontWeight: FontWeight.w600,
                                    color: HexColor("2F52AC")),
                              ),
                            ],
                          ),
                          Text(
                            "Hospital: ${clinetProvider.displayClientList[index].hospital}",
                            style:
                                TextStyle(fontSize: 14 * Utils.fontSizeModifer),
                          ),
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
