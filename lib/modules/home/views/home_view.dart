
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:io';

import 'package:converter/modules/home/controllers/home_controller.dart';
import 'package:converter/modules/home/views/show_files_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:storage_info/storage_info.dart';

import '../../../app/data/local/my_shared_pref.dart';
import '../../../config/theme/my_theme.dart';
import '../../../utils/constants.dart';
import '../../../widgets/inkwell.dart';
import '../../base/models/document_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

 var status=1;

  List data = [
    {
      "title": "All Files",
      "desc": "130",
      "image": Constants.allFilesIcon
    },
    {
      "title": "PDF",
      "desc": "11",
      "image": Constants.pdfIcon
    },
    {
      "title": "Word",
      "desc": "244",
      "image": Constants.wordIcon
    },
    {
      "title": "Excel",
      "desc": "234",
      "image": Constants.excelIcon
    },
    {
      "title": "PowerPoint",
      "desc": "12",
      "image": Constants.pptIcon
    },   {
      "title": "Text",
      "desc": "0",
      "image": Constants.txtIcon
    },
    {
      "title": "Directories",
      "desc": "43",
      "image": Constants.directoryIcon
    },
    {
      "title": "Favourite",
      "desc": "21",
      "image": Constants.favouriteIcon
    },
    {
      "title": "FeedBack",

      "image": Constants.feedbackIcon
    },


  ];
  StreamController<bool> listController  = StreamController.broadcast();
 double deviceAvailableSize = 0;
 double deviceTotalSize = 0;
 Future<void> getSpace() async {
   deviceAvailableSize = await StorageInfo.getStorageFreeSpaceInGB;
   deviceTotalSize = await StorageInfo.getStorageTotalSpaceInGB + 10;
   setState(() {});
 }
 var isLightTheme = MySharedPref.getThemeIsLight();
 onChangeThemePressed() {
   MyTheme.changeTheme();
   isLightTheme = MySharedPref.getThemeIsLight();
   setState(() {});
 }
  @override
  void initState(){
    fetchDocuments();
    getSpace();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double loadingPercentage =  documentAllInfos.isEmpty ? 0.5 : 1.0;
    // final provider = Provider.of<FilesController>(context, listen: false);
    return StreamBuilder<bool>(
        stream: listController.stream,
      builder: (context, snapshot) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff181818),
              title: Text("File Reader"),
              actions: [
                IconButton(
                  color: Colors.white,
                  //if 0 then display icon list if other than zero display icon grid
                  icon: status == 1 ? Icon(Icons.list) : Icon(Icons.grid_view),
                  tooltip: 'Open shopping cart',
                  onPressed: () {
                    //required to add state,
                    //setstate is used to change the state,
                    //when the status variable is changed, the whole page will be re-rendered automatically
                      if (status == 0) {
                        status = 1;
                        listController.sink.add(true);
                      } else {
                        status = 0;
                        listController.sink.add(true);
                      }
                  },
                ),
                IconButton(
                  //if 0 then display icon list if other than zero display icon grid
                  icon:  Icon(Icons.search) ,
                  onPressed: () {
                    onChangeThemePressed();
                  },
                ),
              ],
            ),
            // if status 0 then show lisview if status other than 0 show grid view
            body: LoadingOverlay(
                  percentage: loadingPercentage,
                  isLoading:  documentAllInfos,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          status == 0
                              ? Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return GradientInkWell(
                                  onTap: (){
                                    if(index==0){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
                                        title: "ALL Files",
                                        documentList:  documentAllInfos,
                                      )));
                                    }
                                    else if(index==1){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
                                        title: "PDF Files",
                                        documentList:  documentPdfInfos,
                                      )));
                                    }
                                    else if(index==2){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
                                        title: "Word Files",
                                        documentList:  documentWordInfos,
                                      )));
                                    }
                                    else if(index==3){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
                                        title: "Excel Files",
                                        documentList:  documentExcelInfos,
                                      )));
                                    }
                                    else if(index==4){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
                                        title: "Power Point Files",
                                        documentList:  documentPPTInfos,
                                      )));
                                    }
                                    else if(index==4){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
                                        title: "Text Files",
                                        documentList:  documentTEXTInfos,
                                      )));
                                    }
                                    else{
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
                                        documentList:  documentTEXTInfos,
                                      )));
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Colors.white30),
                                      ),
                                    ),
                                    child: ListTile(
                                        textColor: Colors.white,
                                        leading: SvgPicture.asset(data[index]['image'],height: 40,width: 40,),
                                        title: Text(data[index]['title'],style: TextStyle(fontSize: 14),),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                             documentAllInfos.isEmpty?SizedBox():
                                             Container(
                                              height: 22,
                                              width: 60,
                                              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ), //BorderRadius.all
                                              ),
                                              child: Center(child: Text((() {
                                                if(index==0){
                                                  return  "${ documentAllInfos.length} files";
                                                }
                                                else if(index==1){
                                                  return  "${ documentPdfInfos.length} files";
                                                }
                                                else if(index==2){
                                                  return  "${ documentWordInfos.length} files";
                                                }
                                                else if(index==3){
                                                  return  "${ documentExcelInfos.length} files";
                                                }
                                                else if(index==4){
                                                  return  "${ documentPPTInfos.length} files";
                                                }
                                                else if(index==4){
                                                  return  "${ documentTEXTInfos.length} files";
                                                }
                                                else{
                                                  return "${ documentAllInfos.length} files";
                                                }
                                              }())
                                                ,style: TextStyle(fontSize: 10),)),
                                            ),
                                            SizedBox(width: 40,),
                                            Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,),
                                          ],)
                                    ),
                                  ),
                                );
                              },
                              itemCount: data.length,
                            ),
                          )
                              : Expanded(
                              child:  GridView.count(
                                crossAxisCount: 3,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 8.0,
                                children: List.generate(data.length, (index) {
                                  return GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      if(index==0){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
                                          title: "ALL Files",
                                          documentList:  documentAllInfos,
                                        )));
                                      }
                                      else if(index==1){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
                                          title: "PDF Files",
                                          documentList:  documentPdfInfos,
                                        )));
                                      }
                                      else if(index==2){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
                                          title: "Word Files",
                                          documentList:  documentWordInfos,
                                        )));
                                      }
                                      else if(index==3){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
                                          title: "Excel Files",
                                          documentList:  documentExcelInfos,
                                        )));
                                      }
                                      else if(index==4){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
                                          title: "Power Point Files",
                                          documentList:  documentPPTInfos,
                                        )));
                                      }
                                      else if(index==4){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
                                          title: "Text Files",
                                          documentList:  documentTEXTInfos,
                                        )));
                                      }
                                      else{
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
                                          documentList:  documentTEXTInfos,
                                        )));
                                      }
                                    },
                                    child: SizedBox(
                                      height: 50,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 40,
                                            width: 50,
                                            child: SvgPicture.asset(data[index]["image"]),
                                          ),
                                          Center(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(2),
                                                ), //BorderRadius.all
                                              ),
                                              child: Text(data[index]['desc']==null? "0 Files": (() {
                                                if(index==0){
                                                  return  "${ documentAllInfos.length} files";
                                                }
                                                else if(index==1){
                                                  return  "${ documentPdfInfos.length} files";
                                                }
                                                else if(index==2){
                                                  return  "${ documentWordInfos.length} files";
                                                }
                                                else if(index==3){
                                                  return  "${ documentExcelInfos.length} files";
                                                }
                                                else if(index==4){
                                                  return  "${ documentPPTInfos.length} files";
                                                }
                                                else if(index==5){
                                                  return  "${ documentTEXTInfos.length} files";
                                                }
                                                else{
                                                  return "${ documentAllInfos.length} files";
                                                }
                                              }()),style: TextStyle(color: Colors.white,fontSize: 8),),
                                            ),
                                          ),
                                          Text(data[index]['title'],style: TextStyle(fontSize: 14),),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                )  ,)
                          ),


                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      WidgetSpan(child: SvgPicture.asset("assets/icons/storage.svg",height: 25,width: 25,)),
                                      WidgetSpan(child: SizedBox(width: 5,)),
                                      TextSpan(text: 'Storage',style: TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ),
                                Row(children: [
                                  SizedBox(height:40,child: PieChart(

                                    dataMap:  <String, double>{
                                      "totalStorage": deviceTotalSize,
                                      "total": deviceAvailableSize,

                                    },
                                    centerText: null,

                                    legendOptions: LegendOptions(
                                      showLegendsInRow: false,

                                      showLegends: false,


                                    ),
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValueBackground: false,
                                      showChartValues: false,
                                      showChartValuesInPercentage: false,
                                      showChartValuesOutside: false,
                                    ),
                                  )
                                  ),
                                  Text("${deviceAvailableSize}.GB",style: TextStyle(fontSize: 16),)


                                ],)

                              ],
                            ),
                          ),

                        ],),
                    ),
                  ),
                )
        );
      }
    );
  }
 bool permissionGranted=false;
 List<DocumentInfo> documentAllInfos = [];
 List<DocumentInfo> documentPdfInfos = [];
 List<DocumentInfo> documentWordInfos = [];
 List<DocumentInfo> documentExcelInfos = [];
 List<DocumentInfo> documentPPTInfos = [];
 List<DocumentInfo> documentTEXTInfos = [];
 Future<void> fetchDocuments() async {
   var status = await Permission.manageExternalStorage.request();

   if (true) {
     Directory? externalStorageDir = Directory('/storage/emulated/0');

     if (await _hasPermission(externalStorageDir)) {
       await _searchForDocuments(externalStorageDir);
       setState(() {});
     } else {
       print("NOTHING");
     }
   } else {
     print("Handle permission not granted");
   }
 }
 Future<double> getFileMBSize(File file) async {
   int fileSizeBytes = await file.length();
   return fileSizeBytes.toDouble();
 }
 Future<bool> _hasPermission(Directory dir) async {
   try {
     await dir.list().toList();
     return true;
   } catch (e) {
     return false;
   }
 }
 Future<void> _searchForDocuments(Directory dir) async {
   List<FileSystemEntity> entities = await dir.list().toList();

   for (var entity in entities) {
     if (entity is Directory) {
       if (await _hasPermission(entity)) {
         await _searchForDocuments(entity);
       }
     }
     else if (entity is File) {
       if (entity.path.endsWith('.pdf') || entity.path.endsWith('.doc') || entity.path.endsWith('.docx')
           ||entity.path.endsWith('.xlsx') ||entity.path.endsWith('.ppt')||entity.path.endsWith('.pptx')
           || entity.path.endsWith('.txt')
       ){
         DateTime lastModified = await entity.lastModified();
         double fileSizeMB = await getFileMBSize(entity);
         // documentPaths.add(entity.path);
         documentAllInfos.add(DocumentInfo(entity.path, lastModified, fileSizeMB));
         listController.sink.add(true);
       }
       if (entity.path.endsWith('.pdf')) {
         DateTime lastModified = await entity.lastModified();
         double fileSizeMB = await getFileMBSize(entity);
         // documentPaths.add(entity.path);
         documentPdfInfos.add(DocumentInfo(entity.path, lastModified, fileSizeMB));
         listController.sink.add(true);
       }
       else if(entity.path.endsWith('.doc') || entity.path.endsWith('.docx')){
         DateTime lastModified = await entity.lastModified();
         double fileSizeMB = await getFileMBSize(entity);
         // documentPaths.add(entity.path);
         documentWordInfos.add(DocumentInfo(entity.path, lastModified, fileSizeMB));
         listController.sink.add(true);
       }
       else if(entity.path.endsWith('.xlsx')){
         DateTime lastModified = await entity.lastModified();
         double fileSizeMB = await getFileMBSize(entity);
         // documentPaths.add(entity.path);
         documentExcelInfos.add(DocumentInfo(entity.path, lastModified, fileSizeMB));
         listController.sink.add(true);
       }
       else if(entity.path.endsWith('.ppt')||entity.path.endsWith('.pptx')){
         DateTime lastModified = await entity.lastModified();
         double fileSizeMB = await getFileMBSize(entity);
         // documentPaths.add(entity.path);
         documentPPTInfos.add(DocumentInfo(entity.path, lastModified, fileSizeMB));
         listController.sink.add(true);

       }
       else if(entity.path.endsWith('.txt')){
         DateTime lastModified = await entity.lastModified();
         double fileSizeMB = await getFileMBSize(entity);
         // documentPaths.add(entity.path);
         documentTEXTInfos.add(DocumentInfo(entity.path, lastModified, fileSizeMB));
         listController.sink.add(true);
       }
     }
   }
 }
 bool _isDocumentFile(String filePath) {
   // Implement logic to determine if a file is a document based on its extension or content
   // For example, you could check for common document extensions like .pdf, .doc, .docx, etc.
   return filePath.toLowerCase().endsWith('.pdf');
   // ||
   // filePath.toLowerCase().endsWith('.doc') ||
   // filePath.toLowerCase().endsWith('.docx');
 }
 String formatFileSize(double bytes) {
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
// class HomeView extends GetView<HomeController> {
//   HomeView({Key? key}) : super(key: key);
//   List data = [
//     {
//       "title": "All Files",
//       "desc": "130",
//       "image": "assets/icons/all_files.svg"
//     },
//     {
//       "title": "PDF",
//       "desc": "11",
//       "image": "assets/icons/pdf.svg"
//     },
//     {
//       "title": "Word",
//       "desc": "244",
//       "image": "assets/icons/word.svg"
//     },
//     {
//       "title": "Excel",
//       "desc": "234",
//       "image": "assets/icons/excel.svg"
//     },
//     {
//       "title": "PowerPoint",
//       "desc": "12",
//       "image": "assets/icons/ppt.svg"
//     },   {
//       "title": "Text",
//       "desc": "0",
//       "image": "assets/icons/text.svg"
//     },
//     {
//       "title": "Directories",
//       "desc": "43",
//       "image": "assets/icons/direct.svg"
//     },
//     {
//       "title": "Favourite",
//       "desc": "21",
//       "image": "assets/icons/fvrt.svg"
//     },
//     {
//       "title": "FeedBack",
//
//       "image": "assets/icons/feedback.svg"
//     },
//
//
//   ];
//   double loadingPercentage=0.0;
//   @override
//   Widget build(BuildContext context) {
//     var theme = context.theme;
//     loadingPercentage = Get.find<BaseController>().documentAllInfos.isEmpty?0.5:1.0;
//     return GetBuilder<HomeController>(
//       builder: (_) => Scaffold(
//           backgroundColor: Color(0xff232323),
//           appBar: AppBar(
//             backgroundColor: Color(0xff181818),
//             title: Text("File Reader"),
//             actions: [
//               IconButton(
//                 color: Colors.white,
//                 //if 0 then display icon list if other than zero display icon grid
//                 icon: _.status == 1 ? Icon(Icons.list) : Icon(Icons.grid_view),
//                 tooltip: 'Open shopping cart',
//                 onPressed: () {
//                   //required to add state,
//                   //setstate is used to change the state,
//                   //when the status variable is changed, the whole page will be re-rendered automatically
//                   if (_.status == 0) {
//                     _.status = 1;
//                     _.update();
//                   } else {
//                     _.status = 0;
//                     _.update();
//                   }
//                 },
//               ),
//               IconButton(
//                 //if 0 then display icon list if other than zero display icon grid
//                 icon:  Icon(Icons.search) ,
//                 onPressed: () {
//                   Get.find<HomeController>().onChangeThemePressed();
//                 },
//               ),
//             ],
//           ),
//           // if status 0 then show lisview if status other than 0 show grid view
//           body: LoadingOverlay(
//             percentage: loadingPercentage,
//             isLoading: Get.find<BaseController>().documentAllInfos,
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _.status == 0
//                         ? Expanded(
//                       child: ListView.builder(
//                         scrollDirection: Axis.vertical,
//                         itemBuilder: (context, index) {
//                           return GradientInkWell(
//                             onTap: (){
//                               if(index==0){
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
//                                   documentList: Get.find<BaseController>().documentAllInfos,
//                                 )));
//                               }
//                               else if(index==1){
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
//                                   documentList: Get.find<BaseController>().documentPdfInfos,
//                                 )));
//                               }
//                               else if(index==2){
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
//                                   documentList: Get.find<BaseController>().documentWordInfos,
//                                 )));
//                               }
//                               else if(index==3){
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
//                                   documentList: Get.find<BaseController>().documentExcelInfos,
//                                 )));
//                               }
//                               else if(index==4){
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
//                                   documentList: Get.find<BaseController>().documentPPTInfos,
//                                 )));
//                               }
//                               else if(index==4){
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
//                                   documentList: Get.find<BaseController>().documentTEXTInfos,
//                                 )));
//                               }
//                               else{
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
//                                   documentList: Get.find<BaseController>().documentTEXTInfos,
//                                 )));
//                               }
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border(
//                                   bottom: BorderSide(
//                                       width: 1,
//                                       color: Colors.white30),
//                                 ),
//                               ),
//                               child: ListTile(
//
//                                   textColor: Colors.white,
//                                   leading: SvgPicture.asset(data[index]['image'],height: 40,width: 40,),
//                                   title: Text(data[index]['title'],style: TextStyle(fontSize: 14),),
//                                   trailing: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Get.find<BaseController>().documentAllInfos.isEmpty?SizedBox():
//                                       Container(
//                                         height: 22,
//                                         width: 60,
//                                         padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
//                                         decoration: BoxDecoration(
//                                           color: Colors.black,
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10),
//                                           ), //BorderRadius.all
//                                         ),
//                                         child: Center(child: Text((() {
//                                           if(index==0){
//                                             return  "${Get.find<BaseController>().documentAllInfos.length} files";
//                                           }
//                                           else if(index==1){
//                                             return  "${Get.find<BaseController>().documentPdfInfos.length} files";
//                                           }
//                                           else if(index==2){
//                                             return  "${Get.find<BaseController>().documentWordInfos.length} files";
//                                           }
//                                           else if(index==3){
//                                             return  "${Get.find<BaseController>().documentExcelInfos.length} files";
//                                           }
//                                           else if(index==4){
//                                             return  "${Get.find<BaseController>().documentPPTInfos.length} files";
//                                           }
//                                           else if(index==4){
//                                             return  "${Get.find<BaseController>().documentTEXTInfos.length} files";
//                                           }
//                                           else{
//                                             return "${Get.find<BaseController>().documentAllInfos.length} files";
//                                           }
//                                         }())
//                                           ,style: TextStyle(color: Colors.white,fontSize: 10),)),
//                                       ),
//                                       SizedBox(width: 40,),
//                                       Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,),
//                                     ],)
//                               ),
//                             ),
//                           );
//                         },
//                         itemCount: data.length,
//                       ),
//                     )
//                         : Expanded(
//                         child:  GridView.count(
//                           crossAxisCount: 3,
//                           crossAxisSpacing: 4.0,
//                           mainAxisSpacing: 8.0,
//                           children: List.generate(data.length, (index) {
//                             return GestureDetector(
//                               behavior: HitTestBehavior.opaque,
//                               onTap: (){
//                                 if(index==0){
//                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
//                                     documentList: Get.find<BaseController>().documentAllInfos,
//                                   )));
//                                 }
//                                 else if(index==1){
//                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
//                                     documentList: Get.find<BaseController>().documentPdfInfos,
//                                   )));
//                                 }
//                                 else if(index==2){
//                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
//                                     documentList: Get.find<BaseController>().documentWordInfos,
//                                   )));
//                                 }
//                                 else if(index==3){
//                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
//                                     documentList: Get.find<BaseController>().documentExcelInfos,
//                                   )));
//                                 }
//                                 else if(index==4){
//                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
//                                     documentList: Get.find<BaseController>().documentPPTInfos,
//                                   )));
//                                 }
//                                 else if(index==4){
//                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
//                                     documentList: Get.find<BaseController>().documentTEXTInfos,
//                                   )));
//                                 }
//                                 else{
//                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>showAllFiles(
//                                     documentList: Get.find<BaseController>().documentTEXTInfos,
//                                   )));
//                                 }
//                               },
//                               child: SizedBox(
//                                 height: 50,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     SizedBox(
//                                       height: 40,
//                                       width: 50,
//                                       child: SvgPicture.asset(data[index]["image"]),
//                                     ),
//                                     Center(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(horizontal: 3,vertical: 2),
//                                         decoration: BoxDecoration(
//                                           color: Colors.black,
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(2),
//                                           ), //BorderRadius.all
//                                         ),
//                                         child: Text(data[index]['desc']==null? "0 Files": (() {
//                                           if(index==0){
//                                             return  "${Get.find<BaseController>().documentAllInfos.length} files";
//                                           }
//                                           else if(index==1){
//                                             return  "${Get.find<BaseController>().documentPdfInfos.length} files";
//                                           }
//                                           else if(index==2){
//                                             return  "${Get.find<BaseController>().documentWordInfos.length} files";
//                                           }
//                                           else if(index==3){
//                                             return  "${Get.find<BaseController>().documentExcelInfos.length} files";
//                                           }
//                                           else if(index==4){
//                                             return  "${Get.find<BaseController>().documentPPTInfos.length} files";
//                                           }
//                                           else if(index==5){
//                                             return  "${Get.find<BaseController>().documentTEXTInfos.length} files";
//                                           }
//                                           else{
//                                             return "${Get.find<BaseController>().documentAllInfos.length} files";
//                                           }
//                                         }()),style: TextStyle(color: Colors.white,fontSize: 8),),
//                                       ),
//                                     ),
//                                     Text(data[index]['title'],style: TextStyle(fontSize: 14,color: Colors.white),),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }
//                           )  ,)
//                     ),
//
//
//                     Padding(
//                       padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text.rich(
//                             TextSpan(
//                               children: <InlineSpan>[
//                                 WidgetSpan(child: SvgPicture.asset("assets/icons/storage.svg",height: 25,width: 25,)),
//                                 WidgetSpan(child: SizedBox(width: 5,)),
//                                 TextSpan(text: 'Storage',style: TextStyle(color: Colors.white,fontSize: 16),),
//                               ],
//                             ),
//                           ),
//                           Row(children: [
//                             SizedBox(height:40,child: PieChart(
//
//                               dataMap:  <String, double>{
//                                 "totalStorage": Get.find<HomeController>().deviceTotalSize,
//                                 "total": Get.find<HomeController>().deviceAvailableSize,
//
//                               },
//                               centerText: null,
//
//                               legendOptions: LegendOptions(
//                                 showLegendsInRow: false,
//
//                                 showLegends: false,
//
//
//                               ),
//                               chartValuesOptions: ChartValuesOptions(
//                                 showChartValueBackground: false,
//                                 showChartValues: false,
//                                 showChartValuesInPercentage: false,
//                                 showChartValuesOutside: false,
//                               ),
//                             )
//                             ),
//                             Text("${Get.find<HomeController>().deviceAvailableSize}.GB",style: TextStyle(color: Colors.white,fontSize: 16),)
//
//
//                           ],)
//
//                         ],
//                       ),
//                     ),
//
//                   ],),
//               ),
//             ),
//           )
//
//
//
//       ),
//     );
//   }
//
// }




class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final List<DocumentInfo> isLoading;
  final double percentage;

  LoadingOverlay({required this.child, required this.isLoading,required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        child,
        if (isLoading.isEmpty)
          // Container(
          //   color: Color.fromRGBO(0, 0, 0, 0.3), // Semi-transparent background
          //   child: Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // ),
    Container(
      height: 100,
      // width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(value: percentage),
          SizedBox(height: 16),
          Text("Loading: ${(percentage * 100).toStringAsFixed(1)}%"),
        ],
      ),
    )
      ],
    );
  }

}

