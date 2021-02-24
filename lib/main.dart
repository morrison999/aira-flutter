import 'package:accessibility/view/authenticate.dart';
import 'package:accessibility/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'controller/Services.dart';
import 'model/user.dart';


///
/// This program is used for testing cross platform UI issues.
/// Add new widgets or screens to test new features
///

void main() {
  Services.init().then((void v) {
    runApp(MyApp());
  }
  );

}

class MyApp extends StatelessWidget {
  UserService userService = Get.find<UserService>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Accessibility Demo',
      home: userService.user.value.loggedIn? HomePage() : AuthenticationPage(),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    );
  }
}

