import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/PlatformController.dart';
import '../../controller/ThemeController.dart';

class AndroidSettingPage extends StatelessWidget {
  const AndroidSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settig"),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer<PlatformController>(builder: (context, pro, _) {
              return Switch(
                value: pro.getPlatformConverter,
                onChanged: (val) {
                  pro.changePlatform();
                },
              );
            }),
            Consumer<ThemeController>(builder: (context, pro, _) {
              return Switch(
                  value: pro.getTheme,
                  onChanged: (val) {
                    pro.changeTheme();
                  });
            }),
          ],
        ),
      ),
    );
  }
}
