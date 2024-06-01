import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/core/service/service.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/all_users/model/all_users_model.dart';

class AllUsersController extends GetxController {
  var isLoading = true.obs;
  var allUsers = <AllUsers>[].obs;
  MyServices myServices = Get.find<MyServices>();

  @override
  void onInit() {
    fetchAllUsers();
    super.onInit();
  }

  Future<void> fetchAllUsers() async {
    String? token = myServices.getToken();

    try {
      var url = Uri.parse('http://algor.somee.com/api/Chat/AllUsers');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<AllUsers> fetchedUsers =
            data.map((user) => AllUsers.fromJson(user)).toList();
        allUsers.assignAll(fetchedUsers);
      } else {
        Get.snackbar('Error', 'Failed to fetch users');
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to fetch users');
    } finally {
      isLoading(false);
    }
  }
}
