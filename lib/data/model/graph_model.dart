class GraphModel {
  GraphModel({
    required this.dataPoints,
    required this.labels,
  });

  final List<int> dataPoints;
  final List<String> labels;

  factory GraphModel.fromJson(Map<String, dynamic> json){
    return GraphModel(
      dataPoints: json["dataPoints"] == null ? [] : List<int>.from(json["dataPoints"]!.map((x) => x)),
      labels: json["labels"] == null ? [] : List<String>.from(json["labels"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "dataPoints": dataPoints.map((x) => x).toList(),
    "labels": labels.map((x) => x).toList(),
  };

}
