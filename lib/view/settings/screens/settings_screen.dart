import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import '../../../core/constant/color.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white38,

      appBar: AppBar(
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: AppColor.appgreen,
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            SettingsGroup(title: 'Main Settings',
                children: <Widget>[
              const SizedBox(
                height: 8,
              ),
              // DarkMode(),
              buildLogout(),
             buildDeleteAccount()
            ]),
            const SizedBox(
              height: 12,
            ),
            SettingsGroup(title: 'Feedback', children: <Widget>[
              const SizedBox(
                height: 8,
              ),
              buildSendFeedback(context),
              buildPrivacy(context),
            ])
          ],
        ),
      ),
    );
  }

  Widget buildLogout() => SimpleSettingsTile(
      title: 'logout',
      subtitle: '',
      leading: Icon(
        Icons.logout,
        color: Colors.blueAccent,
      ),
      onTap: () async {

      });



  Widget buildDeleteAccount() => SimpleSettingsTile(
      title: 'delete account',
      subtitle: '',
      leading: Icon(
        Icons.delete,
        color: Colors.pink,
      ),
      onTap: () async {

       });
  Widget buildSendFeedback(BuildContext context) => SimpleSettingsTile(
      title:'sendFeed',
      subtitle: '',
      leading: Icon(
        Icons.thumb_up,
        color: Colors.purple,
      ),
      onTap: () {

      });
  Widget buildPrivacy(BuildContext context) =>SimpleSettingsTile(
    title: 'privcypolicy',
    leading: Icon(
      Icons.lock,
      color: Colors.blue,
    ),
    onTap: () {

    },
  );
}
