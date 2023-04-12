class User {
  User({required this.tasks});

  List tasks = [];
  bool isDarkTheme = false;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(tasks: json['tasks'] as List);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tasks'] = tasks;
    return data;
  }
}
