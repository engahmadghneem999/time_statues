class GetGroupsChatsModel {
  int? id;
  String? name;
  List<dynamic>? users; 

  GetGroupsChatsModel({this.id, this.name, this.users});

  GetGroupsChatsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['users'] != null) {
      users = <dynamic>[]; 
      json['users'].forEach((v) {
        users!.add(v); 
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (users != null) {
      data['users'] = users; 
    }
    return data;
  }
}
