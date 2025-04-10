import 'package:get/get.dart';

validInput(String val, String type, int max, int min) {
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "Not valid Email".tr;
    }
  }
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "Not valid Username".tr;
    }
  }
  if (val.isEmpty) {
    return "Cant't Empty".tr;
  }
  if (val.length > max) {
    return "${"Cant larger than".tr} $max";
  }
  if (val.length < min) {
    return "${"Cant latest than".tr}$min";
  }
}
