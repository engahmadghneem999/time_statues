
class ModelChat {
  ModelChat({
    required this.userId,
    required this.userName,
    required this.messageTime,
    required this.message,
  });

  final String? userId;
  final String? userName;
  final DateTime? messageTime;
  final String? message;

  factory ModelChat.fromJson(Map<String, dynamic> json){
    return ModelChat(
      userId: json["userId"],
      userName: json["userName"],
      messageTime: DateTime.tryParse(json["messageTime"] ?? ""),
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userName": userName,
    "messageTime": messageTime?.toIso8601String(),
    "message": message,
  };

}

