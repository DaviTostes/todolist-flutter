import 'package:flutter/material.dart';
import 'package:todolist/widgets/CheckBox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
                                }));
                      } else {
                        setState(() {
                          tasks.add(CheckBoxWidget(
                            task: task,
                            handleDeleteTask: handleDeleteTask,
                          ));
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
