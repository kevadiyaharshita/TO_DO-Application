import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/components/IosEditDeleteTask.dart';
import 'package:to_do_application/controller/StatusController.dart';
import 'package:to_do_application/modals/TaskModal.dart';

import '../../controller/BackGroundController.dart';
import '../../controller/TaskController.dart';
import '../../controller/ThemeController.dart';
import '../../utils/ColorUtils.dart';

class AllIosTodayTask extends StatelessWidget {
  const AllIosTodayTask({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> Month = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    List<String> day = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thusrday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Provider.of<BGController>(context).getBgImage[0]),
            fit: BoxFit.fill),
      ),
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.quaternarySystemFill,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.quaternarySystemFill,
          trailing: CupertinoButton(
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => Container(
                  height: 200,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "Change BackGround",
                        style: TextStyle(fontSize: 18),
                      ),
                      Divider(),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              11,
                              (index) => GestureDetector(
                                onTap: () {
                                  Provider.of<BGController>(context,
                                          listen: false)
                                      .SetBgImage(
                                          path:
                                              'assets/images/theme/theme${index + 1}.jpg',
                                          index: 0);
                                },
                                child: Container(
                                  height: 100,
                                  width: 80,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: CupertinoColors.systemGrey,
                                        offset: Offset(2, 2),
                                        blurRadius: 5,
                                      )
                                    ],
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/theme/theme${index + 1}.jpg'),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              );
            },
            child: Icon(
              CupertinoIcons.ellipsis_vertical,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 80, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Day",
                style: TextStyle(
                    fontSize: 35,
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${Month[(DateTime.now().month) - 1]}, ${day[(DateTime.now().weekday) - 1]} ${DateTime.now().day}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(
                  child: Consumer<TaskController>(builder: (context, pro, _) {
                    return SingleChildScrollView(
                      child: Column(
                          children: List.generate(
                        pro.allTaskList.length,
                        (index) {
                          TaskModal tm = pro.allTaskList[index];
                          DateTime ld = DateTime.now();
                          return (tm.date == "${ld.day}/${ld.month}/${ld.year}")
                              ? Card(
                                  color: Provider.of<ThemeController>(context,
                                              listen: false)
                                          .getTheme
                                      ? CupertinoColors.label.withOpacity(0.8)
                                      : null,
                                  child: Consumer<StatusController>(
                                      builder: (context, p, _) {
                                    p.StatusChanged(s: tm.status);
                                    return CupertinoListTile(
                                      title: Text(
                                        tm.task,
                                        style: TextStyle(
                                            decoration: (p.Status == "Done")
                                                ? TextDecoration.lineThrough
                                                : null,
                                            fontSize: 18),
                                      ),
                                      subtitle: Text(
                                        "${tm.date},${tm.time}",
                                        style: TextStyle(
                                          decoration: (p.Status == "Done")
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),
                                      leading: LikeButton(
                                        size: 25,
                                        onTap: (isLiked) async {
                                          (!isLiked)
                                              ? p.StatusChanged(s: "Done")
                                              : p.StatusChanged(s: "NotDone");
                                          tm.status = p.Status;
                                          try {
                                            pro.editTask(
                                                task: tm, index: index);
                                          } catch (e) {
                                            print(
                                                "ExceptionHandled Succesfully");
                                          } finally {
                                            print("Exception finally handled");
                                          }

                                          return await !isLiked;
                                        },
                                        isLiked: (p.Status == "Done"),
                                        likeBuilder: (isLiked) {
                                          (isLiked)
                                              ? p.StatusChanged(s: "Done")
                                              : p.StatusChanged(s: "NotDone");

                                          pro.editTask(task: tm, index: index);
                                          return Icon(
                                            (isLiked)
                                                ? CupertinoIcons
                                                    .checkmark_circle_fill
                                                : CupertinoIcons.circle,
                                            color: isLiked
                                                ? color1
                                                : CupertinoColors
                                                    .secondaryLabel,
                                          );
                                        },
                                      ),
                                      trailing: Row(
                                        children: [
                                          CupertinoButton(
                                              child: Icon(
                                                  CupertinoIcons.wand_rays),
                                              onPressed: () {
                                                ios_editDeleteTask(
                                                    context: context,
                                                    tm: tm,
                                                    index: index);
                                              }),
                                          Container(
                                            width: 50,
                                            height: 50,
                                            child: LikeButton(
                                              size: 25,
                                              isLiked: (tm.important == "True"),
                                              likeBuilder: (isLiked) {
                                                (isLiked)
                                                    ? tm.important = "True"
                                                    : tm.important = "False";
                                                // print("Action : ${tm.important}");
                                                try {
                                                  pro.editTask(
                                                      task: tm, index: index);
                                                } catch (e) {
                                                  print(
                                                      "ExceptionHandled Succesfully");
                                                } finally {
                                                  print(
                                                      "Exception finally handled");
                                                }
                                                return Icon(
                                                  (isLiked)
                                                      ? CupertinoIcons.star_fill
                                                      : CupertinoIcons.star,
                                                  color: isLiked
                                                      ? color1
                                                      : CupertinoColors
                                                          .inactiveGray,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                )
                              : SizedBox();
                        },
                      )),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
