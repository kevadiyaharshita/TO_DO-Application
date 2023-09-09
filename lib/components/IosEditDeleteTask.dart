import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/DateTimeController.dart';
import '../controller/TaskController.dart';
import '../controller/ThemeController.dart';
import '../modals/TaskModal.dart';

void ios_editDeleteTask(
    {required BuildContext context,
    required TaskModal tm,
    required int index}) {
  TextEditingController taskController = TextEditingController(text: tm.task);
  Provider.of<DateTimeController>(context, listen: false)
      .dateConverter(date: tm.date);
  Provider.of<DateTimeController>(context, listen: false)
      .timeConvertor(time: tm.time);
  showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            actions: [
              Consumer<DateTimeController>(builder: (context, p, _) {
                return Consumer<DateTimeController>(builder: (context, p, _) {
                  return CupertinoButton(
                    child: Text("EDIT"),
                    onPressed: () {
                      bool notNull = taskController.text == "" ? false : true;
                      if (notNull) {
                        TaskModal task = TaskModal(
                            task: taskController.text,
                            date: "${p.d!.day}/${p.d!.month}/${p.d!.year}",
                            time:
                                "${p.t!.hour == 0 ? '12' : p.t!.hour % 12}:${p.t!.minute}:${p.t!.hour >= 12 ? 'PM' : 'AM'}",
                            status: tm.status,
                            important: tm.important);

                        bool check =
                            Provider.of<TaskController>(context, listen: false)
                                .editTask(task: task, index: index);

                        p.resetDate();
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: (check)
                        //         ? Text("Task Edited Succesfully..")
                        //         : Text("Failed To Saved..!!"),
                        //     behavior: SnackBarBehavior.floating,
                        //     duration: Duration(seconds: 2),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //     margin: EdgeInsets.all(10),
                        //     dismissDirection: DismissDirection.horizontal,
                        //   ),
                        // );
                        Navigator.of(context).pop();
                      }
                    },
                  );
                });
              }),
              CupertinoButton(
                child: Text("DELETE"),
                onPressed: () {
                  Provider.of<TaskController>(context, listen: false)
                      .deleteTask(index: index);
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
                        subtitle: Text(
                            "${pro.d!.day}/${pro.d!.month}/${pro.d!.year}"),
                        trailing: CupertinoButton(
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoActionSheet(
                                title: Text("Pick Date"),
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
                          child: Icon(CupertinoIcons.calendar),
                        ),
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
          ));
}
