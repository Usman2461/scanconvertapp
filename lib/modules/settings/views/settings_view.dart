import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff232323),
        appBar: AppBar(
          backgroundColor: const Color(0xff181818),
          title: const Text("Settings"),
          actions: [
            IconButton(
              //if 0 then display icon list if other than zero display icon grid
              icon: const Icon(Icons.search),
              onPressed: () {
                // onChangeThemePressed();
              },
            ),
          ],
        ),
        // if status 0 then show lisview if status other than 0 show grid view
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListTile(
                leading: SvgPicture.asset(Constants.shareIcon,height: 22,width: 20,),
                title: const Text("Share App"),
              ),
              ListTile(
                leading: SvgPicture.asset(Constants.fileManagerIcon,height: 20,width: 20,),
                title: const Text("File Manager"),
              ),
              ListTile(
                leading: SvgPicture.asset(Constants.settingsIcon2,height: 22,width: 20,),
                title: const Text("Keep Screen On"),
              ),
              ListTile(
                leading: SvgPicture.asset(Constants.languageIcon,height: 22,width: 20,),
                title: Row(
                  children: [
                    const Text("Language Options"),
                    const SizedBox(width: 20,),
                    Container(
                      // height: 22,
                      // width: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ), //BorderRadius.all
                      ),
                      child: const Center(child: Text("English",style: TextStyle(color: Color(0xff9F9F9F),fontSize: 10),)),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(Constants.themeIcon2,height: 20,width: 20,),
                title: Row(
                  children: [
                    const Text("App Theme"),
                    const SizedBox(width: 70,),
                    Container(
                      // height: 22,
                      // width: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ), //BorderRadius.all
                      ),
                      child: const Center(child: Text("Default",style: TextStyle(color: Color(0xff9F9F9F),fontSize: 10),)),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(Constants.feedbackIcon2,height: 20,width: 20,),
                title: const Text("Feedback"),
              ),
              ListTile(
                leading: SvgPicture.asset(Constants.policyIcon,height: 22,width: 20,),
                title: Row(
                  children: [
                    const Text("Version"),
                    const SizedBox(width: 100,),
                    Container(
                      // height: 22,
                      // width: 60,
                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ), //BorderRadius.all
                      ),
                      child: Center(child: Text("V 11.7",style: TextStyle(color: Color(0xff9F9F9F),fontSize: 10),)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}