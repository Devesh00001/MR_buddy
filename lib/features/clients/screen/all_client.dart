import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                minimumSize: Size.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                backgroundColor: HexColor("00AE4D")),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ClientDetail(
                                      client: clinetProvider
                                          .displayClientList[index])));
                            },
                            child: const Text(
                              "View",
                              style: TextStyle(color: Colors.white),
                            )),
                        title: Text(
                          clinetProvider.displayClientList[index].name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                        subtitle: Text(
                            clinetProvider.displayClientList[index].address),
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
