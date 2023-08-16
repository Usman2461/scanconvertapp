import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';


Future<List<String>> getPdfFiles() async {
  List<String> pdfFiles = [];
  Directory appDocDir = await getApplicationDocumentsDirectory();
  Directory directory = Directory(appDocDir.path);

  List<FileSystemEntity> fileList = directory.listSync();

  for (var file in fileList) {
    if (file is File && file.path.endsWith('.pdf')) {
      pdfFiles.add(file.path);
    }
  }

  return pdfFiles;
}

class PDFListScreen extends StatefulWidget {
  @override
  _PDFListScreenState createState() => _PDFListScreenState();
}

class _PDFListScreenState extends State<PDFListScreen> {
  late List<String>? pdfFiles;

  @override
  void initState() {
    super.initState();
    getPdfFiles().then((files) {
      setState(() {
        pdfFiles = files;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (pdfFiles == null) {
      return CircularProgressIndicator(); // Display a loading indicator
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Files'),
      ),
      body: ListView.builder(
        itemCount: pdfFiles!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pdfFiles![index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFViewScreen(pdfPath: pdfFiles![index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PDFViewScreen extends StatelessWidget {
  final String pdfPath;

  PDFViewScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}

