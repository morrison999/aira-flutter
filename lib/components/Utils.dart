import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

void airaAnnounce(String text) {
  SemanticsService.announce(text, TextDirection.ltr,);
}
void airaErrorSnackbar(String title, [String message= ""]) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM, backgroundColor: ThemeData().errorColor);
}
