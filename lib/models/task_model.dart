class TaskModel {
  String? id;
  String title;
  String description;
  String date;
  String category;
  bool status;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.status,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"] ?? "",
        title: json["title"],
        description: json["description"],
        date: json["date"],
        category: json["category"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "date": date,
        "category": category,
        "status": status,
      };
}