import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';

import '../../../widgets/custom_appbar.dart';

class PDFScreen extends StatefulWidget {
  const PDFScreen({super.key, required this.filePath});
  final String filePath;

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  late PdfControllerPinch pdfControllerPinch;
  int totalPages = 0;
  int currentPage = 1;
  @override
  void initState() {
    super.initState();
    pdfControllerPinch =
        PdfControllerPinch(document: PdfDocument.openFile(widget.filePath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Document"),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.black,
          child: const Icon(Icons.share, color: Colors.white),
          onPressed: () {
            Share.shareXFiles([XFile(widget.filePath)]);
          }),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Total Pages : $totalPages"),
            IconButton(
                onPressed: () {
                  pdfControllerPinch.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear);
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            Text("Current Pages : $currentPage"),
            IconButton(
                onPressed: () {
                  pdfControllerPinch.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear);
                },
                icon: const Icon(Icons.arrow_forward_ios_rounded))
          ],
        ),
        _pdfView()
      ],
    );
  }

  Widget _pdfView() {
    return Expanded(
        child: PdfViewPinch(
      controller: pdfControllerPinch,
      onDocumentLoaded: (doc) {
        setState(() {
          totalPages = doc.pagesCount;
        });
      },
      onPageChanged: (page) {
        setState(() {
          currentPage = page;
        });
      },
    ));
  }
}
