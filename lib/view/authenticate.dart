import 'package:accessibility/components/aira_app_bar.dart';
import 'package:accessibility/components/text_size.dart';
import 'package:accessibility/view/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/Utils.dart';

class AuthenticationPage extends StatelessWidget {
  final rows = 5;
  final columns = 4;
  final rowHeight = 40.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AiraAppBar(titleIn: "Welcome Page"),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 400.0,
                height: rows*rowHeight,
                child: GridView.count(
                  childAspectRatio: 2,
                  crossAxisCount: columns,
                  children: List<Widget>.generate(rows*columns, (index) {
                    return Container(
                        height: rowHeight,
                        child: ElevatedButton(
                          onPressed: () => buttonPressed(index),
                          child: Text("${index+1}")),
                      );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  "Welcome to Aira",
                  style: TextStyle(fontSize: AiraTextSize.getLarge()),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Login",),
                      onPressed: _dummy,
                    ),
                  ),
                  Text("or",
                      style: TextStyle(fontSize: AiraTextSize.getSmall())),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Register"),
                      onPressed: _toRegisterPage,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void _toRegisterPage() {
    Get.to(RegisterPage());
  }

  void _dummy() {
    Get.defaultDialog(
        title: "Unsupported", middleText: "Function not implemented");
  }

  buttonPressed(int index) {
    airaAnnounce("You pressed button ${index+1}");
    Get.snackbar("You pressed Button ${index+1}", "",
        snackPosition: SnackPosition.BOTTOM);
  }
}
