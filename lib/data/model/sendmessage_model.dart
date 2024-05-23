class SendMessageModel {
  SendMessageModel({
    required this.receiver,
    required this.text,
    required this.imageUrl,
    required this.audioUrl,
  });

  final String? receiver;
  final String? text;
  final String? imageUrl;
  final String? audioUrl;

  factory SendMessageModel.fromJson(Map<String, dynamic> json){
    return SendMessageModel(
      receiver: json["receiver"],
      text: json["text"],
      imageUrl: json["imageUrl"],
      audioUrl: json["audioUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
    "receiver": receiver,
    "text": text,
    "imageUrl": imageUrl,
    "audioUrl": audioUrl,
  };

}
