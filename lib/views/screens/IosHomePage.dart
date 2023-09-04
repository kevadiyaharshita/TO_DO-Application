import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../controller/PlatformController.dart';

class IosHomePage extends StatelessWidget {
  const IosHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("HomePage"),
        trailing: Consumer<PlatformController>(
          builder: (context, pro, _) {
            return CupertinoSwitch(
              onChanged: (val) {
                pro.changePlatform();
              },
              value: pro.getPlatformConverter,
            );
          },
        ),
      ),
      child: Center(
        child: Text("Heloo IOS"),
      ),
    );
  }
}
