class UserChatModel {
  UserChatModel({
    required this.sender,
    required this.text,
    required this.imageUrl,
    required this.audioUrl,
    required this.isSeen,
  });

  final String? sender;
  final String? text;
  final String? imageUrl;
  final String? audioUrl;
  final bool? isSeen;

  factory UserChatModel.fromJson(Map<String, dynamic> json){
    return UserChatModel(
      sender: json["sender"],
      text: json["text"],
      imageUrl: json["imageUrl"],
      audioUrl: json["audioUrl"],
      isSeen: json["isSeen"],
    );
  }

  Map<String, dynamic> toJson() => {
    "sender": sender,
    "text": text,
    "imageUrl": imageUrl,
    "audioUrl": audioUrl,
    "isSeen": isSeen,
  };

}
