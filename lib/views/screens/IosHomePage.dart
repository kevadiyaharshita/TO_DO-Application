import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/components/Ios_addTaskDialog.dart';

import '../../controller/PlatformController.dart';
import '../../utils/MyRoutes.dart';
import '../../utils/TextStyle.dart';

class IosHomePage extends StatelessWidget {
  IosHomePage({super.key});

  TextEditingController taskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double w = s.width;
    double h = s.height;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("To-Do App"),
        trailing: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(MyIOSRoutes.IosSettingPage);
          },
          child: Icon(
            CupertinoIcons.settings,
            size: 25,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 80, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(MyIOSRoutes.IosAllToDay);
                },
                child: Container(
                  width: w,
                  height: 50,
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.moon_stars),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "My Day",
                        style: menuTextStyle,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(MyIOSRoutes.IosAllImportant);
                },
                child: Container(
                  width: w,
                  height: 50,
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.staroflife),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Important",
                        style: menuTextStyle,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(MyIOSRoutes.IosAllTaskPage);
                },
                child: Container(
                  width: w,
                  height: 50,
                  child: Row(
                    children: [
                      Icon(Icons.add_task),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Task",
                        style: menuTextStyle,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Image(
                  image: AssetImage('assets/images/To do list-pana.png'),
                  height: 280,
                ),
              ),
              Center(
                child: Text(
                  "Click on + Button To Add Task",
                  style: menuTextStyle,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child: CupertinoButton.filled(
                  child: Text("Add Task"),
                  onPressed: () {
                    // Navigator.of(context).pushNamed(MyIOSRoutes.addTaskPage);
                    IosAddTaskDialouge(
                        context: context,
                        taskController: taskController,
                        navigate: true);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
