import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/controller/StatusController.dart';

import '../../components/EditDeleteTask.dart';
import '../../controller/BackGroundController.dart';
import '../../controller/TaskController.dart';
import '../../modals/TaskModal.dart';
import '../../utils/ColorUtils.dart';

class AllImportant extends StatelessWidget {
  const AllImportant({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(Provider.of<BGController>(context).getBgImage[1]),
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
                                  11,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      Provider.of<BGController>(context,
                                              listen: false)
                                          .SetBgImage(
                                              path:
                                                  'assets/images/theme/theme${index + 1}.jpg',
                                              index: 1);
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
                "Important Task",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
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
                          print(tm.important);
                          return (tm.important == "True")
                              ? Card(
                                  child: Consumer<StatusController>(
                                      builder: (context, p, _) {
                                    p.StatusChanged(s: tm.status);
                                    p.ImportantChanged(i: tm.important);
                                    return ListTile(
                                      onLongPress: () {
                                        editDeleteTask(
                                          context: context,
                                          index: index,
                                          tm: tm,
                                        );
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
                                          isLiked: (tm.status == "Done"),
                                          likeBuilder: (isLiked) {
                                            (isLiked)
                                                ? tm.status = "Done"
                                                : tm.status = "NotDone";
                                            print("Action : ${tm.status}");
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
                                          onTap: (isLiked) async {
                                            (!isLiked)
                                                ? p.ImportantChanged(i: "True")
                                                : p.ImportantChanged(
                                                    i: "False");
                                            tm.important = p.Important;
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
                                          isLiked: (tm.important == "True"),
                                          likeBuilder: (isLiked) {
                                            (isLiked)
                                                ? p.ImportantChanged(i: "True")
                                                : p.ImportantChanged(
                                                    i: "False");
                                            tm.important = p.Important;
                                            print("Action : ${tm.important}");
                                            pro.editTask(
                                                task: tm, index: index);
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
  }
}
