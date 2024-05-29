import 'package:flutter/material.dart';
import '../../../../../../core/constant/color.dart';
import 'widgets/chats_item_widget.dart';

class OneToOneChats extends StatelessWidget {
  OneToOneChats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.fromHex('#EDE7FF'),
      body:  OneToOneChatItem(), 
    );
  }
}
