import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphic_representation/graphic_representation.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/core/constant/image_assets.dart';
import 'package:time_status/view/home/widgets/slider.dart';
import 'package:time_status/view/profile/screens/profile.dart';
import 'package:time_status/widget/drawer.dart';
import 'package:time_status/widget/loading.dart';
import '../../splash/screen/widgets/custom_text.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  List<int> dayData = [1, 2, 5, 50, 50, 100, 7];
  


  List<String> dayLabels = ["San", "Man", "The", "Win", "Thr", "Fri", "Sat"];

  List<int> weekData = [1, 2, 5, 50, 50, 13, 77];
  List<String> weekLabels = ["Wk1", "Wk2", "Wk3", "Wk4", "Wk5", "Wk6", "Wk7"];

  List<int> monthData = [1, 2, 5, 50, 5, 13, 7];
  List<String> monthLabels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"];

  List<int> yearData = [1, 20, 5, 50, 50, 13, 7];
  List<String> yearLabels = ["2023", "2024", "2025", "2026", "2027", "2028", "2029"];


  String activeButton = 'Day';

  void setActiveButton(String buttonName) {
    setState(() {
      activeButton = buttonName;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<int> data;
    List<String> labels;

    switch (activeButton) {
      case 'Day':
        data = dayData;
        labels = dayLabels;
        break;
      case 'Week':
        data = weekData;
        labels = weekLabels;
        break;
      case 'Month':
        data = monthData;
        labels = monthLabels;
        break;
      case 'Year':
        data = yearData;
        labels = yearLabels;
        break;
      default:
        data = dayData;  labels = dayLabels;
    }

    return Scaffold(
      endDrawer:  const MyDrawer(),
      appBar: AppBar(


          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          backgroundColor: AppColor.appbargreen,
          centerTitle: true,
          title: const Text(
            "alhasan",
            style: TextStyle(fontFamily: "Signatra", fontSize: 20),
          ),
          leading: InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
                // Get.offAllNamed(AppRoute.profile);
              },
              child: Image.asset(AppImageAsset.avatar))),


      body: SingleChildScrollView(
      child: GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
    return LoadingManager(
    isLoading: controller.isLoading,
    child: Column(
        children: [
        const SizedBox(
          height: 2,
        ),
        Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(alignment: Alignment.center, children: [
                Stack(
                  children: [
                    Container(
                      height: 700,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: AppColor.appgreen,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 4),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),

                    //White Container and graph
                    Padding(
                      padding: const EdgeInsets.only(top: 450.0),
                      child: Center(
                        child: Container(
                            height: 350,
                            width: 400,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: AppColor.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  // Shadow color
                                  offset: Offset(0, 4),
                                  // Offset of the shadow
                                  blurRadius: 10,
                                  // Blur radius
                                  spreadRadius: 2, // Spread radius
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const CustomText(
                                    text: 'Focused Time Distribution',
                                    color: AppColor.appgreen),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20.0, left: 2),
                                  child: DiscreteGraphic(
                                    size: Size(
                                        MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height * 0.35),
                                    nums: data,
                                    listGradX: labels,
                                    colorAxes: AppColor.appgreen,
                                    colorLine: AppColor.buttons,
                                    strokeLine: 2.0,
                                    colorPoint: AppColor.oranegapp,
                                    radiusPoint: 3.0,
                                    nbGradY: 9,
                                    minY: 0,
                                    maxY: 100,
                                  ),
                                ),

                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Text('Your Points :',
                            style: TextStyle(
                                color: AppColor.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const Text(' 40 coins',
                            style: TextStyle(
                                color: AppColor.citycolor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      InkWell(
                        onTap:(){},
                        child: Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Set the border radius
                          ),
                          child: SizedBox(
                              height: 100,
                              width: 310,
                              child: SliderL()
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const Text('Your Tasks : 4',
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                      ),

                      const SizedBox(height: 10,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        // Adjust as needed
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // Add a concave effect
                          ),
                          color: AppColor.buttons,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setActiveButton('Day');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: activeButton == 'Day'
                                    ? AppColor
                                        .backgroundbutton // Active button color
                                    : Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Day'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setActiveButton('Week');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: activeButton == 'Week'
                                    ? AppColor
                                        .backgroundbutton // Active button color
                                    : Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Week'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setActiveButton('Month');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: activeButton == 'Month'
                                    ? AppColor
                                        .backgroundbutton // Active button color
                                    : Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Month'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setActiveButton('Year');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: activeButton == 'Year'
                                    ? AppColor
                                        .backgroundbutton // Active button color
                                    : Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Year'),
                            ),
                          ],
                        ),
                      ),


                   const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap:(){},
                            child: Card(
                              color: Colors.blue, // Set the background color of the card
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Set the border radius
                              ),
                              child: SizedBox(
                                  height: 150,
                                  width: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                  const Text('New',style: TextStyle(
                                    color: AppColor.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),),
                                    const SizedBox(height: 10,),
                                    const Text('Tasks: 20 task',style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 12,
                                    ),),
                                    const SizedBox(height: 5,),

                                    const Text('Timer: 2h 30m',style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 12,
                                    ),),
                                    IconButton(onPressed: (){}, icon: const Icon(Icons.create,color:AppColor.black ,))
                                  ],
                                )
                              ),
                            ),
                          ),

                          InkWell(
                            onTap:(){},
                            child: Card(
                              color: AppColor.appColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Set the border radius
                              ),
                              child: SizedBox(
                                height: 150,
                                width: 100,
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Progress',style: TextStyle(
                                        color: AppColor.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),),const SizedBox(height: 10,),
                                    const Text('Tasks: 2 task',style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 12,
                                    ),),
const SizedBox(height: 5,),

                                    const Text('Timer: 1h 29m',style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 12,
                                    ),),
                                    IconButton(onPressed: (){}, icon: const Icon(Icons.downloading_outlined))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap:(){},
                            child: Card(
                              color: Colors.green, // Set the background color of the card
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Set the border radius
                              ),
                              child: SizedBox(
                                height: 150,
                                width: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Done',style: TextStyle(
                                        color: AppColor.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    const SizedBox(height: 10,),
                                    const Text('Tasks: 5 task',style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 12,
                                    ),),

                                    const SizedBox(height: 5,),
                                    const Text('Timer: 3h 16m',style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 12,
                                    ),),
                                    IconButton(onPressed: (){}, icon: const Icon(Icons.check_circle_sharp))

                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 20,),



                    ],
                  ),
                ),
              ])),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Container(
              height: 200,
              width: 400,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 4),
                    // Offset of the shadow
                    blurRadius: 10,
                    spreadRadius: 2,),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 5, bottom: 20),
                    child: Row(
                      children: [
                        const CustomText(
                            text: 'today',
                            color: AppColor.grayColor,
                            fontSize: 15),
                        new LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 70,
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 2000,
                          percent: 0.95,
                          center: const Text("95.0%"),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: AppColor.appgreen,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 5, bottom: 20),
                    child: Row(
                      children: [
                        const CustomText(
                            text: 'Yesterday',
                            color: AppColor.grayColor,
                            fontSize: 15),
                        new LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 100,
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 2000,
                          percent: 0.9,
                          center: const Text("90.0%"),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: AppColor.appgreen,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 5),
                    child: Row(
                      children: [
                        const CustomText(
                            text: 'Before Yesterday',
                            color: AppColor.grayColor,
                            fontSize: 15),
                        new LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 150,
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 2000,
                          percent: 0.5,
                          center: const Text("50.0%"),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: AppColor.appgreen,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ]));
    } )),
     // bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
