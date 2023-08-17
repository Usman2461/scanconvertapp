import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class showAllFiles extends StatefulWidget {
  @override
  _DocumentViewerState createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<showAllFiles> {
  List<String> documentPaths = [];

  @override
  void initState() {
    super.initState();
    _fetchDocuments();
  }

  Future<void> _fetchDocuments() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      Directory? rootDir = await getExternalStorageDirectory();
      Directory? externalStorageDir = Directory('/storage/emulated/0/Download');
      print(rootDir);
      await _searchForDocuments(externalStorageDir);

      setState(() {});
    } else {
      // Handle permission not granted
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Viewer'),
      ),
      body: ListView.builder(
        itemCount: documentPaths.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(documentPaths[index], style: TextStyle(color: Colors.amber),),
          );
        },
      ),
      bottomNavigationBar: Row(
        children: [
          Text(documentPaths.length.toString()),
          ElevatedButton(onPressed: (){
            _fetchDocuments();
          }, child: Text("sdd"))
        ],
      ),
    );
  }




  Future<void> _searchForDocuments(Directory dir) async {
    List<FileSystemEntity> entities = dir.listSync(recursive: true, followLinks: false);
    print(entities);
    for (var entity in entities) {
      if (entity is Directory) {
        await _searchForDocuments(entity);
      } else if (entity is File) {
        // Check the file extension or other criteria to identify documents
        if (_isDocumentFile(entity.path)) {
          documentPaths.add(entity.path);
        }
      }
    }
  }

  bool _isDocumentFile(String filePath) {
    // Implement logic to determine if a file is a document based on its extension or content
    // For example, you could check for common document extensions like .pdf, .doc, .docx, etc.
    return filePath.toLowerCase().endsWith('.pdf') ||
        filePath.toLowerCase().endsWith('.doc') ||
        filePath.toLowerCase().endsWith('.docx');
  }


}


//file updated