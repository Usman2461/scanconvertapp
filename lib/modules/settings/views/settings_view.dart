import 'package:converter/modules/settings/views/privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/data/local/my_shared_pref.dart';
import '../../../config/theme/my_theme.dart';
import '../../../config/translations/localization_service.dart';
import '../../../config/translations/strings_enum.dart';
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
        appBar: AppBar(
          title: Text(Strings.settings.tr),
          actions: [
            IconButton(
              //if 0 then display icon list if other than zero display icon grid
              icon: const Image(
                image: AssetImage("assets/icons/search_icon.png"),
                width: 20,
                height: 20,
              ),
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
                leading: SvgPicture.asset(
                  Constants.shareIcon,
                  height: 22,
                  width: 20,
                ),
                title:  Text(Strings.shareApp.tr),
                onTap: () {
                  _Share();
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  Constants.fileManagerIcon,
                  height: 20,
                  width: 20,
                ),
                title:  Text(Strings.fileManager.tr),
                onTap: () {},
              ),
              ListTile(
                leading: SvgPicture.asset(
                  Constants.settingsIcon2,
                  height: 22,
                  width: 20,
                ),
                title:  Text(Strings.keepScreenOn.tr),
                onTap: () {},
              ),
              MyLanguageDropdownButton(),
              MyThemeDropdownButton(),
              ListTile(
                leading: SvgPicture.asset(
                  Constants.feedbackIcon2,
                  height: 20,
                  width: 20,
                ),
                title: Text(Strings.feedback.tr),
                onTap: () {
                  _openMap();
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  Constants.policyIcon,
                  height: 20,
                  width: 20,
                ),
                title: Text(Strings.privacyPolicy.tr),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  Constants.versionIcon,
                  height: 22,
                  width: 20,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Strings.version.tr),
                    Container(
                      // height: 22,
                      // width: 60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ), //BorderRadius.all
                      ),
                      child: Center(
                          child: Text(
                        "V 11.7",
                        style:
                            TextStyle(color: Color(0xff9F9F9F), fontSize: 10),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  _Share() async {
    FlutterShare.share(
        title: 'Share',
        linkUrl: "https://play.google.com/store/apps/details?id=" +
            "com.qutech.kidslab");
  }

  _openMap() async {
    const url =
        "https://play.google.com/store/apps/details?id=" + "com.qutech.kidslab";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}

//Theme drop down button
class MyThemeDropdownButton extends StatelessWidget {
  String dropDownValue =
      MySharedPref.getThemeIsLight() ? "Light" : "Default (Dark)";

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        // Handle the selected item here
        print("Selected: $value");
        if (value != dropDownValue) {
          dropDownValue = value;
          MyTheme.changeTheme();
          //MySharedPref.setThemeIsLight(value == "Light" ? true : false);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Default (Dark)',
          child: Text('Default (Dark)'),
        ),
        PopupMenuItem<String>(
          value: 'Light',
          child: Text('Light'),
        ),
      ],
      child: ListTile(
        leading: SvgPicture.asset(Constants.themeIcon2, height: 20, width: 20),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Strings.appTheme.tr),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  "$dropDownValue",
                  style: TextStyle(color: Color(0xff9F9F9F), fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
      offset: Offset(40, 0),
    );
  }
}

//Language drop down button
class MyLanguageDropdownButton extends StatelessWidget {
  Locale currentLanguage = MySharedPref.getCurrentLocal();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        // Handle the selected item here
        if (currentLanguage.languageCode != value) {
          currentLanguage = Locale(value, value == "en" ? "US" : "AR");
          LocalizationService.updateLanguage(value);
          print("Selected: $value");
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'en',
          child: Text('English'),
        ),
        PopupMenuItem<String>(
          value: 'ar',
          child: Text('Arabic'),
        ),
      ],
      offset: Offset(40, 0),
      child: ListTile(
        leading: SvgPicture.asset(
          Constants.languageIcon,
          height: 22,
          width: 20,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Strings.languageOptions.tr),
            Container(
              // height: 22,
              // width: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ), //BorderRadius.all
              ),
              child: Center(
                  child: Text(
                currentLanguage.languageCode == "en" ? "English" : "Arabic",
                style: TextStyle(color: Color(0xff9F9F9F), fontSize: 10),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
