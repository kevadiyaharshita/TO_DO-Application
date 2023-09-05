import 'package:flutter/cupertino.dart';
import 'package:to_do_application/utils/ColorUtils.dart';

import '../../controller/PlatformController.dart';

class IosAddTaskPage extends StatelessWidget {
  const IosAddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Add Task"),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 90, horizontal: 16),
        child: Container(
          height: 300,
          width: w,
          padding: EdgeInsets.all(18),
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // border: Border.all(color: color1),
            color: CupertinoColors.extraLightBackgroundGray,
          ),
          child: Column(
            children: [
              Text("Add Your Task Here"),
              SizedBox(
                height: 15,
              ),
              CupertinoTextField(),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
