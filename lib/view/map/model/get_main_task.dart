class MainTask {
  int? id;
  String? userId;
  String? title;
  String? description;
  String? lat;
  String? lng;
  List<dynamic>? tasks;

  MainTask({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.lat,
    this.lng,
    this.tasks,
  });

  MainTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    description = json['description'];
    lat = json['lat'];
    lng = json['lng'];
    tasks = json['tasks'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['title'] = title;
    data['description'] = description;
    data['lat'] = lat;
    data['lng'] = lng;
    if (tasks != null) {
      data['tasks'] = tasks;
    }
    return data;
  }
}
