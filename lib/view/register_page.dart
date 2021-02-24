import 'package:accessibility/components/Utils.dart';
import 'package:accessibility/components/aira_app_bar.dart';
import 'package:accessibility/components/text_size.dart';
import 'package:accessibility/controller/register_page.dart';
import 'package:accessibility/model/Country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  final allCountries = Country.asList();
  final controller = Get.put(RegisterPageController(), permanent: true);
  final nameFN = FocusNode();
  final emailFN = FocusNode();
  final countryFN = FocusNode();
  final phoneFN = FocusNode();

  final List<DropdownMenuItem<Country>> countryList = [];

  @override
  Widget build(BuildContext context) {
    double containerWidth = Get.width * .9;
    double containerHeight = 60;
    double _spacerWidth = 10;
    double fwRatio = containerWidth / 2.1;
    if(containerWidth < 200) {
      fwRatio = containerWidth;
    }
    nameFN.addListener(() {if(nameFN.hasFocus && GetPlatform.isWeb) {
      airaAnnounce(controller.name.value.isBlank? "Enter full name":controller.name.value);
    }});
    //final userService = Get.find<UserService>();
    return Scaffold(
        appBar: AiraAppBar(
          titleIn: "Registration page",
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Semantics(
                excludeSemantics: true,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    "Welcome to Aira",
                    style: TextStyle(fontSize: AiraTextSize.getLarge()),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  "Please register",
                  style: TextStyle(fontSize: AiraTextSize.get()),
                ),
              ),
              Container(
                  width: containerWidth,
                  //height: containerHeight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Wrap(direction: Axis.horizontal, children: [
                      Container(
                        width: fwRatio,
                        child: TextFormField(
                          maxLength: 50,
                          onChanged: (v) => controller.name.value = v,
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          minLines: 1,
                          focusNode: nameFN,
                          decoration: InputDecoration(
                              labelText: "Name", hintText: "Enter full name"),
                        ),
                      ),
                      Container(width: _spacerWidth),
                      Container(
                        width: fwRatio,
                        child: TextFormField(
                          maxLength: 50,
                          onChanged: (v) => controller.email.value = v,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          minLines: 1,
                          focusNode: emailFN,
                          decoration: InputDecoration(labelText: "Email", hintText: "Enter email address"),
                        ),
                      ),
                    ]),
                  )),
              Container(
                width: containerWidth,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Wrap( children: [
                    Container(
                      width: fwRatio,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 25.0),
                            child: Text("Select Country"),
                          ),
                          DropdownButton<Country>(
                              focusNode: countryFN,
                              elevation: 3,
                              hint: Obx(() => controller.country.value.getKey().isBlank
                                  ? Text("")
                                  : Text(controller.country.value.getKey())),
                              onChanged: (value) {
                                controller.country.value = value;
                              },
                              items: _getCountryMenu()),
                        Obx(() => controller.country.value.getKey().isBlank?Text(""):
                            Text(controller.country.value.getCode())),
                        ],
                      ),
                    ),
                    Container(width: _spacerWidth),
                    Container(
                      width: fwRatio,
                      child: TextFormField(
                        maxLength: 15,
                        onChanged: (v) => controller.phoneNumber.value = v,
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        minLines: 1,
                        focusNode: phoneFN,
                        decoration: InputDecoration(labelText: "Phone Number", hintText: "Enter phone number"),
                      ),
                    ),
                  ]),
                ),
              ),
              Container(
                width: containerWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text("Register"),
                        onPressed: _register,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  List<DropdownMenuItem<Country>> _getCountryMenu() {
    if (countryList.length == 0) {
      Country.asList().forEach((element) {
        countryList.add(DropdownMenuItem<Country>(child: Text(element.getKey()), value: element));
      });
    }
    return countryList;
  }

  void _register() {
    // do validations.
    if(controller.name.value.isBlank) {
      airaAnnounce("Name field cannot be blank");
     airaErrorSnackbar("Input error", "Name field cannot be blank");
      nameFN.requestFocus();
      return;
    }
    // check email
    if(controller.email.value.isBlank) {
      airaAnnounce("Email cannot be blank");
      airaErrorSnackbar("Missing email", "Email must be provided");
      emailFN.requestFocus();
      return;
    }
    if(!controller.email.value.isEmail) {
      airaAnnounce("Enter a valid email address");
      airaErrorSnackbar("Email error", "Email address is not valid");
      emailFN.requestFocus();
      return;
    }
  }
}
