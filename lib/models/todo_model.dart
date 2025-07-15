class Todo {
  final String title;
  final String description;

  Todo({required this.title, required this.description});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(title: json['title'], description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description};
  }
}
