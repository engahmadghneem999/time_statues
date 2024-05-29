
import '../../../../../../data/model/Message.dart';

List<Message> sortedMessages(List<dynamic> messages, String? userId) {
  List<Message> senderMessages = [];
  List<Message> yourMessages = [];

  // Filter messages into senderMessages and yourMessages
  for (var message in messages) {
    if (message.sender == userId) {
      yourMessages.add(message);
    } else {
      senderMessages.add(message);
    }
  }

  // Sort messages individually
  senderMessages.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
  yourMessages.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));

  // Concatenate senderMessages and yourMessages
  return [...senderMessages, ...yourMessages];
}