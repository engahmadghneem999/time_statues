class Message {
  final String? text;
  final String sender;
  final DateTime timestamp;
  final String? imageUrl;
final String? audio;

  Message({
      this.text,
    required this.sender,
    required this.timestamp,
      this.imageUrl,
       this.audio
  });
}