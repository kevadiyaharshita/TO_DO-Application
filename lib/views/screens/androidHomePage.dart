import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/controller/addTaskDialog.dart';
import 'package:to_do_application/utils/MyRoutes.dart';
import 'package:to_do_application/utils/TextStyle.dart';

import '../../controller/PlatformController.dart';
import '../../controller/ThemeController.dart';
import '../../utils/ColorUtils.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController taskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    double redius = 200;
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(MyRoutes.AndroidSettingPage);
            },
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(MyRoutes.allToday);
                },
                splashColor: Colors.grey,
                child: Container(
                  width: w,
                  height: 50,
                  child: Row(
                    children: [
                      Icon(Icons.light_mode_outlined),
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
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(MyRoutes.allImportant);
                },
                splashColor: Colors.grey,
                child: Container(
                  width: w,
                  height: 50,
                  child: Row(
                    children: [
                      Icon(Icons.star_border_purple500_outlined),
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
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(MyRoutes.allTask);
                },
                splashColor: Colors.grey,
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
              Image(
                image: AssetImage('assets/images/todo1.png'),
                height: 280,
              ),
              Text(
                "Click on + Button To Add Task",
                style: menuTextStyle,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          addTaskDialogbox(
              context: context, taskController: taskController, navigate: true);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
