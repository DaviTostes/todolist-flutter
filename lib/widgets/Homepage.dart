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
                    if (task != '') {
                      setState(() {
                        tasks.add(Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadiusDirectional.all(
                                    Radius.circular(10)),
                                color: Colors.green,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [Text(task), const CheckBoxWidget()],
                              ),
                            ),
                            Container(
                              height: 10,
                            )
                          ],
                        ));
                      });
                    }
                  },
                  child: const Icon(Icons.add)),
            ),
            Container(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [...tasks],
            )
          ]),
        ),
      ),
    );
  }
}
