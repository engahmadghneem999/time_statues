class MyFollowingsModel {
  String? id;
  String? username;

  MyFollowingsModel({this.id, this.username});

  MyFollowingsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}
