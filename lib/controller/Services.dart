import 'package:accessibility/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Services {
  // load everything you need before screens load...
  static Future<void> init() async {
    await Storage.init();
    UserService();
  }
}

class Storage {
  Box _box;
  static init() async {
    await Hive.initFlutter();
    var store = Storage();
    store._box = await Hive.openBox("airaBox");
    Get.put<Storage>(store);
    debugPrint("Storage initialized");
  }

  Box getBox() {
    return _box;
  }
}


