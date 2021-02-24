import 'package:accessibility/model/Country.dart';
import 'package:get/get.dart';

class RegisterPageController {
  var name = "".obs;
  var email = "".obs;
  var country = Country("","").obs;
  var phonePrefix = "".obs;
  var phoneNumber = "".obs;

  String getPhoneNumber() {
    if(phonePrefix.isBlank || phoneNumber.isBlank)
      return "N/A";
    return phonePrefix.value + phoneNumber.value;
  }

}
