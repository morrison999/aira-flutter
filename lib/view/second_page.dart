import 'package:accessibility/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                child: Text("Back"),
                onPressed: () => Get.offAll(HomePage()),
              ),
            ],
          ),
        )
      ),
    );
  }

}