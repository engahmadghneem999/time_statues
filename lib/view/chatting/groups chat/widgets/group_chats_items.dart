import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/view/chatting/groups%20chat/widgets/in_group_chat.dart';

import '../model/groups_get_chats_moderl.dart';


class GroupChatsItemWidget extends StatelessWidget {
  final GetGroupsChatsModel item;

  const GroupChatsItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.group, color: Colors.white),
          ),
          title: Text(
            item.name ?? 'No name',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('ID: ${item.id ?? 'No ID'}'),
          trailing: Icon(Icons.arrow_forward, color: Colors.blue),
          onTap: () {
            Get.to(InGroupChatScreen(
              chatId: item.id!,
            ));

            // Handle navigation to other chat screens
          }),
    );
  }
}
