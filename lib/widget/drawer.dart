import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:time_status/core/app_export.dart';
import 'package:time_status/widget/draweitem.dart';
import '../view/settings/screens/settings_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.appbargreen,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            headerWidget(),
            Divider(color: Colors.white),
            buildListTile(Icons.home, "Home", () {}),
            buildListTile(Icons.favorite, "Favorites", () {}),
            buildListTile(Icons.person, "Profile", () {}),
            buildListTile(Icons.search, "Search User", () {}),
            buildListTile(Icons.logout, "Logout", () {}),
            Divider(color: Colors.white),
            buildListTile(Icons.settings, "Settings", () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingScreen()));
            }),
            buildListTile(Icons.add, "Add", () {}),
            buildListTile(Icons.share, "Share", () {}),
            buildListTile(Icons.person_add, "Follow Us", () {}),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(IconData icon, String title, Function() onPressed) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: onPressed,
    );
  }

  Widget headerWidget() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/img_rectangle163_2.png'),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Name",
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
            fontFamily: "Signatra",
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
