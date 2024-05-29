class GetPinnedModel {
  final String id;
  final String text;
  final String sender;
  final String? dateTime;
  final bool? isPin;
  final bool? isSeen;

  GetPinnedModel({
    required this.id,
    required this.text,
    required this.sender,
    this.dateTime,
    this.isPin,
    this.isSeen,
  });

  factory GetPinnedModel.fromJson(Map<String, dynamic> json) {
    return GetPinnedModel(
      id: json['id'],
      text: json['text'],
      sender: json['sender'],
      dateTime: json['dateTime'],
      isPin: json['isPin'],
      isSeen: json['isSeen'],
    );
  }
}
