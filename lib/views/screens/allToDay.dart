import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/controller/DateTimeController.dart';

import '../../components/EditDeleteTask.dart';
import '../../controller/BackGroundController.dart';
import '../../controller/StatusController.dart';
import '../../controller/TaskController.dart';
import '../../modals/TaskModal.dart';
import '../../utils/ColorUtils.dart';

class AllToDay extends StatelessWidget {
  const AllToDay({super.key});

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
    DateTime todaydate = DateTime.now();
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Provider.of<BGController>(context).getBgImage[2]),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      height: 200,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                  4,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      Provider.of<BGController>(context,
                                              listen: false)
                                          .SetBgImage(
                                              path:
                                                  'assets/images/theme/theme${index + 1}.jpg',
                                              index: 2);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 80,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
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
                icon: Icon(Icons.menu))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Day",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              // SizedBox(height: 5,),
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
                  child: Consumer<TaskController>(
                    builder: (context, pro, _) {
                      return ListView.builder(
                        itemCount: pro.allTaskList.length,
                        itemBuilder: (context, index) {
                          TaskModal tm = pro.allTaskList[index];
                          DateTime ld = DateTime.now();
                          return (tm.date == "${ld.day}/${ld.month}/${ld.year}")
                              ? Card(
                                  child: Consumer<StatusController>(
                                      builder: (context, p, _) {
                                    p.StatusChanged(s: tm.status);
                                    // print("Status ${p.Status}");
                                    return ListTile(
                                      onLongPress: () {
                                        editDeleteTask(
                                            context: context,
                                            index: index,
                                            tm: tm);
                                      },
                                      leading: Container(
                                        width: 50,
                                        height: 50,
                                        child: LikeButton(
                                          size: 45,
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
                                              print(
                                                  "Exception finally handled");
                                            }

                                            return await !isLiked;
                                          },
                                          isLiked: (p.Status == "Done"),
                                          likeBuilder: (isLiked) {
                                            (isLiked)
                                                ? p.StatusChanged(s: "Done")
                                                : p.StatusChanged(s: "NotDone");

                                            pro.editTask(
                                                task: tm, index: index);
                                            return Icon(
                                              (isLiked)
                                                  ? Icons.check_circle
                                                  : Icons.circle_outlined,
                                              color: isLiked
                                                  ? color1
                                                  : Colors.grey,
                                            );
                                          },
                                        ),
                                      ),
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
                                      trailing: Container(
                                        width: 50,
                                        height: 50,
                                        child: LikeButton(
                                          size: 45,
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
                                                  ? Icons.star
                                                  : Icons.star_border_outlined,
                                              color: isLiked
                                                  ? color1
                                                  : Colors.grey,
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              : SizedBox();
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
