class Message {
  final String? sender;
  final String? receiver;
  final String? text;
  final String? imageUrl;
  final String? audioUrl;
  final bool? isSeen;
  final DateTime? timestamp;

  Message({this.receiver,
    this.sender,
    this.text,
    this.imageUrl,
    this.audioUrl,
    this.isSeen,
    this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json["sender"] ?? "",
      receiver: json["receiver"] ?? "",
      text: json["text"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      audioUrl: json["audioUrl"] ?? "",
      isSeen: json["isSeen"] ?? false,
      timestamp: DateTime.parse(json["dateTime"]),
      //json["dateTime"]??DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        "sender": sender,
    "receiver": receiver,
        "text": text,
        "imageUrl": imageUrl,
        "audioUrl": audioUrl,
        "isSeen": isSeen,
        "dateTime": timestamp,
      };
}

// class Message {
//   final String? text;
//   final String sender;
//   final DateTime timestamp;
//   final String? imageUrl;
// final String? audio;
// final bool? isSeen;
//
//   Message( {
//       this.text,
//     required this.sender,
//     required this.timestamp,
//       this.imageUrl,
//        this.audio, this.isSeen,
//   });
//
// }
