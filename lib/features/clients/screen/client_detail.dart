import 'package:flutter/material.dart';
import 'package:mr_buddy/features/clients/model/clients.dart';
import 'package:mr_buddy/features/visit_detail/model/past_visit.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import '../../../widgets/custome_appbar.dart';
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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              client.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Consumer<ClinetProvider>(builder: (context, clinetProvider, child) {
              return Expanded(
                child: FutureBuilder<Map<String, PastVisit>>(
                    future: clinetProvider.getPastVisits(client.name),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No Visits found'));
                      } else {
                        return ListView(
                            children:
                                clinetProvider.pastVisit.entries.map((entry) {
                          String day = entry.key;
                          PastVisit pastVisit = entry.value;

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
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        backgroundColor: HexColor("00AE4D")),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PastVisitDetail(
                                                      pastVisit: pastVisit)));
                                    },
                                    child: const Text(
                                      "View",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                title: Text(
                                  day,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                subtitle: Text(pastVisit.mrName),
                                subtitleTextStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    height: 2),
                              ),
                            ),
                          );
                        }).toList());
                      }
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}
