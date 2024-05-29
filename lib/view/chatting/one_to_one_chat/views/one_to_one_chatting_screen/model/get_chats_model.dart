class getchats {
  String? userId;
  String? userName;
  String? messageTime;
  String? message;

  getchats({this.userId, this.userName, this.messageTime, this.message});

  getchats.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    messageTime = json['messageTime'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['messageTime'] = this.messageTime;
    data['message'] = this.message;
    return data;
  }
}