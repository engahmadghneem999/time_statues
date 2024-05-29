import 'package:flutter/material.dart';
import 'package:time_status/core/app_export.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/main_chat_screen/main_chat_screen.dart';
import 'package:time_status/view/home/screen/home_screen.dart';
import 'package:time_status/view/map/screen/mapscreen.dart';
import 'package:time_status/view/mytasks/screens/team_screen.dart';
import '../view/splash/screen/widgets/custom_text.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    MapScreen(),
    const MainChat(),
    const MyTasks(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: _widgetOptions,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedCrossFade(
            firstChild: const SizedBox(
              height: 0,
              width: 0,
            ),
            secondChild: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: FloatingActionButton(
                    heroTag: "text",
                    onPressed: () {
                      // Handle the first action here
                    },
                    backgroundColor: AppColor.appgreen,
                    elevation: 0,
                    child: const Icon(
                      Icons.format_size,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  heroTag: "image",
                  onPressed: () {
                    // Handle the second action here
                  },
                  backgroundColor: AppColor.appgreen,
                  elevation: 0,
                  child: const Icon(
                    Icons.insert_photo,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: FloatingActionButton(
                    heroTag: "video",
                    onPressed: () {
                      // Handle the third action here
                    },
                    backgroundColor: AppColor.appgreen,
                    elevation: 0,
                    child: const Icon(
                      Icons.videocam,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: FloatingActionButton(
              heroTag: "add_close",
              onPressed: _toggleExpanded,
              backgroundColor:
                  _isExpanded ? AppColor.appgreen : AppColor.appColor,
              elevation: 0,
              child: Icon(
                _isExpanded ? Icons.close : Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: () => _onItemTapped(0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.home,
                          color: _selectedIndex == 0
                              ? AppColor.oranegapp
                              : Colors.black38,
                        ),
                        CustomText(
                          text: 'Home',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: _selectedIndex == 0
                              ? AppColor.oranegapp
                              : AppColor.grayColor,
                        )
                      ],
                    ),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: () => _onItemTapped(1),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.map,
                          color: _selectedIndex == 1
                              ? AppColor.oranegapp
                              : Colors.black38,
                        ),
                        CustomText(
                          text: 'Map',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: _selectedIndex == 1
                              ? AppColor.oranegapp
                              : AppColor.grayColor,
                        )
                      ],
                    ),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: () => _onItemTapped(2),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.chat,
                          color: _selectedIndex == 2
                              ? AppColor.oranegapp
                              : Colors.black38,
                        ),
                        CustomText(
                          text: 'Chat',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: _selectedIndex == 2
                              ? AppColor.oranegapp
                              : AppColor.grayColor,
                        )
                      ],
                    ),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: () => _onItemTapped(3),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Icon(
                          Icons.group,
                          color: _selectedIndex == 3
                              ? AppColor.oranegapp
                              : Colors.black38,
                        ),
                        CustomText(
                          text: 'Task',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: _selectedIndex == 3
                              ? AppColor.oranegapp
                              : AppColor.grayColor,
                        )
                      ],
                    ),
                  ),
                ),
                label: '',
                backgroundColor: Colors.transparent,
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,

            enableFeedback: false,
            selectedItemColor:
                AppColor.oranegapp, // Set the selected item color to orange
          ),
        ),
      ),
    );
  }
}
