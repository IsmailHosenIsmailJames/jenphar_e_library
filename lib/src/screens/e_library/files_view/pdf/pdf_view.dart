import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jenphar_e_library/src/screens/home/home_screen.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewPage extends StatelessWidget {
  final String url;
  const PdfViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, "PDF"),
      body: SfPdfViewer.network(
        url,
      ),
    );
  }
}
