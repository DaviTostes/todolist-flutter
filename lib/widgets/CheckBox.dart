import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {
  const CheckBoxWidget({super.key, required this.task});
  final String task;

  @override
  State<CheckBoxWidget> createState() => CheckBoxState();
}

class CheckBoxState extends State<CheckBoxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadiusDirectional.all(Radius.circular(10)),
            color: isChecked ? Colors.green : Colors.red,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    widget.task,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }),
              ],
            ),
          ),
        ),
        Container(
          height: 10,
        )
      ],
    );
  }
}
