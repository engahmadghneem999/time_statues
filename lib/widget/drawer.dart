import 'package:flutter/material.dart';
import 'package:time_status/view/favorites/screens/favorites_screen.dart';
import 'package:time_status/widget/draweitem.dart';

import '../view/settings/screens/settings_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: Colors.black54,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 80, 24, 0),
          child: Column(
            children: [
              headerWiget(),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: DrawerItem(
                  name: 'Home',
                  icon: Icons.home,
                  onPressd: () => onItemPressed(context, index: 0),
                ),
              ),
              const Divider(
                height: 2,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 2.0),
                child: DrawerItem(
                  name: 'Favorites',
                  icon: Icons.star_border_sharp,
                  onPressd: () => onItemPressed(context, index: 1),
                ),
              ),
              const Divider(
                height: 2,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 2),
                child: DrawerItem(
                    name:'Profile',
                    icon: Icons.person_rounded,
                    onPressd: () => onItemPressed(context, index: 2)),
              ),
              const Divider(
                height: 2,
                color: Colors.white60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 2),
                child: DrawerItem(
                    name: 'Search user',
                    icon: Icons.baby_changing_station,
                    onPressd: () => onItemPressed(context, index: 3)),
              ),
              const Divider(height: 2, color: Colors.white60),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 2),
                child: DrawerItem(
                    name: 'Add',
                    icon: Icons.compare,
                    onPressd: () => onItemPressed(context, index: 4)),
              ),
              const Divider(height: 2, color: Colors.white60),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 2),
                child: DrawerItem(
                    name: 'settings',
                    icon: Icons.photo,
                    onPressd: () => onItemPressed(context, index: 5)),
              ),
              const Divider(height: 2, color: Colors.white60),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 2),
                child: DrawerItem(
                    name: 'ShareApp',
                    icon: Icons.share,
                    onPressd: () => onItemPressed(context, index: 6)),
              ),
              const Divider(height: 2, color: Colors.white60),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: DrawerItem(
                    name: 'FollowUs',
                    icon: Icons.request_page,
                    onPressd: () => onItemPressed(context, index: 7)),
              ),
              const Divider(height: 2, color: Colors.white60),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
    switch (index) {
      case 0:

        break;
      case 1:

        break;

      case 2:

        break;
      case 3:

        break;
      case 4:

        break;
      case 5:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SettingScreen()));
        break;
      case 6:
      //todo share link app
        //Share.share('www.google.com');
        break;
      case 7:
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) => Favorites()));
        break;
      default:
        Navigator.pop(context);
        break;
    }
  }

  Widget headerWiget() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/img_rectangle163_2.png',
                  ))),
        ),
        SizedBox(
          height: 20,
        ),
        const Text(
          "name",
          style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
              fontFamily: "Signatra"),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
