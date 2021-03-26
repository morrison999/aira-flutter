import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

Future<void> airaAnnounce(String text) async {
  await SemanticsService.announce(text, TextDirection.ltr,);
}
void airaErrorSnackbar(String title, [String message= ""]) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM, backgroundColor: ThemeData().errorColor);
}
