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
        title: Text("Setting"),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              leading: Container(
                height: 50,
                width: 30,
                alignment: Alignment.center,
                child: Icon(Icons.android),
              ),
              title: Text(
                "Platform",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Change Platform",
              ),
              trailing:
                  Consumer<PlatformController>(builder: (context, pro, _) {
                return Switch(
                  value: pro.getPlatformConverter,
                  onChanged: (val) {
                    pro.changePlatform();
                  },
                );
              }),
            ),
            Divider(),
            ListTile(
              leading: Container(
                height: 50,
                width: 30,
                alignment: Alignment.center,
                child: Icon(Icons.light_mode),
              ),
              title: Text(
                "Theme",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Change Theme",
              ),
              trailing: Consumer<ThemeController>(builder: (context, pro, _) {
                return Switch(
                    value: pro.getTheme,
                    onChanged: (val) {
                      pro.changeTheme();
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
