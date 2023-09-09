import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/PlatformController.dart';
import '../../controller/ThemeController.dart';
import '../../utils/ColorUtils.dart';

class IosSettingPage extends StatelessWidget {
  const IosSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    int platform_index =
        Provider.of<PlatformController>(context).getPlatformConverter ? 0 : 1;
    int theme_index = Provider.of<ThemeController>(context).getTheme ? 1 : 0;
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("SettingPage"),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 80),
          child: Column(
            children: [
              CupertinoListTile(
                title: Text("Platform"),
                subtitle: Text("Change Platform"),
                leading: Icon(Icons.apple),
                trailing:
                    Consumer<PlatformController>(builder: (context, pro, _) {
                  return CupertinoSlidingSegmentedControl(
                    children: {
                      0: Icon(Icons.apple),
                      1: Icon(Icons.android),
                    },
                    groupValue: platform_index,
                    thumbColor: CupertinoColors.white,
                    onValueChanged: (index) {
                      platform_index = index!;
                      pro.changePlatform();
                    },
                  );
                }),
              ),
              Divider(),
              CupertinoListTile(
                title: Text("Theme"),
                subtitle: Text("Change Theme"),
                leading: Icon(CupertinoIcons.sun_min_fill),
                trailing: Consumer<ThemeController>(builder: (context, pro, _) {
                  return CupertinoSlidingSegmentedControl(
                    children: {
                      0: Icon(CupertinoIcons.sun_min),
                      1: Icon(CupertinoIcons.moon_fill),
                    },
                    groupValue: theme_index,
                    thumbColor: CupertinoColors.white,
                    onValueChanged: (index) {
                      platform_index = index!;
                      pro.changeTheme();
                    },
                  );
                }),
              ),
            ],
          ),
        ));
  }
}
