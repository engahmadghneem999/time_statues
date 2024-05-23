import 'dart:convert';

import 'package:get/get.dart';
import 'package:time_status/core/service/link.dart';
import 'package:time_status/data/model/graph_model.dart';

import '../../../core/constant/shared_preferences_keys.dart';
import 'package:http/http.dart' as http;

import '../../../core/service/service.dart';

class HomeController extends GetxController {
   // List<int> data=[];
   // List<String> labels=[];

  // late List<int> dataApi ;
  //  late List<String> labelsApi ;

   bool isLoading = false;
  GraphModel graphModel = GraphModel(dataPoints: [], labels: []);

  MyServices myServices = Get.find();
  String activeButton = '';


  @override
  void onInit() {
    fetchGraphData();
    // switch (activeButton) {
    //   case 'Day':
    //     data = dataApi;
    //     labels = labelsApi;
    //     break;
    //   case 'Week':
    //     data = dataApi;
    //     labels = labelsApi;
    //     break;
    //   case 'Month':
    //     data = dataApi;
    //     labels = labelsApi;
    //     break;
    //   case 'Year':
    //     data = dataApi;
    //     labels = labelsApi;
    //     break;
    //   default:
    //     data = dataApi;
    //     labels = labelsApi;
    // }
    super.onInit();
  }


  void setActiveButton(String buttonName) {
    activeButton = buttonName;
    if(buttonName=="day"){activeButton="";}
    update();
  }

  Future<void> fetchGraphData() async {
    try {

      var url = Uri.parse("http://algor.somee.com/api/GraphData/$activeButton");
      print('active button= $activeButton');
      var token = myServices.sharedPreferences
          .getString(SharedPreferencesKeys.tokenKey);
      print("tokenn=$token");
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
           'Authorization': 'Bearer $token',
          // 'Authorization': 'Bearer ',
        },
      );

      print(response.statusCode);
      print(jsonDecode(response.body));
      var responseDecode = json.decode(response.body);
      print("responseDecode= $responseDecode");
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        graphModel = GraphModel.fromJson(responseDecode);
        print("new graphModel = $graphModel");
        // dataApi=graphModel.dataPoints;
        // labelsApi=graphModel.labels;
        // print("list dataApi =$dataApi");
        // print('list labelsApi=$labelsApi');
        isLoading = false;

        update();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error catch: $error");
    }
    update();
  }
}
