import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modals/TaskModal.dart';
import '../utils/MyRoutes.dart';
import 'DateTimeController.dart';
import 'TaskController.dart';
import 'ThemeController.dart';

void addTaskDialogbox({
  required BuildContext context,
  required TextEditingController taskController,
  required bool navigate,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        "Add Task",
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<ThemeController>(builder: (context, pro, _) {
            return TextFormField(
              controller: taskController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Enter Name",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    // width: 2,
                    color: pro.getTheme ? Colors.grey : Colors.black54,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: pro.getTheme ? Colors.grey : Colors.black54,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: pro.getTheme ? Colors.white : Colors.black54,
                  ),
                ),
              ),
            );
          }),
          SizedBox(
            height: 15,
          ),
          Consumer<ThemeController>(builder: (context, pro, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: pro.getTheme ? Colors.white : Colors.black54,
                      width: 1,
                    ),
                  ),
                  child:
                      Consumer<DateTimeController>(builder: (context, pro, _) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("${pro.d!.day}/${pro.d!.month}/${pro.d!.year}"),
                        ElevatedButton.icon(
                          onPressed: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: pro.d!,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                Duration(days: 365),
                              ),
                            );
                            if (date != null) {
                              pro.dateChanged(dateTime: date);
                            }
                          },
                          icon: Icon(Icons.date_range),
                          label: Text("Date"),
                        ),
                      ],
                    );
                  }),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: pro.getTheme ? Colors.white : Colors.black54,
                      width: 1,
                    ),
                  ),
                  child: Consumer<DateTimeController>(builder: (context, p, _) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            "${p.t!.hour == 0 ? '12' : p.t!.hour % 12}:${p.t!.minute}:${p.t!.hour >= 12 ? 'PM' : 'AM'}"),
                        ElevatedButton.icon(
                          onPressed: () async {
                            TimeOfDay? t = await showTimePicker(
                              context: context,
                              initialTime: p.t ?? TimeOfDay.now(),
                            );
                            if (t != null) {
                              p.timeChanged(time: t);
                            }
                          },
                          icon: Icon(Icons.access_time),
                          label: Text("Time"),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            );
          }),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Consumer<DateTimeController>(
                builder: (context, p, _) {
                  return OutlinedButton(
                    onPressed: () {
                      bool notNull = taskController.text == "" ? false : true;
                      if (notNull) {
                        TaskModal task = TaskModal(
                          task: taskController.text,
                          // date: p.d!.toString(),
                          date: "${p.d!.day}/${p.d!.month}/${p.d!.year}",
                          time:
                              "${p.t!.hour == 0 ? '12' : p.t!.hour % 12}:${p.t!.minute}:${p.t!.hour >= 12 ? 'PM' : 'AM'}",
                          status: "NotDone",
                          important: "False",
                        );

                        bool check =
                            Provider.of<TaskController>(context, listen: false)
                                .addTask(t1: task);

                        p.resetDate();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: (check)
                                ? Text("Task Added Succesfully..")
                                : Text("Failed To Saved..!!"),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: EdgeInsets.all(10),
                            dismissDirection: DismissDirection.horizontal,
                          ),
                        );
                        Navigator.of(context).pop();
                        if (navigate) {
                          Navigator.of(context).pushNamed(MyRoutes.allTask);
                        }
                      }
                    },
                    child: Text("SAVE"),
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("CANCEL"),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
