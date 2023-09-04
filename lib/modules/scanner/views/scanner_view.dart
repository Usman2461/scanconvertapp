import 'dart:io';

import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../../app/components/no_data.dart';
class ScannerView extends StatefulWidget {
  const ScannerView({super.key});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  PDFDocument? _scannedDocument;
  File? _scannedDocumentFile;
  File? _scannedImage;

  openPdfScanner(BuildContext context) async {
    var doc = await DocumentScannerFlutter.launchForPdf(
      context,
      labelsConfig: {
        ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Steps",
        ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_SINGLE: "Only 1 Page",
        ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_MULTIPLE:
        "Only {PAGES_COUNT} Page"
      },
      //source: ScannerFileSource.CAMERA
    );
    if (doc != null) {
      _scannedDocument = null;
      setState(() {});
      await Future.delayed(Duration(milliseconds: 100));
      _scannedDocumentFile = doc;
      _scannedDocument = await PDFDocument.fromFile(doc);
      setState(() {});
    }
  }

  openImageScanner(BuildContext context) async {
    var image = await DocumentScannerFlutter.launch(context,
        //source: ScannerFileSource.CAMERA,
        labelsConfig: {
          ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Step",
          ScannerLabelsConfig.ANDROID_OK_LABEL: "OK"
        });
    if (image != null) {
      _scannedImage = image;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Scanner'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_scannedDocument != null || _scannedImage != null) ...[
            if (_scannedImage != null)
              Image.file(_scannedImage!,
                  width: 300, height: 300, fit: BoxFit.contain),
            if (_scannedDocument != null)
              Expanded(
                  child: PDFViewer(
                    document: _scannedDocument!,
                  )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  _scannedDocumentFile?.path ?? _scannedImage?.path ?? ''),
            ),
          ],
          Center(
            child: Builder(builder: (context) {
              return ElevatedButton(
                  onPressed: () => openPdfScanner(context),
                  child: Text("PDF Scan"));
            }),
          ),
          Center(
            child: Builder(builder: (context) {
              return ElevatedButton(
                  onPressed: () => openImageScanner(context),
                  child: Text("Image Scan"));
            }),
          )
        ],
      ),
    );
  }
}
