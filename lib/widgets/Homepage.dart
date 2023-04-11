import 'package:flutter/material.dart';
import 'package:todolist/instance.dart';
import 'package:todolist/share_pref.dart';
import 'package:todolist/widgets/CheckBox.dart';
import 'package:todolist/app_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  SharedPref sharedPref = SharedPref();
  User userSave = User(tasks: []);
  User userLoad = User(tasks: []);

  String task = '';

  loadSharedPrefs() async {
    try {
      List tasks = await sharedPref.read('tasks');
      setState(() {
        userLoad.tasks = tasks;
        print(tasks);
      });
    } catch (error) {
      print(error);
    }
  }

  final TextEditingController _textFieldController = TextEditingController();
  void _clearField() {
    _textFieldController.clear();
  }

  void handleDeleteTask(taskName) {
    setState(() {
      for (int i = 0; i < userLoad.tasks.length; i++) {
        if (userLoad.tasks[i] == taskName) {
          sharedPref.remove(userLoad.tasks[i]);
          loadSharedPrefs();
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    userSave.tasks = userLoad.tasks;
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
        actions: [
          Switch(
              value: AppController.instance.isDarkTheme,
              onChanged: (value) {
                setState(() {
                  AppController.instance.changeTheme();
                });
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextField(
              controller: _textFieldController,
              onChanged: (text) {
                task = text;
              },
              decoration: const InputDecoration(
                  labelText: 'Type your task here',
                  border: OutlineInputBorder()),
            ),
            Container(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () {
                    _clearField();

                    if (task != '') {
                      if (userSave.tasks.isNotEmpty) {
                        userSave.tasks.singleWhere((element) => element == task,
                            orElse: () => setState(() {
                                  userSave.tasks.add(task);
                                  sharedPref.save('tasks', [...userSave.tasks]);
                                  loadSharedPrefs();
                                }));
                      } else {
                        setState(() {
                          userSave.tasks.add(task);
                          sharedPref.save('tasks', [...userSave.tasks]);
                          loadSharedPrefs();
                        });
                      }
                    }
                  },
                  child: const Icon(Icons.add)),
            ),
            Container(height: 20),
            Column(
              children: [
                ...userLoad.tasks.map((e) =>
                    CheckBoxWidget(task: e, handleDeleteTask: handleDeleteTask))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
