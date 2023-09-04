import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/controller/PlatformController.dart';
import 'package:to_do_application/controller/SplashScreenController.dart';
import 'package:to_do_application/controller/ThemeController.dart';

import '../../utils/MyRoutes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    changepage() {
      Timer.periodic(Duration(seconds: 4), (timer) {
        Navigator.of(context).pushReplacementNamed(
            (Provider.of<PlatformController>(context, listen: false)
                    .getPlatformConverter)
                ? MyIOSRoutes.home
                : MyRoutes.home);
        Provider.of<SplashScreenController>(context).changeSplash();
        timer.cancel();
      });
    }

    changepage();
    return Consumer<ThemeController>(builder: (context, pro, _) {
      return Scaffold(
        body: Center(
          child: Image(
            image: AssetImage((pro.getTheme)
                ? 'assets/images/dark_theme.gif'
                : 'assets/images/Light_theme.gif'),
          ),
        ),
        backgroundColor: pro.getTheme ? Color.fromRGBO(25, 24, 24, 1) : null,
      );
    });
  }
}
