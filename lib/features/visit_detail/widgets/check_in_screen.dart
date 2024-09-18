import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import '../../weekly plan/model/visit.dart';
import '../provider/visitdetail_provider.dart';
import 'visit_status.dart';
import '../screen/summary_page.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key, required this.visit});
  final Visit visit;

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  Future<void> takePicture() async {
    final picker = ImagePicker();

    try {
      XFile? picture = await picker.pickImage(source: ImageSource.camera);

      if (picture != null) {
        final provider =
            Provider.of<VisitDetailProvider>(context, listen: false);
        provider.setImagePath(picture);
      }
    } catch (e) {
      debugPrint('Error occurred while taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitDetailProvider>(
        builder: (context, visitDetailProvider, child) {
      // bool isTab = Utils.deviceWidth > 600 ? true : false;
      return SingleChildScrollView(
        child: Column(
          children: [
            VisitStatus(visit: widget.visit),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Capture Location Image",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: Utils.isTab ? 20 : 16),
                ),
                InkWell(
                  onTap: () {
                    takePicture();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    height: visitDetailProvider.getImage() != null
                        ? Utils.deviceWidth * 0.29
                        : Utils.deviceWidth * 0.15,
                    width: Utils.deviceWidth * 0.9,
                    child: visitDetailProvider.getImage() != null
                        ? SizedBox(
                            height: Utils.deviceWidth * 0.25,
                            width: Utils.deviceWidth * 0.15,
                            child: Image.file(
                                File(visitDetailProvider.getImage()!.path)))
                        : const Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                            size: 50,
                          ),
                  ),
                ),
                Visibility(
                    visible: !visitDetailProvider.getImageClickStatus(),
                    child: const Text(
                      'Please click image',
                      style: TextStyle(color: Colors.red),
                    )),
                const SizedBox(height: 12),
                SummaryCardTile(
                  title: "Health Associate",
                  value: widget.visit.clientName,
                ),
                const SizedBox(height: 12),
                SummaryCardTile(
                  title: "Place Type",
                  value: widget.visit.placeType,
                ),
                const SizedBox(height: 12),
                SummaryCardTile(
                  title: "Address",
                  value: widget.visit.address,
                ),
                const SizedBox(height: 12),
                SummaryCardTile(
                  title: "Visit Purpose/Plan",
                  value: widget.visit.purpose,
                ),
                const SizedBox(height: 12),
                SummaryCardTile(
                  title: "Contact Point/Doctor",
                  value: widget.visit.contactPoint,
                ),
                const SizedBox(height: 12),
                SummaryCardTile(
                  title: "Manager Comments",
                  value: widget.visit.comments,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
