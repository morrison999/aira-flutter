import 'package:accessibility/components/aira_app_bar.dart';
import 'package:accessibility/components/text_size.dart';
import 'package:accessibility/view/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_page.dart';

class AuthenticationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AiraAppBar(titleIn: "Welcome Page"),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                      child: Text("Login"),
                      onPressed: _dummy,
                    ),
                  ),
                  Text("or", style: TextStyle(fontSize: AiraTextSize.getSmall())),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(child: Text("Register"),
                      onPressed: _toRegisterPage,),
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
    Get.defaultDialog(title: "Unsupported",middleText: "Function not implemented");
  }
}
