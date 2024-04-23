import 'package:flutter/material.dart';
import 'package:time_status/data/model/chat_model.dart';
import 'package:time_status/view/chatting/screens/chats/widgets/chats_item_widget.dart';
import 'package:time_status/view/chatting/screens/chats_screen/widgets/chats_item_widget.dart';

import '../../../../core/constant/color.dart';


class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor:AppColor.fromHex('#EDE7FF'),
      body:    ListView.builder(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemsList.length,
        itemBuilder: (context, index) {
          final item = ChatModel.fromJson(itemsList[index]);
          return ItemWidget(item);
        },
      ),
    );
  }
}
