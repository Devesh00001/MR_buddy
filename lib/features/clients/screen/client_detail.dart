import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:mr_buddy/features/clients/model/clients.dart';
import 'package:mr_buddy/features/visit_detail/model/past_visit.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import '../../../widgets/custom_appbar.dart';
import '../provider/client_provider.dart';
import '../widget/client_data_row.dart';
import 'past_visit_detail.dart';

class ClientDetail extends StatelessWidget {
  const ClientDetail({super.key, required this.client});
  final Client client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Client Detail"),
      body: Stack(
        children: [
          Positioned(
              child: Container(
            height: Utils.deviceHeight * 0.3,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  HexColor("00AE4D"),
                  HexColor("00AE4D").withOpacity(0.5)
                ])),
          )),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client.name,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                const CilentDataRow(
                  title: "Position",
                  value: "Cardiologist",
                ),
                const SizedBox(height: 10),
                CilentDataRow(
                  title: "Hospital",
                  value: client.hospital,
                ),
                const SizedBox(height: 10),
                CilentDataRow(
                  title: "Address",
                  value: client.address,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Visit's",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Consumer<ClinetProvider>(
                    builder: (context, clinetProvider, child) {
                  return Expanded(
                    child: FutureBuilder<Map<String, Map<String, PastVisit>>>(
                      future: clinetProvider.getPastVisits(client.name),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text('No Visits found'));
                        } else {
                          List<Widget> visitWidgets = [];

                          snapshot.data!.forEach((date, timeMap) {
                            timeMap.forEach((time, pastVisit) {
                              visitWidgets.add(
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PastVisitDetail(
                                                    pastVisit: pastVisit)));
                                  },
                                  child: Container(
                                    height: Utils.deviceHeight * 0.09,
                                    margin: const EdgeInsets.all(10),
                                    decoration: ShapeDecoration(
                                      shadows: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      color: HexColor("F6F5F5"),
                                      shape: SmoothRectangleBorder(
                                        borderRadius: SmoothBorderRadius(
                                          cornerRadius: 15,
                                          cornerSmoothing: 1,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: ListTile(
                                        title: Text(
                                          pastVisit.mrName,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        subtitle: Text('$date - $time'),
                                        subtitleTextStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            height: 2),
                                        trailing: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              TweenAnimationBuilder<double>(
                                                tween: Tween(
                                                    begin: 0,
                                                    end: int.parse(pastVisit
                                                            .leadScore) /
                                                        100),
                                                duration:
                                                    const Duration(seconds: 1),
                                                builder: (context, value, _) =>
                                                    CircularProgressIndicator(
                                                  strokeWidth: 5,
                                                  strokeCap: StrokeCap.round,
                                                  backgroundColor:
                                                      HexColor("4AB97B")
                                                          .withOpacity(0.5),
                                                  color: HexColor("4AB97B"),
                                                  value: value,
                                                ),
                                              ),
                                              Text(
                                                "${pastVisit.leadScore}%",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                          });

                          return ListView(children: visitWidgets);
                        }
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
