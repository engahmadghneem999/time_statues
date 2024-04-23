import 'package:flutter/material.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:time_status/core/constant/color.dart';
import '../../../data/model/Message.dart';

class Favorites extends StatelessWidget {
  Favorites({Key? key, required this.categoryMessages}) : super(key: key);

  final Map<String, List<Message>> categoryMessages;

  @override
  Widget build(BuildContext context) {
    List<String> categories = categoryMessages.keys.toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.appgreen,
        title: Text('Messages Favorites'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          String category = categories[index];
          List<Message> messages = categoryMessages[category] ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: messages.length,
                itemBuilder: (context, msgIndex) {
                  Message message = messages[msgIndex];
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      // Remove the item from the data source
                      _deleteMessage(category, message);

                      // Show a snackbar with the undo option
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Message deleted'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Add the item back to the data source
                              _addMessageToCategory(category, message, context);
                            },
                          ),
                        ),
                      );
                    },
                    child: BubbleSpecialOne(
                      text: message.text!,
                      // Add other UI elements as needed for each message
                    ),
                  );
                },
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }

  void _deleteMessage(String category, Message message) {
    // Implement your logic to delete the message from the data source
    // Update the state or call any necessary methods
  }

  void _addMessageToCategory(String category, Message message, BuildContext context) {
    // Implement your logic to add the message back to the data source
    // Update the state or call any necessary methods
  }
}
