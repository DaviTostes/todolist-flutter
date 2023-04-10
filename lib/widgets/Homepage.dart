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
  User userSave = User();
  User userLoad = User();

  String task = '';
  List tasks = [];

  final TextEditingController _textFieldController = TextEditingController();
  void _clearField() {
    _textFieldController.clear();
  }

  void handleDeleteTask(taskName) {
    setState(() {
      for (int i = 0; i < tasks.length; i++) {
        if (tasks[i].task == taskName) {
          tasks.removeAt(i);
        }
      }
    });
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
                      if (tasks.isNotEmpty) {
                        tasks.singleWhere((element) => element.task == task,
                            orElse: () => setState(() {
                                  tasks.add(CheckBoxWidget(
                                    task: task,
                                    handleDeleteTask: handleDeleteTask,
                                  ));
                                  sharedPref.save('tasks', userSave);
                                }));
                      } else {
                        setState(() {
                          tasks.add(CheckBoxWidget(
                            task: task,
                            handleDeleteTask: handleDeleteTask,
                          ));
                          sharedPref.save('tasks', userSave);
                        });
                      }
                    }
                  },
                  child: const Icon(Icons.add)),
            ),
            Container(height: 20),
            Column(
              children: [...tasks],
            )
          ]),
        ),
      ),
    );
  }
}
