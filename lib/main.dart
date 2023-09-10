import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_application/controller/SplashScreenController.dart';
import 'package:to_do_application/controller/TaskController.dart';
import 'package:to_do_application/utils/ColorUtils.dart';
import 'package:to_do_application/utils/MyRoutes.dart';
// import 'package:to_do_application/views/screens/IosAddTaskPage.dart';
import 'package:to_do_application/views/screens/IosHomePage.dart';
import 'package:to_do_application/views/screens/IosSettingPage.dart';
import 'package:to_do_application/views/screens/SplashScreen.dart';
import 'package:to_do_application/views/screens/allImportant.dart';
import 'package:to_do_application/views/screens/allIosImportantTask.dart';
import 'package:to_do_application/views/screens/allIosTaskPage.dart';
import 'package:to_do_application/views/screens/allIosTodayTask.dart';
import 'package:to_do_application/views/screens/allTaskPage.dart';
import 'package:to_do_application/views/screens/allToDay.dart';
import 'package:to_do_application/views/screens/androidHomePage.dart';
import 'package:to_do_application/views/screens/androidSetting.dart';

import 'controller/BackGroundController.dart';
import 'controller/DateTimeController.dart';
import 'controller/PlatformController.dart';
import 'controller/StatusController.dart';
import 'controller/ThemeController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeController(preferences: preferences),
        ),
        ChangeNotifierProvider(
          create: (context) => PlatformController(preferences: preferences),
        ),
        ChangeNotifierProvider(
          create: (context) => SplashScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DateTimeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TaskController(preferences: preferences),
        ),
        ChangeNotifierProvider(
          create: (context) => StatusController(),
        ),
        ChangeNotifierProvider(
          create: (context) => BGController(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return (Provider.of<PlatformController>(context).getPlatformConverter)
        ? CupertinoApp(
            debugShowCheckedModeBanner: false,
            theme: CupertinoThemeData(
              primaryColor: color1,
              brightness: (Provider.of<ThemeController>(context).getTheme)
                  ? Brightness.dark
                  : Brightness.light,
            ),
            initialRoute:(Provider.of<SplashScreenController>(context).getSplash)? MyIOSRoutes.SplashScreen :MyIOSRoutes.home,
            routes: {
              MyIOSRoutes.home: (context) => IosHomePage(),
              MyIOSRoutes.IosAllTaskPage: (context) => AllIosTaskPage(),
              // MyIOSRoutes.addTaskPage: (context) => IosAddTaskPage(),
              MyIOSRoutes.IosAllImportant: (context) => AllImportantTask(),
              MyIOSRoutes.IosAllToDay: (context) => AllIosTodayTask(),
              MyIOSRoutes.IosSettingPage: (context) => IosSettingPage(),
              MyIOSRoutes.SplashScreen: (context) => SplashScreen(),
            },
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorSchemeSeed: color1,
              useMaterial3: true,
              appBarTheme: AppBarTheme(
                centerTitle: true,
                // backgroundColor: color1,
                // foregroundColor: Colors.white
              ),
            ),
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                colorSchemeSeed: color1,
                useMaterial3: true,
                appBarTheme: AppBarTheme(
                  centerTitle: true,
                )),
            themeMode: Provider.of<ThemeController>(context).getTheme
                ? ThemeMode.dark
                : ThemeMode.light,
            initialRoute:(Provider.of<SplashScreenController>(context).getSplash)? MyRoutes.SplashScreen : MyRoutes.home,
            routes: {
              MyRoutes.home: (context) => HomePage(),
              MyRoutes.AndroidSettingPage: (context) => AndroidSettingPage(),
              MyRoutes.SplashScreen: (context) => SplashScreen(),
              MyRoutes.allTask: (context) => AllTask(),
              MyRoutes.allImportant: (context) => AllImportant(),
              MyRoutes.allToday: (context) => AllToDay(),
            },
          );
  }
}
