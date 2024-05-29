class GetFavedModel {
  int? id;
  String? sender;
  String? receiver;
  String? text;
  String? imageUrl;
  String? audioUrl;
  bool? isSeen;
  bool? favourite;
  bool? isPin;

  GetFavedModel(
      {this.id,
      this.sender,
      this.receiver,
      this.text,
      this.imageUrl,
      this.audioUrl,
      this.isSeen,
      this.favourite,
      this.isPin,
     });

  GetFavedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = json['sender'];
    receiver = json['receiver'];
    text = json['text'];
    imageUrl = json['imageUrl'];
    audioUrl = json['audioUrl'];
    isSeen = json['isSeen'];
    favourite = json['favourite'];
    isPin = json['isPin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender'] = this.sender;
    data['receiver'] = this.receiver;
    data['text'] = this.text;
    data['imageUrl'] = this.imageUrl;
    data['audioUrl'] = this.audioUrl;
    data['isSeen'] = this.isSeen;
    data['favourite'] = this.favourite;
    data['isPin'] = this.isPin;
    return data;
  }
}
