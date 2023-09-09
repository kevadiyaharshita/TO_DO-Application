import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/utils/MyRoutes.dart';

import '../controller/DateTimeController.dart';
import '../controller/TaskController.dart';
import '../controller/ThemeController.dart';
import '../modals/TaskModal.dart';

void IosAddTaskDialouge(
    {required BuildContext context,
    required TextEditingController taskController,
    required bool navigate}) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      actions: [
        Consumer<DateTimeController>(builder: (context, p, _) {
          return CupertinoButton(
            child: Text("ADD"),
            onPressed: () {
              bool notNull = taskController.text == "" ? false : true;
              if (notNull) {
                TaskModal task = TaskModal(
                  task: taskController.text,
                  date: "${p.d!.day}/${p.d!.month}/${p.d!.year}",
                  time:
                      "${p.t!.hour == 0 ? '12' : p.t!.hour % 12}:${p.t!.minute}:${p.t!.hour >= 12 ? 'PM' : 'AM'}",
                  status: "NotDone",
                  important: "False",
                );

                bool check = Provider.of<TaskController>(context, listen: false)
                    .addTask(t1: task);

                p.resetDate();
                Navigator.of(context).pop();
                if (navigate) {
                  Navigator.of(context).pushNamed(MyIOSRoutes.IosAllTaskPage);
                }
              }
            },
          );
        }),
        CupertinoButton(
          child: Text("CANCEL"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
      title: Text("Add Task"),
      content: Consumer<DateTimeController>(builder: (context, pro, _) {
        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            CupertinoTextField(
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(5),
              // ),
              placeholder: "Enter Task",
              controller: taskController,
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<ThemeController>(builder: (context, pr, _) {
              return Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: CupertinoColors.systemGrey.withOpacity(0.5),
                      width: 0.3),
                ),
                child: CupertinoListTile(
                  backgroundColor: pr.getTheme
                      ? CupertinoColors.black
                      : CupertinoColors.secondarySystemGroupedBackground,
                  title: Text(
                    "Date",
                    style: TextStyle(
                        color: pr.getTheme
                            ? CupertinoColors.white
                            : CupertinoColors.label),
                  ),
                  subtitle:
                      Text("${pro.d!.day}/${pro.d!.month}/${pro.d!.year}"),
                  trailing: CupertinoButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                            title: Text(
                              "Pick Date",
                              style: TextStyle(fontSize: 20),
                            ),
                            message: SizedBox(
                              height: 250,
                              child: CupertinoDatePicker(
                                initialDateTime: DateTime.now(),
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged: (date) {
                                  Provider.of<DateTimeController>(context,
                                          listen: false)
                                      .dateChanged(dateTime: date);
                                },
                              ),
                            ),
                            actions: [
                              CupertinoButton(
                                  child: Text("Set"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              isDestructiveAction: true,
                              child: Text("Cancel"),
                            ),
                          ),
                        );
                      },
                      child: Icon(CupertinoIcons.calendar)),
                ),
              );
            }),
            SizedBox(
              height: 10,
            ),
            Consumer<ThemeController>(builder: (context, pr, _) {
              return Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: CupertinoColors.systemGrey.withOpacity(0.5),
                      width: 0.3),
                ),
                child: CupertinoListTile(
                  backgroundColor: pr.getTheme
                      ? CupertinoColors.black
                      : CupertinoColors.secondarySystemGroupedBackground,
                  title: Text(
                    "Time",
                    style: TextStyle(
                        color: pr.getTheme
                            ? CupertinoColors.white
                            : CupertinoColors.label),
                  ),
                  subtitle: Text(
                      "${pro.t!.hour == 0 ? '12' : pro.t!.hour % 12}:${pro.t!.minute}:${pro.t!.hour >= 12 ? 'PM' : 'AM'}"),
                  trailing: CupertinoButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                            title: Text("Pick Time"),
                            message: SizedBox(
                              height: 250,
                              child: CupertinoDatePicker(
                                initialDateTime: DateTime(
                                    0, 0, 0, pro.t!.hour, pro.t!.minute),
                                mode: CupertinoDatePickerMode.time,
                                onDateTimeChanged: (time) {
                                  // Provider.of<DateTime_Controller>(context,listen: false).timeChanged(time: TimeOfDay.fromDateTime(time));
                                  pro.timeChanged(
                                      time: TimeOfDay.fromDateTime(time));
                                },
                              ),
                            ),
                            actions: [
                              CupertinoButton(
                                  child: Text("Set"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              isDestructiveAction: true,
                              child: Text("Cancel"),
                            ),
                          ),
                        );
                      },
                      child: Icon(CupertinoIcons.time)),
                ),
              );
            }),
          ],
        );
      }),
    ),
  );
}
