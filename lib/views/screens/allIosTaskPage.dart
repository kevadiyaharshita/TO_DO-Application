import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/controller/StatusController.dart';
import 'package:to_do_application/modals/TaskModal.dart';

import '../../controller/BackGroundController.dart';
import '../../controller/TaskController.dart';
import '../../utils/ColorUtils.dart';

class AllIosTaskPage extends StatelessWidget {
  const AllIosTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Provider.of<BGController>(context).getBgImage[2]),
            fit: BoxFit.fill),
      ),
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.quaternarySystemFill,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.quaternarySystemFill,
          trailing: CupertinoButton(
            onPressed: () {},
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
                "All Task",
                style: TextStyle(
                    fontSize: 35,
                    color: CupertinoColors.white,
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
                          return Card(
                            child: Consumer<StatusController>(
                                builder: (context, p, _) {
                              p.StatusChanged(s: tm.status);
                              return CupertinoListTile(
                                // onTap: () {
                                //   showCupertinoDialog(
                                //     context: context,
                                //     builder: (context) => CupertinoAlertDialog(
                                //       title: Text("hhhh"),
                                //     ),
                                //   );
                                // },
                                // leadingSize: 50,
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
                                      pro.editTask(task: tm, index: index);
                                    } catch (e) {
                                      print("ExceptionHandled Succesfully");
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
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      color: isLiked ? color1 : Colors.grey,
                                    );
                                  },
                                ),
                                trailing: Row(
                                  children: [
                                    CupertinoButton(
                                        child: Icon(CupertinoIcons.add),
                                        onPressed: () {}),
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
                                            print("Exception finally handled");
                                          }
                                          return Icon(
                                            (isLiked)
                                                ? Icons.star
                                                : Icons.star_border_outlined,
                                            color:
                                                isLiked ? color1 : Colors.grey,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          );
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
