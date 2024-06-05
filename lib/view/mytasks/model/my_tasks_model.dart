class TasksModel {
  int? id;
  String? userId;
  String? title;
  String? description;
  String? lat;
  String? lng;
  List<Tasks>? tasks;

  TasksModel(
      {this.id,
      this.userId,
      this.title,
      this.description,
      this.lat,
      this.lng,
      this.tasks});

  TasksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    description = json['description'];
    lat = json['lat'];
    lng = json['lng'];
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(new Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    if (this.tasks != null) {
      data['tasks'] = this.tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasks {
  int? id;
  String? icon;
  String? timer;
  String? color;
  String? status;
  int? mainTaskId;
  String? lat;
  String? lng;

  Tasks(
      {this.id,
      this.icon,
      this.timer,
      this.color,
      this.status,
      this.mainTaskId,
      this.lat,
      this.lng});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    timer = json['timer'];
    color = json['color'];
    status = json['status'];
    mainTaskId = json['mainTaskId'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['timer'] = this.timer;
    data['color'] = this.color;
    data['status'] = this.status;
    data['mainTaskId'] = this.mainTaskId;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}