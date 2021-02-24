import 'dart:math';

import 'package:accessibility/controller/Services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Country.dart';

class User {
  bool loggedIn = false;
  String name = "";
  String email = "";
  String phone = "";
  Country country = Country(null,null);
  void fromStore(User stored) {
    if(stored != null) {
      loggedIn = stored.loggedIn;
      name = stored.name;
      email = stored.email;
      phone = stored.phone;
      country = stored.country;
    }
  }
}

class UserService {
  final user = User().obs;

  UserService() {
    Get.put<UserService>(this);
  }

  bool saveUser() {
    var s = Get.find<Storage>();
    s.getBox().put("user",user);
    return true;
  }
  Future<User> loadUser() async {
    var s = Get.find<Storage>();
    var u = await s.getBox().get("user");
    if(u != null) {
      user.value.fromStore(u);
    }
  }
}
