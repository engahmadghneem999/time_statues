class PinnedMessage {
  final int id;
  final String sender;
  final String receiver;
  final String text;
  final String imageUrl;
  final String audioUrl;
  final bool isSeen;
  final bool favourite;
  final bool isPin;
  final DateTime dateTime;

  PinnedMessage({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.text,
    required this.imageUrl,
    required this.audioUrl,
    required this.isSeen,
    required this.favourite,
    required this.isPin,
    required this.dateTime,
  });

  factory PinnedMessage.fromJson(Map<String, dynamic> json) {
    return PinnedMessage(
      id: json['id'],
      sender: json['sender'],
      receiver: json['receiver'],
      text: json['text'],
      imageUrl: json['imageUrl'],
      audioUrl: json['audioUrl'],
      isSeen: json['isSeen'],
      favourite: json['favourite'],
      isPin: json['isPin'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}
