import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer_null_safe/full_pdf_viewer_scaffold.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_file_view/flutter_file_view.dart';
class PDFViewerPage extends StatelessWidget {
  final String pdfPath; // Provide the path to your PDF file

  PDFViewerPage({required this.pdfPath,required this.controller});
  final FileViewController controller;
  @override
  Widget build(BuildContext context) {
    print(controller.keyName);
    return PDFViewerScaffold(
      appBar: AppBar(title: const Text('PDF Reader')),
      // body: Column(
      //   children: <Widget>[
      //     Expanded(
      //       child: FileView(
      //         controller: controller,
      //         onCustomViewStatusBuilder: (_, ViewStatus status) {
      //           print(ViewStatus.LOADING);
      //           if (status == ViewStatus.LOADING) {
      //             return Container(color: Colors.red);
      //           }
      //           return null;
      //         },
      //         onCustomX5StatusBuilder: (_, X5Status status) {
      //           if (status == ViewStatus.LOADING) {
      //             return Container(color: Colors.red);
      //           }
      //           return null;
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      path: pdfPath,
    );
  }
}
