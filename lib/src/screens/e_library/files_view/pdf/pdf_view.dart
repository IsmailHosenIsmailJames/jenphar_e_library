import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewInAPP extends StatelessWidget {
  final String pdfUrlLink;
  const PdfViewInAPP({super.key, required this.pdfUrlLink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF view"),
      ),
      body: SfPdfViewer.network(
        pdfUrlLink,
      ),
    );
  }
}
