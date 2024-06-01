import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/all_users/controller/all_users_controller.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/all_users/model/all_users_model.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/one_to_one_chatting_screen/widgets/in_one_to_one_chat_page.dart';

class AllUsersPage extends StatelessWidget {
  final AllUsersController allUsersController = Get.put(AllUsersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Users'.tr),
        backgroundColor: AppColor.appbargreen,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: UserSearchDelegate(allUsersController.allUsers),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (allUsersController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (allUsersController.allUsers.isEmpty) {
          return Center(child: Text('No users found'.tr));
        } else {
          return ListView.builder(
            itemCount: allUsersController.allUsers.length,
            itemBuilder: (context, index) {
              final user = allUsersController.allUsers[index];
              return InkWell(
                onTap: () {
                  String userId = user.id ?? "";
                  String userName = user.username ?? "";
                  Get.to(
                    () => InChatScreen(userId: userId, userName: userName),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.person,
                          color: Colors.grey[600],
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.username ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}

class UserSearchDelegate extends SearchDelegate<String> {
  final List<AllUsers> allUsersList;

  UserSearchDelegate(this.allUsersList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<AllUsers> filteredList = allUsersList
        .where((user) =>
            user.username?.toLowerCase().contains(query.toLowerCase()) ?? false)
        .toList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final AllUsers user = filteredList[index];
        return ListTile(
          title: Text(
            user.username ?? '',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            String userId = user.id ?? "";
            String userName = user.username ?? "";
            Get.to(
              () => InChatScreen(userId: userId, userName: userName),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<AllUsers> suggestionList = allUsersList
        .where((user) =>
            user.username?.toLowerCase().contains(query.toLowerCase()) ?? false)
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final AllUsers user = suggestionList[index];
        return ListTile(
          title: Text(
            user.username ?? '',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            String userId = user.id ?? "";
            String userName = user.username ?? "";
            Get.to(
              () => InChatScreen(userId: userId, userName: userName),
            );
          },
        );
      },
    );
  }
}
