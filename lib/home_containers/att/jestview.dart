import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatelessWidget {
  final String downloadUrl;
  static String routename = 'PdfViewer';

  PdfViewer({required this.downloadUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('PDF Viewer'),
        titleTextStyle: TextStyle(
            color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 23),
        backgroundColor: Colors.white,
      ),
      body: SfPdfViewer.network(downloadUrl),
    );
  }
}
