class User {
  User();

  late List tasks;
  late bool isDarkTheme;

  User.fromJson(Map<String, dynamic> json)
      : tasks = json['tasks'],
        isDarkTheme = json['isDarkTheme'];

  Map<String, dynamic> toJson() => {'tasks': tasks, 'isDarkTheme': isDarkTheme};
}
