import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_view/flutter_file_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app/components/no_data.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../base/models/document_model.dart';
class ConverterView extends StatefulWidget {
  const ConverterView({super.key});

  @override
  State<ConverterView> createState() => _ConverterViewState();
}

class _ConverterViewState extends State<ConverterView> {
  String title="";
  List<DocumentInfo> documentList=[];
  int listLength = 0;
  late List<bool> fvrtList;
  @override
  void initState() {
    fvrtList = List.filled(documentList.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back), onPressed: (){},),
        title: Text('Select Document', style: context.theme.textTheme.displaySmall),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.folder_open,size:28),
          )
        ],
      ),
      body: documentList.isNotEmpty?ListView.builder(
        itemCount: documentList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                dense: true,
                leading:SvgPicture.asset(
                  (() {
                    if(documentList[index].path.endsWith(".pdf")){
                      return Constants.pdfIcon;
                    }
                    else if(documentList[index].path.endsWith(".doc") || documentList[index].path.endsWith(".docx")){
                      return Constants.wordIcon;
                    }
                    else if(documentList[index].path.endsWith('.xlsx')){
                      return Constants.excelIcon;
                    }
                    else if(documentList[index].path.endsWith('.ppt')||documentList[index].path.endsWith('.pptx')){
                      return Constants.pptIcon;
                    }
                    else if(documentList[index].path.endsWith('.txt')){
                      return Constants.txtIcon;
                    }
                    else{
                      return  Constants.allFilesIcon;
                    }
                  }())
                  ,height: 35,width: 30,),
                contentPadding: EdgeInsets.only(left: 12),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          setState(() {
                            fvrtList[index] = !fvrtList[index];
                          });
                        },
                        child: Icon(fvrtList[index]==false?Icons.star_border_outlined:Icons.star,color: Colors.white,)),
                    PopupMenuButton<int>(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18), // Customize the radius as needed
                      ),
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                        PopupMenuItem<int>(
                          value: 0,
                          child:  SvgPicture.asset(
                            Constants.pdfIcon,
                            height: 35,
                            width: 35,
                          ),
                        ),
                        PopupMenuItem<int>(
                          height: 30,
                          value: 1,
                          child: Text(documentList[index].path.split('/').last,style: TextStyle(fontSize: 14),),
                        ),
                        PopupMenuItem<int>(
                          height: 10,
                          value: 2,
                          child: Row(
                            children: [
                              Text(DateFormat("hh:mm a, MMM dd, yyyy").format(DateTime.parse(documentList[index].lastModified.toString())),style: TextStyle(color: Color(0xff9F9F9F) ,fontSize: 12 ),),
                              SizedBox(width: 10,),
                              Text(_formatFileSize(documentList[index].fileSizeMB),style: TextStyle(color: Color(0xff9F9F9F),fontSize: 12),),
                            ],
                          ),
                        ),
                        const PopupMenuItem<int>(
                          height: 10,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          value: 3,
                          child: Divider(color: Color(0xff707070),),
                        ),
                        PopupMenuItem<int>(
                          value: 4,
                          child: Row(
                            children: [
                              SvgPicture.asset(Constants.renameIcon,height: 18,width: 18,),
                              SizedBox(width: 10,),
                              Text(("Rename"),style: TextStyle(color: Colors.white,fontSize: 14,)),
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 5,
                          child: Row(
                            children: [
                              SvgPicture.asset(Constants.shareIcon,height: 18,width: 18,),
                              SizedBox(width: 10,),
                              Text(("Share"),style: TextStyle(color: Colors.white,fontSize: 14,)),
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 6,
                          child: Row(
                            children: [
                              SvgPicture.asset(Constants.infoIcon,height: 18,width: 18,),
                              SizedBox(width: 10,),
                              Text(("Info"),style: TextStyle(color: Colors.white,fontSize: 14,)),
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 7,
                          child: Row(
                            children: [
                              SvgPicture.asset(Constants.deleteIcon,height: 18,width: 18,),
                              SizedBox(width: 10,),
                              Text(("Delete"),style: TextStyle(color: Colors.white,fontSize: 14,)),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (int result) {
                        if (result == 4) {
                          _showRenameDialog(context,documentList[index].path);
                          // Handle option 1 selection
                        } else if (result == 5) {
                          // Handle option 2 selection
                        } else if (result == 6) {
                          _showInformationDialog(context,documentList[index].path,_formatFileSize(documentList[index].fileSizeMB),DateFormat("hh:mm a, MMM dd, yyyy").format(DateTime.parse(documentList[index].lastModified.toString())));

                          // Handle option 3 selection
                        }
                        else if (result == 7) {
                          _showDeleteDialog(context, documentList[index].path,index);
                          // Handle option 3 selection
                        }
                      },
                      icon: SvgPicture.asset(
                        Constants.dotsIcon,
                        height: 20,
                        width: 10,
                      ),
                    ),
                  ],
                ),
                title: Text(documentList[index].path.toString().split('/').last,style: TextStyle(fontSize: 14),),
                subtitle: Row(
                  children: [
                    Text(DateFormat("hh:mm a, MMM dd, yyyy").format(DateTime.parse(documentList[index].lastModified.toString())),style: TextStyle(color: Color(0xff9F9F9F) ,fontSize: 12),),
                    SizedBox(width: 5,),
                    Text(_formatFileSize(documentList[index].fileSizeMB),style: TextStyle(color: Color(0xff9F9F9F),fontSize: 12),),
                  ],
                ),
                onTap: () async {
                  FileViewController? controller;
                  controller = FileViewController.file(
                    File(documentList[index].path),
                  );
                }
            ),
          );
          //   ListTile(
          //   title: Text(documentPaths[index].split("/").last, style: TextStyle(color: Colors.amber),),
          // );
        },
      ):const Center(child: CircularProgressIndicator()),
    );
  }


  TextEditingController controller = TextEditingController();
  ///Dialog Boxes
  void _showRenameDialog(BuildContext context, path) {
    String newFileName = path.toString().split('/').last;
    controller.text = path.toString().split('/').last;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text("Rename"),
          content: SizedBox(
            height: 45,
            child: TextFormField(
              controller: controller,
              onChanged: (value) {
                newFileName = value;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                focusColor: Colors.transparent,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2.0,
                  ),
                ),
                hintText: "Enter new file name",
                border:  OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(25.0),
                  borderSide:  BorderSide(),
                ),
                fillColor: Color(0xff232323),
                filled: true,
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CButton(
                  fontSize: 14,
                  color: Color(0xff232323),
                  width: 80,
                  onPress: (){
                    Navigator.pop(context);
                  },
                  text: "Cancel",
                ),
                CButton(
                  fontSize: 14,
                  color: Color(0xffEA3434),
                  width: 80,
                  onPress: (){
                    renameFile(path, newFileName);
                  },
                  text: "Done",
                ),
              ],
            )
          ],
        );
      },
    );
  }
  void _showInformationDialog(BuildContext context,String path,String size,String date) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text("Info"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Name:",style: TextStyle(color: Color(0xff4D4D4D),fontSize: 14),),
              Text(path.split("/").last,style: TextStyle(color: Colors.white,fontSize: 14),),
              const SizedBox(height: 5,),
              const Text("Size:",style: TextStyle(color: Color(0xff4D4D4D),fontSize: 14),),
              Text(size,style: TextStyle(color: Colors.white,fontSize: 14),),
              const SizedBox(height: 5,),
              const Text("Path:",style: TextStyle(color: Color(0xff4D4D4D),fontSize: 14),),
              Text(path,style: TextStyle(color: Colors.white,fontSize: 14),),
              const SizedBox(height: 5,),
              const Text("Last Modified:",style: TextStyle(color: Color(0xff4D4D4D),fontSize: 14),),
              Text(date,style: TextStyle(color: Colors.white,fontSize: 14),),
            ],
          ),
          actions: [
            CButton(
              fontSize: 14,
              color: Color(0xffEA3434),
              onPress: (){
                Navigator.pop(context);
              },
              text: "Done",
            )
          ],
        );
      },
    );
  }
  void _showDeleteDialog(BuildContext context, path,int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          contentPadding: EdgeInsets.symmetric(vertical: 18,horizontal: 16),
          content: Text("Are you sure you want to delete?",style: TextStyle(color: Colors.white),),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CButton(
                  fontSize: 14,
                  color: Color(0xff232323),
                  width: 80,
                  onPress: (){
                    Navigator.pop(context);
                  },
                  text: "Cancel",
                ),
                CButton(
                  fontSize: 14,
                  color: Color(0xffEA3434),
                  width: 80,
                  onPress: (){
                    deleteFile(path,index);
                  },
                  text: "Delete",
                ),
              ],
            )
          ],
        );
      },
    );
  }
  ///Functions
  Future<void> renameFile(String oldPath, String newName) async {
    try {
      File oldFile = File(oldPath);
      String newPath = oldPath.replaceAll(RegExp('${oldFile.path.split('/').last}\$'), newName);
      print("newPath");
      print(newPath);

      if (await oldFile.exists()) {
        await oldFile.rename(newPath);
        Navigator.pop(context);
        Get.snackbar(
          "Success!",
          "File renamed successfully.",
        );
        print('File renamed successfully.');
      } else {
        Get.snackbar(
          "Failed!",
          "File not found.",
        );
        print('File not found.');
      }
    } catch (e) {
      print('Error renaming file: $e');
    }
  }
  Future<void> deleteFile(String filePath,int index) async {
    try {
      File file = File(filePath);

      if (await file.exists()) {
        await file.delete();
        setState(() {
          documentList.removeAt(index);
        });
        Navigator.pop(context);
        Get.snackbar(
          "Success!",
          "File deleted successfully.",
        );
        print('File deleted successfully.');
      } else {
        Get.snackbar(
          "Failed!",
          "File not found.",
        );
        print('File not found.');
      }
    } catch (e) {
      print('Error deleting file: $e');
    }
  }
  String _formatFileSize(double bytes) {
    const int KB = 1024;
    const int MB = KB * KB;
    const int GB = MB * KB;

    if (bytes >= GB) {
      return '${(bytes / GB).toStringAsFixed(2)} GB';
    } else if (bytes >= MB) {
      return '${(bytes / MB).toStringAsFixed(2)} MB';
    } else if (bytes >= KB) {
      return '${(bytes / KB).toStringAsFixed(2)} KB';
    } else {
      return '$bytes bytes';
    }
  }
}

